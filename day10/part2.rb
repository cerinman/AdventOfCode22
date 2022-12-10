class CPU
    def initialize(file_path)
        @input = parse_input(file_path)
        @cycles = [1]
    end

    def parse_input(file_path)
        File.readlines(file_path).map(&:split)
    end

    def parse_input_into_cycles
        @input.each do |instruction|
            @cycles << @cycles.last
            if instruction[0] == "addx"
                @cycles << @cycles.last + instruction[1].to_i 
            end
        end
    end

    def draw_screen
        @cycles.each_with_index.map do |cycle, index|
            surrounding = [cycle - 1, cycle, cycle + 1]
            surrounding.include?(index % 40) ? "#" : "."
        end.each_slice(40) do |slice|
            pp slice.join
        end
    end

    def run
        parse_input_into_cycles
        draw_screen
    end
end

cpu = CPU.new("input")
cpu.run