require 'hand'

describe Hand do
    subject(:hand) { Hand.new }
    let(:card) { double(:suit => :spades, :value => 12) }

    describe "#initialize" do
        it 'creates an attribute @cards and sets it to an empty array' do
            expect(hand.cards).to eq(Array.new)
        end
    end

    describe "#add_card" do
        it 'adds the given card to the @cards attribute' do
            hand.add_card(card)
            expect(hand.cards).to eq([card]) # well that worked lol hmm the receive method didn't though look into that more love these specs though coming along great so much to do though
        end
    end
    
    describe "#straight" do
        it 'returns an array with top card 6 for a straight of 2 3 4 5 6'
        it 'returns an array with top card 5 for a straight of A 2 3 4 5'
        it 'returns an array with top card 13 for a straight of 9 10 J Q K'
        it 'returns nil for an hand of 4 5 6 4 8'
    end

end