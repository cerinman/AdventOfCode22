require 'set'

round_requirements = {
    # Lose
    X: {
        "points": 0,
        "A" => "C",
        "B" => "A",
        "C" => "B"
    },
    # Draw
    Y: {
        "points": 3,
        "A" => "A",
        "B" => "B",
        "C" => "C"
    },
    # Win
    Z: {
        "points": 6,
        "A" => "B",
        "B" => "C",
        "C" => "A"
    }
}

shape_point_map = {
    "A" => 1,
    "B" => 2,
    "C" => 3,
}

all_rounds_total = File.readlines('input')
    .map(&:strip)
    .reduce(0) do |acc, current|
        round = current.split(" ")
        round_requirement = round_requirements[round[1].to_sym]
        acc += round_requirement[:points]
        acc += shape_point_map[round_requirement[round[0]]]
        acc
    end

    pp "You scored #{all_rounds_total} points for all the rounds!" 