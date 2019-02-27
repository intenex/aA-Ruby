class Sloth
    attr_reader :name, :foods, :drinks
    DIRECTIONS = %w(north south east west)

    def initialize(name)
        @name = name
        @foods = Array.new
        @drinks = Hash.new
    end

    def eat(food)
        @foods << food
    end

    def drink(beverage, amount)
        @drinks[beverage] = amount
    end

    def run(direction)
        raise ArgumentError unless DIRECTIONS.include?(direction)
        "I'm running #{direction} at .00001 miles per hour"
    end

    # last thing to note is that RSpec will not let you test protected or private methods fucking love it damn through these videos so fast
    protected
    def secret_sloth
        "Shhhh...this is a secret"
    end
end