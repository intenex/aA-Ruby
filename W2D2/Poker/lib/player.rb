class Player
    def initialize(starting_pot) # initialized with a starting pot amount nice
        @hand = Hand.new(self)
        @pot = starting_pot
    end

    
end