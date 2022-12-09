require 'set'

class MotionSimulator
    def initialize(input_path)
        @moves = parse_input(input_path)
        @current_head = [0,0]
        @current_tail = [0,0]
        @tail_visited = ["0,0"]
    end

    def parse_input(input_path)
        File.readlines(input_path).map(&:strip).map(&:split)
    end

    def right(distance)
        distance.times do
            @current_head[1] += 1
            if @current_head[1] - @current_tail[1] > 1
                @current_tail[1] += 1
                @current_tail[0] = @current_head[0]
                @tail_visited << @current_tail.join(",")
            end
        end
    end

    def left(distance)
        distance.times do
            @current_head[1] -= 1
            if @current_tail[1] - @current_head[1] > 1
                @current_tail[1] -= 1
                @current_tail[0] = @current_head[0]
                @tail_visited << @current_tail.join(",")
            end
        end
    end

    def up(distance)
        distance.times do
            @current_head[0] += 1
            if @current_head[0] - @current_tail[0] > 1
                @current_tail[0] += 1
                @current_tail[1] = @current_head[1]
                @tail_visited << @current_tail.join(",")
            end
        end
    end

    def down(distance)
        distance.times do
            @current_head[0] -= 1
            if @current_tail[0] - @current_head[0] > 1
                @current_tail[0] -= 1
                @current_tail[1] = @current_head[1]
                @tail_visited << @current_tail.join(",")
            end
        end
    end

    def run
        @moves.each do |move|
            case move[0]
            when "R"
                right(move[1].to_i)
            when "L"
                left(move[1].to_i)
            when "U"
                up(move[1].to_i)
            when "D"
                down(move[1].to_i)
            end
        end

        pp Set.new(@tail_visited).size
    end
end

simulator = MotionSimulator.new("input")
simulator.run