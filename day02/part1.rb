require 'set'

hand_shape_map = {
    X: {
        # win, tie, lose
        outcome_order: ["C", "A", "B"],
        name: "rock",
    },
    Y: {
        # win, tie, lose
        outcome_order: ["A", "B", "C"],
        name: "paper",
    },
    Z: {
        # win, tie, lose
        outcome_order: ["B", "C", "A"],
        name: "scissors",
    }
}

point_map = {
    :round_points => {
        0 => 6,
        1 => 3,
        2 => 0,
    },
    :shape_points => {
        "rock" => 1,
        "paper" => 2,
        "scissors" => 3,
    },
}

all_rounds_total = File.readlines('input')
    .map(&:strip)
    .reduce(0) do |acc, current|
        round = current.split(" ")
        my_play = hand_shape_map[round[1].to_sym]
        acc += point_map[:shape_points][my_play[:name]]
        acc += point_map[:round_points][my_play[:outcome_order].index(round[0])]
        acc
    end

    # "You scored 13565 points for all the rounds!"
    pp "You scored #{all_rounds_total} points for all the rounds!" 