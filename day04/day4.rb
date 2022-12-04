def input
    File.readlines('input')
end

def stripped_input
    input.map(&:strip)
end

def convert_to_range(assignment)
    start, stop = assignment.split('-')
    start.to_i..stop.to_i
end

def print_count(count)
    pp "There are #{count} assignments overlapping"
end

def part_one
    print_count(stripped_input.sum do |pair|
        x, y = pair.split(",")
        x = convert_to_range(x)
        y = convert_to_range(y)
        x.cover?(y) || y.cover?(x) ? 1 : 0
    end)
end

def part_two
    print_count(stripped_input.sum do |pair|
        x, y = pair.split(",")
        x = convert_to_range(x)
        y = convert_to_range(y)
        (x.first <= y.last) && (y.first <= x.last) ? 1 : 0
    end)
end

part_one
part_two