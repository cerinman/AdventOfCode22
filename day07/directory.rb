class Directory
    attr_accessor :directory_size, :files, :sub_directories

    def initialize
        @directory_size = 0
        @files = []
        @sub_directories = {}
    end
    
    def add_file(name, size)
        @directory_size += size
        @files << name
    end

    def add_sub_directory(name)
        @sub_directories[name] = Directory.new
    end

    def find_directory_to_delete
        total = 70000000
        space_used = get_directory_size
        available = 70000000 - space_used
        needed_to_update = 30000000
        options = get_directory_sizes(needed_to_update - available)
        options.first
    end

    def get_directory_size
        directory_size + sum_sub_directories
    end

    def get_directory_sizes(needed_to_update)
        directories = []
        directories << get_directory_size if get_directory_size > needed_to_update
        sub_directories.values.each do |dir|
            directories.concat(dir.get_directory_sizes(needed_to_update))
        end
        directories.sort
    end

    def sum_directories_within_threshold
        threshold = 100000
        sum = 0
        sum += get_directory_size if get_directory_size <= threshold
        sum += sub_directories.values.sum do |dir|
            dir.sum_directories_within_threshold
        end
        sum
    end

    def get_sub_directory_by_name(name)
        sub_directories[name]
    end

    def sum_sub_directories()
        sub_directories.values.sum do |dir|
            dir.get_directory_size
        end
    end
end