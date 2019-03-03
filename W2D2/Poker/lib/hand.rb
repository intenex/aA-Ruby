class Hand
    attr_reader :cards

    def initialize(player)
        @cards = Array.new
        @player = player
    end

    def add_card(card)
        @cards << card
    end

    # https://www.adda52.com/poker/poker-rules/cash-game-rules/tie-breaker-rules --> all the tie breaker rules fucking love it
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
        elsif hand1_value[2] && hand2_value[2] # if there are any kickers for the rank in question
            if kicker(hand1_value[2], hand2_value[2]) != 0 # this returns either 1, for the first argument, -1 for the second, or 0 for a tie, so if the first hand wins, it'll be 1, otherwise -1, just like the spaceship operator (though that does this in reverse, but same thing -1 if a is smaller than b, which is the same as saying 1 if a is larger than b, which is what you want here, so same thing)
                return kicker(hand1_value[2], hand2_value[2]) > 0 ? hand1 : hand2 # if it's 1, then hand1 is larger, if it's -1, then hand2 was larger, so return either of those
            end
        end
        # don't need an explicit nil here - if none of the ifs return anything then it'll evaluate to nil by default and that will be the result here --> so you can do a check like 'if winning_hand; #add_pot(winning_hand); else; #split_pot end' fucking love it really getting this code well super lucky that you retain and remember it all so well and are indeed pushing forward today super lucky
        # though one thing to note is if there's no clear winner and more than two comparisons that will eventually go on you can just compare either of the two hands that you input against all the other hands to find the eventual winner since both hands you're comparing are perfectly equivalent in value to compare against any other hand --> if they all still end up tying, then split the pot all the ways, otherwise if there's one other winner, split with those pots, with the primary edge case being if the tied hand wins against all other hands then you have to split between the two people who tied, so whenever there's a tie, save both hands to the list of "current_winning_hands", then at the end, split the pot amongst all the hands in that array, be it one or more hands love it. Have the Hand class hold a player attribute too so it's easy to reference the player the hand belongs to love it to award the pot to them and all that so fucking great this is coming along great almost done once you figure out all this logic tbh super nuts awesome lol
    end

    def rank_hand(hand) # this will literally just return the values for the hand amazing lol the first one that returns not nil or false, aka not a falsey value, all the way down to high_card? which will definitely return something
        straight_flush?(hand) || four_kind?(hand) || full_house?(hand) || flush?(hand) || straight?(hand) || three_kind?(hand) || two_pair?(hand) || one_pair?(hand) || high_card?(hand) # omfg you can just chain link these until one is found like (nil || false || nil || nil || true) will return true it will either go until it finds a true value and return the first true value or return the last value found amazing
    end

    def straight_flush?(hand)
        # calculate if all the hands have the same symbol, use the same helper method as flush? probably
        # then if they do, calculate if it's a straight too, as in all the cards have values in sequential order, use the helper method from straight?
    end

    def four_kind?(hand)
    end

    def full_house?(hand)
    end

    def flush?(hand)
    end

    def straight?(hand)
    end

    def three_kind?(hand)
    end

    def two_pair?(hand)
    end
    
    def one_pair?(hand)
    end

    def high_card?(hand)
        high_card = hand.cards.max_by { |card| card.value }
        hand.cards.delete(high_card) # let's see if it's still recorded as a high_card if you delete it hmm
        kickers = hand.cards.sort_by { |card| card.value }.reverse # this will return the lowest value cards first I think so you reverse it to get the highest love it
        [:high_card, high_card.value, kickers] # this is the array to return - the comparison of the high card is the value of the high_card, and then all the kickers in order, and the type returned is :high_card, love this shit can't wait to see this all come together so glad you're coding
    end

    def kicker(hand1_kickers, hand2_kickers) # each of these is an array of all the kicker cards in order --> kickers are only evaluated on their values so that's good to know, ah except for a full house where it's evaluated on the pair but still there since it's a pair just whichever pair is higher wins so that's good should be a way to do that love it
    end
end

# break problems down into their simplest pieces to keep crushing it love it