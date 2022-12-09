class ScenicScoreCalculator
    def initialize(input_path)
        @input_path = input_path
        @rows = []
        parse_input
    end

    def parse_input
        File.readlines(@input_path).each do |line|
            @rows << line.strip.chars.map(&:to_i)
        end
        init_scenic_scores
    end

    def init_scenic_scores
        @scenic_scores = @rows.map do |row|
            Array.new(row.size, 0)
        end
    end

    def left(row_index, col_index)
        score = 0
        the_tree = @rows[row_index][col_index]
        (col_index - 1).downto(0).each do |num|
            this_tree = @rows[row_index][num]
            break score +=1 if this_tree >= the_tree
            score += 1
        end
        score
    end

    def right(row_index, col_index)
        score = 0
        the_tree = @rows[row_index][col_index]
        (col_index + 1..@rows[row_index].size - 1).each do |num|
            this_tree = @rows[row_index][num]
            break score +=1 if this_tree >= the_tree
            score += 1
        end
        score
    end

    def up(row_index, col_index)
        score = 0
        the_tree = @rows[row_index][col_index]
        (row_index - 1).downto(0).each do |num|
            this_tree = @rows[num][col_index]
            break score +=1 if this_tree >= the_tree
            score += 1
        end
        score
    end

    def down(row_index, col_index)
        score = 0
        the_tree = @rows[row_index][col_index]
        (row_index + 1..@rows.size - 1).each do |num|
            this_tree = @rows[num][col_index]
            break score +=1 if this_tree >= the_tree
            score += 1
        end
        score
    end

    def calc_tree_score(row_index, tree_index)
        [
            left(row_index, tree_index),
            right(row_index, tree_index),
            up(row_index, tree_index),
            down(row_index, tree_index)
        ]
    end

    def run
        @rows.each_with_index do |row, row_index|
            row.each_with_index do |tree, tree_index|
                @scenic_scores[row_index][tree_index] = calc_tree_score(row_index, tree_index).reduce(1) do |total, score|
                    total *= score
                end
            end
        end

        highest_score = @scenic_scores.map(&:max).max

        pp highest_score
    end
end

score_calculator = ScenicScoreCalculator.new("input")
score_calculator.run