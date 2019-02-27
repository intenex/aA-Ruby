require 'sloth'

describe Sloth do
    subject(:sloth) { Sloth.new('Herbert') }

    describe '#initialize' do # ah per each method have a describe love it great to actually practice along with this super important
        it 'assigns a name' do
            expect(sloth.name).to eq('Herbert')
        end

        it 'starts with an empty array of foods' do
            expect(sloth.foods).to be_empty # awesome matcher
        end
    end

    describe '#eat' do
        it 'adds a new food to the foods array' do
            expect(sloth.foods).to_not include('leaves') # so interesting - a .to receive call specifically waits to see what code you execute next and evaluates that, this just evaluates immediately yeah makes sense so great that you're actually interfacing with this stuff and learning it it's all super important for sure that's going to be your main downfall consider it all super important to learn and nothing below you or too boring, from CSS to SQL to Javascript to everything, crazy ultra important to learn, coding is basically zero percent algorithms and 99% all of this so this is the more important stuff for sure always remember than and learn it super well, don't not learn anything just because it's not a crazy mathematical intellectual challenge
            sloth.eat('leaves')
            expect(sloth.foods).to include('leaves')
        end
    end

    describe "drink" do
        before(:each) { sloth.drink("lemonade", 10) }

        it 'adds the drink as a key to the drinks hash' do
            expect(sloth.drinks).to have_key('lemonade')
        end

        it 'adds the amount as a value ot the drinks hash' do
            expect(sloth.drinks).to have_value(10)
        end
    end

    describe '#run' do
        it 'returns a string that includes the direction' do
            expect(sloth.run('west')).to include('west') # awesome just have to include the direciton love it
        end

        it 'raises an ArgumentError if the direction is invalid' do
            expect { sloth.run('all over the place') }.to raise_error(ArgumentError)
        end
    end
    
    # this does not pass becuase you cannot test protected or private methods
    # you test the public interface of a class with rspec unit tests, not the internal workings. Interesting. So basically any internal workings are tested through their output and functionality in the public methods does kind of make sense since that's what internal methods are for, getting public methods and other things working correctly behind the scenes so you can always test them indirectly like that hmm. Though more likely it's just a practical error in that it's not possible to test protected or private methods with another class object like rspec is lol
    describe '#secret_sloth' do
        it 'returns a string with secret' do
            expect(sloth.secret_sloth).to include('secret')
        end
    end
end