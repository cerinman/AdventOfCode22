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