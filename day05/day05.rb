def file_input
    File.readlines("input")
end

def unparsed_input_rows
    input = file_input
    input.slice(0..input.index("\n") - 2)
end

def parsed_input_rows
    regex = /[\[ ](?<letter>[A-Z ])[\] ] ?/
    unparsed_input_rows.map do |row|
        row.scan(regex)
    end
end

def unparsed_instructions
    input = file_input
    input.slice(input.index("\n") + 1..input.length).map(&:strip)
end

def parsed_instructions
    unparsed_instructions.map do |instruction|
        amount, from, to = instruction.scan(/\d+/).map(&:to_i)
    end
end

def reversed_input_rows
    parsed_input_rows.reverse
end

def parsed_stacks
    stacks = []

    reversed_input_rows.each do |row|
        row.each_with_index do |box, index|
            stacks[index] = [] unless stacks[index]
            stacks[index] << box unless box.include?(" ")
        end
    end

    stacks
end

def get_updated_stacks(reverse)
    stacks = parsed_stacks
    
    parsed_instructions.each do |instruction|
        amount, from, to = instruction
        needs_to_move = stacks[from - 1].pop(amount)
        stacks[to - 1].concat(reverse ? needs_to_move.reverse : needs_to_move)
    end

    stacks
end

def solve(reverse)
    p "Answer: #{get_updated_stacks(reverse).map(&:last).join}"
end

solve(true)
solve(false)