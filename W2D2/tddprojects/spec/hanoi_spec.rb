require 'hanoi'

describe Hanoi do
    subject(:hanoi) { Hanoi.new(4) }

    describe "#initialize" do
        it "accepts a 'size' and populates pile1 with 'size' number of disks" do
            expect(hanoi.pile1.length).to be(4)
        end

        it 'sets each element of pile1 to an incrementally increasing number' do
            expect(hanoi.pile1).to eq([1, 2, 3, 4])
        end

        it 'sets pile2 to an empty array' do
            expect(hanoi.pile2).to eq(Array.new)
        end

        it 'sets pile3 to be an empty array' do
            expect(hanoi.pile3).to eq(Array.new)
        end
    end

    describe "#play" do
        it 'continues until the game is over' # maybe don't really focus here lol

        it 'rescues errors and retries input'
    end

    describe "#move" do
        it 'takes in two numbers between 1 and 3' do
            expect { hanoi.move(1, 2) }.not_to raise_error
        end

        it 'raises an error if an argument is greater than 3' do
            expect { hanoi.move(1, 4) }.to raise_error
        end

        it 'raises an error if an argument is less than 1' do
            expect { hanoi.move(3, 0) }.to raise_error
        end

        it 'raises an error if the disc is larger than the disk on top of the end pile' do
            hanoi.move(1, 2)
            expect { hanoi.move(1, 2) }.to raise_error
        end

        it 'raises an error if there are no disks on the start pile' do
            expect { hanoi.move(3, 0) }.to raise_error
        end

        it 'removes the disk from the start pile' do
            hanoi.move(1, 2)
            expect(hanoi.disk1).to eq([1, 2, 3])
        end

        it 'places the disk on the end pile' do
            hanoi.move(1, 2)
            expect(hanoi.disk2).to eq([0])
        end
    end

    describe "#won?" do
        it 'returns true if pile3 contains all the discs in order' do
            expect(hanoi.pile3).to eq([1, 2, 3, 4])
        end
    end
end