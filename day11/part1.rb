require_relative "primate"

class KeepAway
    def initialize(input_path)
        @monkeys = parse_input(input_path)
    end

    def parse_input(input_path)
        File.readlines(input_path).map(&:strip).each_slice(7).map do |individual|
            test = []
            id = individual[0]
            items = individual[1].split(" ").drop(2).map(&:to_i)
            operation = individual[2].split("old ").drop(1)[0].split(" ")
            test << individual[3].split(" ").last.to_i
            test << individual[4].split(" ").last.to_i
            test << individual[5].split(" ").last.to_i

            Primate.new(id, items, operation, test)
        end
    end

    def run_twenty_rounds
        20.times do
            @monkeys.each do |monkey|
                round(monkey)
            end
        end
    end

    def round(monkey)
        monkey.inspect_items.each do |(to_monkey, updated_item)|
            @monkeys[to_monkey].catch_item(updated_item)
        end
    end

    def run
        run_twenty_rounds

        counts = @monkeys.map do |monkey|
            monkey.inspected_count
        end.sort.last(2)

        pp counts[0] * counts[1]
    end
end

game = KeepAway.new("input")
game.run