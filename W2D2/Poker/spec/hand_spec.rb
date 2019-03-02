require 'hand'

describe Hand do
    subject(:hand) { Hand.new }

    describe "#initialize" do
        it 'creates an attribute @cards and sets it to an empty array' do
            expect(hand.cards).to eq(Array.new)
        end
    end
end