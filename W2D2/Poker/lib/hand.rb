class Hand
    attr_reader :cards

    def initialize
        @cards = Array.new
    end

    def add_card(card)
        @cards << card
    end

end