require 'deck'

# when cards run out, the deck should be shuffled

describe Deck do
    subject (:deck) { Deck.new }

    describe "#initialize" do
        it 'creates a deck of 52 cards' do
            expect(deck.cards.length).to eq(52)
        end

        it 'creates '
    end

    def "#shuffle" do # https://ruby-doc.org/core-2.2.0/Array.html#method-i-shuffle
        it 'shuffles the deck' do # make sure the deck receives the shuffle method
            expect(deck.cards).to receive(:shuffle!) # this should work because the shuffle! is a method of deck.cards which is an array and you call method like :method with this .to receive command
        end
    end
end