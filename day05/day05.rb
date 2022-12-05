# This is a super ugly solution.
# I share because my goal for the day
# was to parse the stupid input
# completely.
#
# There is a lot of regex and loops in
# loops here. I totally understand this
# is super inefficient.
#
# Perhaps I'll clean this up. I'm sure
# I'll look at other peopels solutions
# and face palm at how stupid I am. But
# at least I parsed the stupid file.

require 'csv'

def file_input
    File.readlines("input")
end

def unparsed_boxes
    input = file_input
    input.slice(0..input.index("\n") - 2)
end

def parsed_boxes
    # This is horrible! But the gist
    # is that I'm getting things into
    # a CSV format for parsing.
    unparsed_boxes.map do |row|
        CSV.parse(
            row.gsub("    ", "[air]")
               .gsub(" ", "")
               .gsub("][", "],[")
               .gsub("[", "")
               .gsub("]", "")
               .strip,
            headers: false,
        )[0]
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

def useable_stacks
    reversed_boxes = parsed_boxes.reverse
    stacks = []

    reversed_boxes.each do |row|
        row.each_with_index do |box, index|
            stacks[index] = [] unless stacks[index]
            stacks[index] << box unless box.include?("air")
        end
    end

    stacks
end

def get_updated_stacks(reverse)
    stacks = useable_stacks
    
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