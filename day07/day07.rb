require_relative "directory"

class DaySeven
    def initialize(input_path)
        @root_directory = Directory.new
        @directories = [@root_directory]
        @input_path = input_path
        parse_input
    end

    def size_of_directory_to_delete
        @root_directory.find_directory_to_delete
    end

    def sum_small_directories
        @root_directory.sum_directories_within_threshold
    end

private

    def read_input
        File.readlines(@input_path).map(&:strip)
    end

    def parse_command(command_info)
        case command_info[2]
        when ".."
            @directories.pop
        else
            return if command_info[2] == "/"
            @directories << @directories.last.get_sub_directory_by_name(command_info[2])
        end
    end

    def parse_input
        read_input.each do |line|
            next if line.include?("$ ls")
            parse_line(line)
        end
    end

    def parse_line(line)
        split_line = line.split(" ")

        case split_line[0]
        when "$"
            parse_command(split_line)
        when "dir"
            @directories.last.add_sub_directory(split_line[1])
        else
            @directories.last.add_file(split_line[1], split_line[0].to_i)
        end
    end
end

part_one = DaySeven.new("input")
pp part_one.sum_small_directories
part_two = DaySeven.new("input")
pp part_two.size_of_directory_to_delete