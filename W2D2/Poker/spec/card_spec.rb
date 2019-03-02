require 'card'

describe Card do # should test the public interface that's all so don't need to ensure the cards are the right numbers because they always will be lol
    subject(:card) { Card.new(:spades, 14) }

    describe "#to_s" do
        it 'displays the card value and its suit' do
            expect(card.to_s).to eq("♠A")
            expect(Card.new(:hearts, 9).to_s).to eq("♥9")
        end
    end
end