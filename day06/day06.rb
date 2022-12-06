# ei_one: first marker after character 5
# ei_two: first marker after character 6
# ei_three: first marker after character 10
# ei_four: first marker after character 11
require 'set'

def input
    File.read("input")
end

def starting_position(number_of_unique_characters)
    starts_at = 0
    number_with_offset = number_of_unique_characters - 1
    input.chars.each_with_index do |char, index|
        next unless index >= number_with_offset
        current_set = Set.new(input[index - number_with_offset..index].split(""))
        break starts_at = index + 1 if current_set.size == number_of_unique_characters
    end

    starts_at
end

pp "The marker starts at #{starting_position(4)} for part 1"
pp "The marker starts at #{starting_position(14)} for part 2"