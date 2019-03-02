require 'hand'

describe Hand do
    subject(:hand) { Hand.new }
    let(:card) { double(:suit => :♠, :value => 12) }

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
end