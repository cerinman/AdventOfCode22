require 'set'

alpabet_map = %q(abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ)

priority_total = File.readlines('input')
    .map(&:strip)
    .each_slice(3)
    .map do |group|
        incommon = []

        elf1, elf2, elf3 = group
        elf1.each_char do |char|
            incommon.push(char) if elf2.include?(char) && elf3.include?(char)
        end
        
        incommon.uniq.join
    end
    .reduce(0) do |sum, item|
        sum += alpabet_map.index(item) + 1
    end

pp "Priority total for all badges: #{priority_total}"

# Better solution after discussion with Zack Young.
# Use Set and intersection to remove N^2.
#
# Also, Regex can be slow so using `partition` can
# be problematic.
#
# Providing this as a learning experience. 

priority_score = File.readlines('input')
    # each_slice iterates for each range of N elements
    .each_slice(3)
    .sum do |group|
        # Turn each elf into a unique new Set.
        # Also strip whitespace and new line
        elf1, elf2, elf3 = group.map { |elf| Set.new(elf.strip.chars) }
        # Find the intersection of elf 1 and 2
        # and then use that set in an intersection
        # of elf 3.
        common_item = elf1.intersection(elf2).intersection(elf3).first
        alpabet_map.index(common_item) + 1
    end

pp "Better Solution: Priority total for all sacks: #{priority_score}"