class Primate
    attr_reader :inspected_count

    def initialize(id, items, operation, test)
        @id = id
        @items = items
        @operation = operation
        @test = test
        @relief = 3
        @inspected_count = 0
    end

    def catch_item(item)
        @items << item
    end

    def inspect_items
        @items.size.times.map do
            @inspected_count += 1
            item = @items.shift
            updated_item = operate(item)
            to_primate = get_to_primate(updated_item)
            [to_primate, updated_item]
        end
    end

    def operate(item)
        operator = @operation[0]
        denominator = @operation[1] == "old" ? item : @operation[1].to_i
        item.public_send(operator, denominator) / @relief
    end
     
    def get_to_primate(updated_item)
        updated_item % @test[0] == 0 ? @test[1] : @test[2]
    end
end