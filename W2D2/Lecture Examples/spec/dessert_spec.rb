require 'dessert'
require 'drink'

# doubles are super useful for unit tests testing something in isolation, not how things function

describe Dessert do
    subject(:brownie) { Dessert.new("brownie", 50) }
    let (:milk) { double("milk", :random_stub_method => "random_output") } # this is how you write stubs fucking love it glad that you can actually engage with the material today and are moving forward lucky you really put a lot of yourself into chess lol

	describe '#initialize' do
		it 'takes in a type' do
			expect(brownie.type).to eq('brownie') # note that if you to eq it equals the same thing, equivalence, but not identity --> it doesn't have to be the same object, just the same value in each object, but if you changed it to 'to be' versus 'to eq' it needs to be the exact same object, so it would fail since each string would be a different string object even if they were the same content inside them awesome
		end

		it 'takes in an amount' do
			expect(brownie.amount).to eq(50)
		end

		context 'with a huge amount' do
			subject(:brownie) { Dessert.new("brownie", 100000) } # this subject will overwrite the original subject love it
			it 'sets the type to the giant version' do
				expect(brownie.type).to eq('giant brownie')
			end
		end

		it 'raises an error if the amount is not a number' do
			expect { Dessert.new("brownie", "tons") }.to raise_error('Amount must be a number') # amazing catches exactly the right error if you write this in
		end
	end

	describe '#eat' do
		it 'calls #dip on the accompanying drink' do
			expect(milk).to receive(:dip).with(brownie)
			brownie.eat(milk)
		end
	end
end
