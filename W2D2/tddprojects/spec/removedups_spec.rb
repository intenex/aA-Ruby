require 'removedups'

describe "#my_uniq" do
    it 'takes in an array' do
        expect { my_uniq([1, 2, 3]) }.not_to raise_error # makes sense .to vs .not_to to write --> ahh these can only be given blocks love it right
    end 

    it 'returns an array' do
        expect(my_uniq([1, 2, 3])).to be_an(Array) # weird so to bes must be passed an argument and raise errors must be passed blocks learn the patterns here more the more you do it the more you'll learn beautiful
    end

    it 'removes duplicates from the array' do
        arr = [1, 2, 1, 3, 3]
        expect(my_uniq(arr).length).to eq(3) # to just return the three specific number
    end

    it 'returns the unique elements in order' do
        arr = [1, 2, 1, 3, 3] # these are local in scope to each block love it
        expect(my_uniq(arr)).to eq([1, 2, 3])
    end
end