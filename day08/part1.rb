class VisibleTrees
    def initialize(input_path)
        @input_path = input_path
        @rows = []
        parse_input
    end

    def parse_input
        File.readlines(@input_path).each do |line|
            @rows << line.strip.chars.map(&:to_i)
        end
        init_start_values
    end

    def init_start_values
        @width = @rows[0].size
        @visible_trees = @rows.map do |row|
            Array.new(@width, 0)
        end
    end

    def init_max_column_heights
        @max_column_heights = Array.new(@width, -1)
    end

    def init_max_row_height
        @max_row_height = -1
    end

    def set_visible_for_tree(tree, index, visible)
        visible[index] = 1 if tree > @max_row_height
        @max_row_height = tree if tree > @max_row_height
        visible[index] = 1 if tree > @max_column_heights[index]
        @max_column_heights[index] = tree if tree > @max_column_heights[index]
    end

    def parse_row_forward(row, row_index)
        visible = @visible_trees[row_index]
        init_max_row_height
        row.each_with_index do |tree, index|
            set_visible_for_tree(tree, index, visible)
        end
    end

    def parse_row_backwards(row, row_index)
        visible = @visible_trees[row_index]
        init_max_row_height
        row.each_with_index.reverse_each do |tree, index|
            set_visible_for_tree(tree, index, visible)
        end
    end

    def run
        init_max_column_heights

        # Get Left and Top sides
        @rows.each_with_index do |row, index|
            parse_row_forward(row, index)
        end

        init_max_column_heights
        
        # Get Right and Bottom sides
        @rows.each_with_index.reverse_each do |row,index|
            parse_row_backwards(row, index)
        end

        # Sum all the trees marked as visible(1)
        pp @visible_trees.sum(&:sum)
    end
end

trees = VisibleTrees.new("input")
trees.run