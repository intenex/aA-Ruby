class Card
    attr_reader :suit, :value

    def initialize(suit, value)
        @suit = suit
        @value = value
    end

    def to_s # add in paint later to colorize these cards too by suit get 4 different colors instead of 2 lol
        case @value
        when 2..10; card_num = @value.to_s
        when 11; card_num = :J
        when 12; card_num = :Q
        when 13; card_num = :K
        when 14; card_num = :A
        end
        case @suit
        when :spades; suit_sym = :♠
        when :hearts; suit_sym = :♥
        when :diamonds; suit_sym = :♦
        when :clubs; suit_sym = :♣
        end
        "#{suit_sym}#{card_num}"
    end
end