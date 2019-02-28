require 'stockpicker' # fucking love it works perfectly god you're so fucking slow going through this stuff recently ah well at least you are making progress lol

describe "#stockpicker" do
    stock_prices = [300, 150, 200, 100, 500, 800, 50, 300]
    it 'takes in an array' do
        expect { stockpicker(stock_prices) }.not_to raise_error
    end

    it 'returns an array' do
        expect(stockpicker(stock_prices)).to be_an(Array)
    end

    it 'returns a pairs of numbers in an array' do
        expect(stockpicker(stock_prices).length).to be(2) # can do be instead of eq because integers are immutable and all the same objects fucking love it heh
    end

    it 'does not return a sell day before a buy day' do
        picked_days = stockpicker(stock_prices)
        expect(picked_days[0]).to be < picked_days[1]
    end

    it 'returns the highest profit pair of buy and sell days' do
        expect(stockpicker(stock_prices)).to eq([3, 5])
    end
end