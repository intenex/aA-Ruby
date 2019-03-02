class Hand
    attr_reader :cards

    def initialize
        @cards = Array.new
    end

    def add_card(card)
        @cards << card
    end

    # need a hand_rank, then compare highest_card, then compare kickers, and split pot if still a tie after that
    # hand_value[0] is the hand_rank, hand_value[1] is the top card for that rank, hand_value[2] stores all the kicker cards
    def winning_hand(hand1, hand2)
        hand_rank = { :high_card => 0, :one_pair => 1, :two_pair => 2, :three_kind => 3, :straight => 4, :flush => 5, :full_house => 6, :four_kind => 7, :straight_flush => 8 }
        hand1_value = rank_hand(hand1)
        hand2_value = rank_hand(hand2)
        if hand_rank[hand1_value[0]] != hand_rank[hand2_value[0]] # if there is one clearly better hand than the other then no need to compare top cards and kickers and shit just return the hand that is better than the other one
            return hand_rank[hand1_value[0]] > hand_rank[hand2_value[0]] ? hand1 : hand2 # holy fucking shit if this works amazing great application basically return hand1 if its rank is higher than hand2, else return hand2, love it --> wow this ternary operator is really the best way to go huh --> test removing parentheses later
        elsif hand1_value[1] != hand2_value[1] # basically if the hand_ranks are equal, then see if the top card for each rank is equal too, if not then return the one with the highest top card, if they are equal, then go and compare each kicker in turn until all up-to-4 kickers have been evaluated lol. For a high card kind of thing all 4 kickers would play I think lol
            return hand1_value[1] > hand2_value[1] ? hand1 : hand2 # this is why having these as strict values is helpful ah and as aces are always the highest in this game and don't count as 1 for anything start at 2..14 vs 1..13 nice
        elsif kicker(hand1_value[2], hand2_value[2]) != 0 # this returns either 1, for the first argument, -1 for the second, or 0 for a tie, so if the first hand wins, it'll be 1, otherwise -1, just like the spaceship operator (though that does this in reverse, but same thing -1 if a is smaller than b, which is the same as saying 1 if a is larger than b, which is what you want here, so same thing)
            return kicker(hand1_value[2], hand2_value[2]) > 0 ? hand1 : hand2 # if it's 1, then hand1 is larger, if it's -1, then hand2 was larger, so return either of those
        end
        # don't need an explicit nil here - if none of the ifs return anything then it'll evaluate to nil by default and that will be the result here --> so you can do a check like 'if winning_hand; #add_pot(winning_hand); else; #split_pot end' fucking love it really getting this code well super lucky that you retain and remember it all so well and are indeed pushing forward today super lucky
    end

    def rank_hand(hand) # this will literally just return the values for the hand amazing lol the first one that returns not nil or false, aka not a falsey value, all the way down to high_card? which will definitely return something
        straight_flush?(hand) || four_kind?(hand) || full_house?(hand) || flush?(hand) || straight?(hand) || three_kind?(hand) || two_pair?(hand) || one_pair?(hand) || high_card?(hand) # omfg you can just chain link these until one is found like (nil || false || nil || nil || true) will return true it will either go until it finds a true value and return the first true value or return the last value found amazing
    end



end