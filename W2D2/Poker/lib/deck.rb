require_relative 'card'

class Deck
    attr_reader :cards, :discards

    def initialize
        @cards = create_cards
        @discards = Array.new
    end

    def shuffle_deck!; @cards.shuffle! end # update omg amazingly it works with just @cards so @cards must indeed be syntactic sugar for self.cards somehow look more into it hmmm or rather deck.cards returns @cards actually so it's the same thing yeah okay interesting that's more likely wow totally nuts and amazing # I believe you may need to do this to do the rspec but see if you can do it just calling @cards we'll see. See if shuffle! works on this since you aren't reassigning it think you should have an attr_reader on @cards not an accessor and all the methods to remove cards and whatnot should be done here in deck

    def get_card
        if !@cards.empty? # if not empty pop one card out and return it
            @cards.pop
        else
            @cards += @discards # add all the discards back into the deck if the deck is empty, shuffle it, and then pop off another card to return love it 
            self.shuffle_deck!
            @cards.pop
        end
    end

    def reset_deck # called at the end of every game where all the discards go back into the cards and get shuffled love it
        @cards += @discards
        self.shuffle_deck!
    end

    private
    def create_cards # this is the private method - we test the @cards but not this private method to create all the cards
        suits = [:spades, :hearts, :diamonds, :clubs] # would be easier if you made these all words and just changed their symbols to unicode lol but pretty amazing this just works lol
        cards = suits.map { |suit| (2..14).map { |value| Card.new(suit, value) } }.flatten # wow you can do a straightup map on this amazing
        cards.shuffle!
    end
end