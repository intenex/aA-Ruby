require 'twosum' # love that you're actually learning this very useful so glad

describe '#two_sum' do
    arr = [-1, 0, 2, -2, 1] # put it here to be in the scope of all the tests inside love it
    it 'takes in an array' do
        expect {two_sum(arr)}.not_to raise_error
    end

    it 'returns an array' do
        expect(two_sum(arr)).to be_an(Array)
    end

    it 'returns all pairs of indexes that have values that sum to zero' do
        expect(two_sum(arr)).to eq([[0, 4], [2, 3]])
    end

    it 'returns pairs of indexes sorted by smallest index first' do # cool think it works though def not good at this yet
        arr = [-1, 0, -2, 2, 3, 2, 1, 0]
        expect(two_sum(arr)).to eq([[0, 6], [1, 7], [2, 3], [2, 5]])
    end
end