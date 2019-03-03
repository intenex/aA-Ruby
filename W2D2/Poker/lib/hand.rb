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
            if kickers(hand1_value[2], hand2_value[2]) != 0 # this returns either 1, for the first argument, -1 for the second, or 0 for a tie, so if the first hand wins, it'll be 1, otherwise -1, just like the spaceship operator (though that does this in reverse, but same thing -1 if a is smaller than b, which is the same as saying 1 if a is larger than b, which is what you want here, so same thing)
                return kickers(hand1_value[2], hand2_value[2]) > 0 ? hand1 : hand2 # if it's 1, then hand1 is larger, if it's -1, then hand2 was larger, so return either of those
            end
        end
        # don't need an explicit nil here - if none of the ifs return anything then it'll evaluate to nil by default and that will be the result here --> so you can do a check like 'if winning_hand; #add_pot(winning_hand); else; #split_pot end' fucking love it really getting this code well super lucky that you retain and remember it all so well and are indeed pushing forward today super lucky
        # though one thing to note is if there's no clear winner and more than two comparisons that will eventually go on you can just compare either of the two hands that you input against all the other hands to find the eventual winner since both hands you're comparing are perfectly equivalent in value to compare against any other hand --> if they all still end up tying, then split the pot all the ways, otherwise if there's one other winner, split with those pots, with the primary edge case being if the tied hand wins against all other hands then you have to split between the two people who tied, so whenever there's a tie, save both hands to the list of "current_winning_hands", then at the end, split the pot amongst all the hands in that array, be it one or more hands love it. Have the Hand class hold a player attribute too so it's easy to reference the player the hand belongs to love it to award the pot to them and all that so fucking great this is coming along great almost done once you figure out all this logic tbh super nuts awesome lol
    end

    def rank_hand(hand) # this will literally just return the values for the hand amazing lol the first one that returns not nil or false, aka not a falsey value, all the way down to high_card? which will definitely return something
        straight_flush?(hand) || four_kind?(hand) || full_house?(hand) || flush?(hand) || straight?(hand) || three_kind?(hand) || two_pair?(hand) || one_pair?(hand) || high_card?(hand) # omfg you can just chain link these until one is found like (nil || false || nil || nil || true) will return true it will either go until it finds a true value and return the first true value or return the last value found amazing
    end

    # amazing you literally figured out the logic for everything except straight, flush, and straight_flush already so great and after that just need to do the exceedingly simple kicker logic and you're fucking done
    # calculate if all the hands have the same symbol, use the same helper method as flush? probably
    # then if they do, calculate if it's a straight too, as in all the cards have values in sequential order, use the helper method from straight?

    def straight_flush?(hand) # just do the suit_counter thing and then check if all are of the same suit and then call the straight helper method and make sure it's all of that same helper method too love it
        
    end

    def four_kind?(hand)
        value_counter = how_many_value?(hand)
        if value_counter.values.one?(4)
            kicker = hand.cards.map { |card| card.value if card.value != value_counter.key(4) }.compact # no need to sort since again only one of these lol
            [:four_kind, value_counter.key(4), kicker]
        end
    end

    def full_house?(hand)
        value_counter = how_many_value?(hand)
        if value_counter.values.one?(3) && value_counter.values.one?(2) # if one three of a kind and one two pair, fucking love it, amazing this logic works so well actually for all the hands lol so insane you're almost done with all of these and they seem pretty fucking flawless to you so far
            [:full_house, value_counter.key(3), value_counter.key(2)] # just one kicker which is the second pair to check if the first one isn't sufficient to win it love it, technically all of these could have been compared in the kicker array but this just makes it a little more explicit in the logic super great love it
        end
    end

    def flush?(hand) # this is fun you really enjoy doing all these lol so great
        suit_counter = how_many_suit?(hand)
        if suit_counter.values.one?(5) # or if suit_counter.length == 1 lol
            kickers = hand.cards.map { |card| card.value }.sort.reverse # identify the high card, then all the rest are kickers --> so fucking easy when you're motivated to work through all the code and not distracted it's 100% all about distractions talking to people is such a crazy distraction definitely just avoid doing that and pummel forward with your code for sure. Other people are only helpful to keep competitive pressure on so you can pummel ahead with things, but not to talk to them, hence coworking should be ideal, we'll see how it goes. Just learn to not be addicted to talking to people in groups such a terrible waste of time this is so much better. You get really fixated on the thing that you're into and ignore all other groups and people and things that aren't in that realm though super interesting, from random groups like fucking Darkness Rises to this coding group and all that and ignoring everything else, so interesting and weird
            top_card = kickers.shift # remove the top card from kickers and return that in the array by itself as the top card to measure against
            [:flush, top_card, kickers]
        end
    end

    # then get the value of the smallest card (the first one, values[0] and then enumerate over all of them until values[-1] or values[4] and make sure they all increment by 1, if they do return the whole array thing if not return nil)
    # put all this in a helper method so you can use it for the straight flush determination too love it

    # just sort all the hand.card values then check that they increment by one but be sure to to include ace as a 1 here because I think A2345 counts but not 100% sure that's the one edge case to consider though man so amazing you're so lucky that these solutions just come so easily to you when you think about them for a while obviously your brain has learned patterns for thinking about this stuff and that's all there is to it so learn all the patterns and that's all that intelligence is fucking love it so much just keep learning all the patterns you can voraciously so fucking lucky
    def straight?(hand)
        values = hand.cards.map { |card| card.value }.sort # sort so that you can make sure these are all in ascending order with one value difference between all the values
        if values[0] != 2 # if it doesn't start at 2, since an ace can technically be a 1 as well in which case make sure that the high card is actually a 5, not the ace
            if (0..4).all? { |index| values[index] == (values[0] + index) } # this should ensure that they all increment, since values[0] will be say 4, then it'll be 4 == 4, then values[1] == 5, etc, from 0 1 2 3 4 love it
                [:straight, values[-1]] # no kickers, and the top card is the last card in values love it
            end
        elsif values[0] == 2 # else if values[0] is indeed a 2, then check just from 2 3 4 5 and then check that there's an Ace, aka a 14, and if so list 5 as the high end great to catch this edge case
            if ((0..3).all? { |index| values[index] == (2 + index) }) && (values[-1] == 14) # if 2 3 4 5 are all present and a 14 Ace is present, then this is also the low end straight not as many exceptions as chess thankfully but still a fair bit lol
                [:straight, 5] # the highest value is just 5 so just hardcode that in there why not lol
            end
        end
    end

    def three_kind?(hand)
        value_counter = how_many_value?(hand)
        if value_counter.values.one?(3) # include also works here but one works just as fine so why not
            kickers = hand.cards.map { |card| card.value if (card.value != value_counter.key(3)) }.compact.sort.reverse
            [:three_kind, value_counter.key(3), kickers] # omg .key(value) is 100% the right notation fuck yeah not having internet and coding is the greatest thing ever so fucking happy with this
        end
    end

    # check that there are two values in the hash that equal a counter of 2 then return the top of those pairs as the top card value, then the second as a kicker along with all the other kickers, but the first kicker in the array, and then have the kicker array specifically compare based on cards in order love it in the array that way the cards don't have to be in order in the array in terms of value and the kicker doesn't just compare to see the highest card value out of all the kickers, it compares [0] with [0] and works that way since [0] in some times is the second pair and a 4 4 pair would go ahead of a K kicker card and beat a 2 2 pair with a K kicker
    def two_pair?(hand)
        value_counter = how_many_value?(hand)
        pairs = value_counter.select { |k, v| v == 2 } # think hashes work like this literally just working off memory for all of these but pseudocode is good enough and this really tests memory fucking love it actually
        if pairs.length == 2 # edit just checked this totally works so great lol | not sure hashes have a length thing in which case do pairs.keys.length or pairs.values.length, but # this returns true only if two pairs were found
            pair_values = pairs.keys.sort.reverse # this gets the values of both pairs which are the ones not to select for kickers EXCEPT the lesser of the two should be the first kicker so much logic fucking love it just have to pump with your working memory so lucky to be able to do all this shit. sort and reverse will put these in order automatically too so fucking great
            kickers = hand.cards.map { |card| card.value if (card.value != pair_values[0] && card.value != pair_values[1]) }.compact # don't forget the compact to get rid of all the nil returns! amazing that you remembered this truly great # love that you're totally back with being focused with your code love it can't wait for the bootcamp and to really go through it so great # no need to sort and reverse on this one since there should only be one real kicker card lol amazing though you've learned the trouble with not putting safety code in like this it will likely break sigh lol at least you thought of it love that you're crushing this so easily fucking great
            kickers.unshift(pair_values[1]) # this should be the first kicker card fucking love this shit
            [:two_pair, pair_values[0], kickers]
        end
    end
    
    # check if there are any values in the hash that equal 2 and specifically that there's only one value that has a pair since you probably should return nil if it's technically a two pair or something
    def one_pair?(hand)
        value_counter = how_many_value?(hand)
        if value_counter.values.one?(2) # check that this returns only one found pair with two matching values otherwise it returns nil because this if didn't match anything fucking love it. This is the only one that really does this check though your high_card and your three_kind skip it so even a full_house would return a true value for a three_kind and every hand will return one for high_card but should be fine love this shit because of the ordering of your or statement so great
            kickers = hand.cards.map { |card| card.value if (card.value != value_counter.key(2)) }.compact.sort.reverse # only return the card values because that's all that's important, and only those that aren't part of that pair love it, then sort by those values and return them in reverse order heh amazing
            [:one_pair, value_counter.key(2), kickers] # check this value_counter.key(2) syntax later to make sure this gets the card.value since no internet here rn
        end
    end

    def high_card?(hand) # the only one with no if statement because this should always return something and it's easiest to do it this way
        high_card = hand.cards.max_by { |card| card.value }
        hand.cards.delete(high_card) # let's see if it's still recorded as a high_card if you delete it hmm this is just different code for this high card so great that there are so many ways to do everything and you practice doing them all love it
        kickers = hand.cards.sort_by { |card| card.value }.reverse # this will return the lowest value cards first I think so you reverse it to get the highest love it
        [:high_card, high_card.value, kickers] # this is the array to return - the comparison of the high card is the value of the high_card, and then all the kickers in order, and the type returned is :high_card, love this shit can't wait to see this all come together so glad you're coding
    end

    def how_many_value?(hand) # returns a hash counting each of the values
        value_counter = Hash.new(0)
        hand.cards.each { |card| value_counter[card.value] += 1 }
        value_counter
    end

    def how_many_suit?(hand) # fucking love it coming together so well
        suit_counter = Hash.new(0)
        hands.cards.each { |card| suit_counter[card.suit] += 1 }
        suit_counter
    end

    # iterate hand1_kickers.length times since both will be of the same length of kickers so either is fine love it
    
    # remember you have to compare each element of the array against the corresponding index in the other array, since
    # not all of these cards are actually kickers and are sometimes the second pair, as in two pair or in a full house,
    # and so the first element [0] in each array here will be the representative card from that second pair and so even
    # if it's lower than the kicker cards like a 4 4 vs a 3 3 and they have kickers like J and A, the 4 4 with a kicker J
    # would beat the 3 3 with a kicker A so enumerate on each element of the array in order and assume that the arrays will
    # be of the same length bc they should be if it ever gets to comparing kickers since both hands will be of the same
    # type of hand rank and consequently have the same # of kickers love it

    def kickers(hand1_kickers, hand2_kickers) # each of these is an array of all the kicker cards in order --> kickers are only evaluated on their values so that's good to know, ah except for a full house where it's evaluated on the pair but still there since it's a pair just whichever pair is higher wins so that's good should be a way to do that love it
        length = hand1_kickers.length # since they're both the same length
        (0...length).each do |index| # with length being anything from 1 to 4, so this will do anything from 0 to 0 1 2 3
            return hand1_kickers[index] <=> hand2_kickers[index] if hand1_kickers[index] != hand2_kickers[index] # # fucking awesome!!! finally a fucking good use of the spaceship operator!!! this returns 1 if hand1 is greater than hand2 and -1 if hand2 is great so great # if they are not equal return something otherwise just continue with the progression fucking love this
        end
        0 # return 0 if nothing else was returned this means everything was perfectly equal
    end
end

# break problems down into their simplest pieces to keep crushing it love it