require 'transpose'

describe "#my_transpose" do
    arr = [[0, 1, 2],
           [3, 4, 5],
           [6, 7, 8]]
    it 'accepts an array' do
        expect { my_transpose(arr) }.not_to raise_error # wonderful testing
    end

    it 'returns an array' do
        expect(my_transpose(arr)).to be_an(Array)
    end

    it 'transposes the array' do
        trans_arr = [[0, 3, 6],
                     [1, 4, 7],
                     [2, 5, 8]]
        expect(my_transpose(arr)).to eq(trans_arr) #.to equal expects the exact object ID .to eq expects all the elements to equal the same things
    end
end
