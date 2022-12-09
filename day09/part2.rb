require 'set'

class MotionSimulator
    def initialize(input_path)
        @moves = parse_input(input_path)
        @knots = Array.new(10) { [0,0] }
        @tail_visited = ["0,0"]
    end

    def parse_input(input_path)
        File.readlines(input_path).map(&:strip).map(&:split)
    end

    def add_coords_to_visited(knot)
        @tail_visited << knot.join(",")
    end

    def move_head(direction)
        case direction
        when "L"
            @knots[0][1] -= 1
        when "R"
            @knots[0][1] += 1
        when "U"
            @knots[0][0] += 1
        when "D"
            @knots[0][0] -= 1
        end
    end

    def move_knot(knot, index)
        previous_knot = @knots[index - 1]

        return unless (previous_knot[0] - knot[0]).abs > 1 || (previous_knot[1] - knot[1]).abs > 1

        knot[0] += (previous_knot[0] <=> knot[0])
        knot[1] += (previous_knot[1] <=> knot[1])
        
        if index == 9
            add_coords_to_visited(knot)
        end
    end

    def run
        @moves.each do |move|
            direction, distance = move
            distance.to_i.times do
                move_head(direction)
                @knots.each_with_index do |knot, index|
                    if index > 0
                        move_knot(knot, index)
                    end
                end
            end
        end

        pp Set.new(@tail_visited).size
    end
end

simulator = MotionSimulator.new("input")
simulator.run