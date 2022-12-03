require 'set'

alpabet_map = %q(abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ)

priority_total = File.readlines('input')
    .map do |sack|
        sack.strip!
        incommon = []

        compartment1, compartment2 = sack.partition(/.{#{sack.size/2}}/)[1,2]
        compartment1.each_char do |char|
            incommon.push(char) if compartment2.include?(char)
        end

        incommon.uniq.join
    end
    .reduce(0) do |sum, item|
        sum += alpabet_map.index(item) + 1
    end

pp "Priority total for all sacks: #{priority_total}"

# Better solution after discussion with Zack Young.
# Use Set and intersection to remove N^2.
#
# Also, Regex can be slow so using `partition` can
# be problematic.
#
# Providing this as a learning experience. 

priority_score = File.readlines('input')
    .sum do |elf_sack|
        # Strip white space and new line
        elf_sack.strip!
        # Split the elf_sack into two compartments
        # String.chars returns an array of characters in the string
        # each_slice iterates for each range of N elements
        # Turn each compartment into a unique new Set
        compartment1, compartment2 = elf_sack.chars.each_slice(elf_sack.length / 2)
            .map { |compartment| Set.new(compartment) }

        # Use intersection for find chars in common
        common_item = compartment1.intersection(compartment2).first
        alpabet_map.index(common_item) + 1
    end

pp "Better Solution: Priority total for all sacks: #{priority_score}"