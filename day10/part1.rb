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

    def signal_strengths
        [20, 60, 100, 140, 180, 220].sum do |num|
            num * @cycles[num - 1]
        end
    end

    def run
        parse_input_into_cycles
        p signal_strengths
    end
end

cpu = CPU.new("input")
cpu.run