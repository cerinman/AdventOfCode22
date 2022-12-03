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