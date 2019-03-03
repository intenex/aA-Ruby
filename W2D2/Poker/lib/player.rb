# 2 to 6 players - so enter 2 to 6 players when the game starts
# cards are dealt one at a time for each player nice to be precise in game play that's how to do it
# before play begins, an ante is added to the pot

class Player
    attr_accessor :pot
    attr_reader :hand

    def initialize(starting_pot) # initialized with a starting pot amount nice
        @hand = Hand.new(self)
        @pot = starting_pot
    end

    # either fold, check (see the bet), or raise
    def get_move # damn getting so good at all this shit lol
        puts "Would you like to [f]old, [c]heck/[c]all, or [r]aise?"
        answer = gets.chomp.downcase
        case answer
        when "f"
            # call fold
        when "c"
            # find the call_amt
            # raise an error if the call_amt is higher than the pot amt of the player, otherwise go through
            # match the current bet amount and stay in
        when "r"
            puts "How much would you like to raise?"
            raise_amt = gets.chomp.to_i
            if raise_amt < @pot
                @pot -= raise_amt
                # increase the game pot amount accordingly
            else
                raise ArgumentError.new("That was not a valid amount to raise. Try again.")
            end
        else
            raise ArgumentError.new("That was not a valid entry. Try again.")
        end
    rescue ArgumentError => e
        puts e
        retry
    end

    # discard method --> this happens after betting, all the players get to decide what to discard and whatnot
    # discarded cards don't get reshuffled back in, they're set aside until all cards are drawn through in which case the cards reset fucking love it
end