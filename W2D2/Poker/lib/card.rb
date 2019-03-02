class Card
    attr_reader :suit, :value

    def initialize(suit, value)
        @suit = suit
        @value = value
    end

    def to_s # add in paint later to colorize these cards too by suit get 4 different colors instead of 2 lol
        case @value
        when 2..9
            card_num = @value.to_s
        when 1
            card_num = "A"
        when 10
            card_num = "J"
        when 11
            card_num = "Q"
        when 12
            card_num = "K"
        end
        "#{@suit}#{card_num}"
    end
end