# omg this plays almost flawlessly so amazing can't believe you actually got it working so well love it not hard but definitely invovled just need to force yourself ot have enough focus to keep going until you write out all the code as it should be so happy love this so much
# omg byebug is the greatest thing ever really helps in debugging the most inexplicable bugs and this one is truly inexplicable such great practice so fucking happy love it so much

class ComputerPlayer
    attr_reader :name
    attr_accessor :memorized_cards, :known_cards, :matched_cards

    def initialize
        @known_cards = Hash.new # create an array that keeps track of cards that you've memorized so you can reference which ones to play next love it
        @matched_cards = [] # don't play cards that have been matched love it wow love that they just literally tell you what to do you really need to push ahead and stay focused super hard on your own figure out a way for this super important
    end

    def prompt(board) # return an array with the position values like [1, 2]
        known_face_values = @known_cards.values # get all the known face values
        if known_face_values.detect { |e| known_face_values.count(e) > 1 } # if this returns any value instead of nil (.detect will return nil if nothing is found - here it is detecting if any face value has more than 1 count, i.e. 2 matches, in the @known_cards hash), then do the following behavior
            if board.previous_guess != [] # if @previous_guess exists, then this is a second turn, and you already know one of the values so you just have to match the other one now
                matching_face_value = @known_cards[board.previous_guess] # get the face value from the @previous_guess position, then delete that position and find the other matching occurrence of it
                @known_cards.delete(board.previous_guess) # delete this card so you can find the second occurrence of the card correctly
                matching_pos = @known_cards.key(matching_face_value) # find the position of the card that matches the face value of the previous guess, then you don't have to worry about deleting it below because the = assignment operator creates a new object and assigns matching_pos as a pointer to the new object, so no worries if you delete the original object, at least I think lol - we'll find out, this is only true for mutable objects that are being pointed to, not immutable ones, but these array positions are definitely mutable objects
                # @known_cards.delete(matching_pos) # delete the second card here too so you never match with these cards again, though you never should match when there's only one matching card in the hash - this is just for clarity's sake and completeness # so weird the problem is these deletions are definitely not going through # redundant to delete here it'll be deleted again later omg you finally got it lmfao. If you only deleted here and not in receive_match it would have been added back in with receive_revealed_card and never deleted again so it would have led to an error eventually so glad you actually caught this in the end so nuts
                return matching_pos # return the position of the card that matches the one previously guessed to guess them both, hell yeah
            else # else this is the first turn so just return whichever of the two positions love this code works so great
                known_matches = known_face_values.select { |e| known_face_values.count(e) > 1 } # select all the face values 
                return @known_cards.key(known_matches[0]) # just return the first position for which there are two card matches
            end
        end
        guessed_pos = [rand(0..3), rand(0..3)] # basic test to see if this works woohoo love this shit wow so amazing it works lmao so simple love this shit so much
        while @matched_cards.include?(guessed_pos) || @known_cards.include?(guessed_pos) # make sure that you don't guess matched cards or cards that are already known unless you know two of them, in which case this code won't run because the matching code above will be run - while your guess is a matched card, keep guessing new guesses love it # this code of not matching either of these is pretty powerful ensures that you'll never guess a guessed position again if everything else in the code runs right which makes the game go ultra fast and optimally
            guessed_pos = [rand(0..3), rand(0..3)]
        end
        guessed_pos # return this
    end

    def receive_revealed_card(pos, value) # LOL YOU NEVER FIXED THIS ISSUE THE WHOLE TIME LMAO YOU DELETED THE WRONG METHOD
        @known_cards[pos] = value # may need to set a specific []= method here, see if you do, not sure yet, and then call it on self[pos] instead, we'll see. Update - never mind, no need for this, amazing, so your other []= method was almost superfluous in the end but possibly not
    end

    # omfg thanks to the deletes here which you were a TOTAL IDIOT to remove because you thought they were redundant you could have saved literally hours of your life had you hilariously kept these in so fucking hilarious but also really proud of yourself for half figuring out the bug which is still the strangest bug ever but at least now you ensure that half the error doesn't cause any functional damage...wait nevermind you just checked now the code is working flawlessly and no @known_cards are left at all at the end of the game not a single one meaning that they're all being appropriately deleted by this method omg the game works flawlessly now finally lol but yeah the error was that the receive_revealed_cards method was being called before the receive_match method even on the turns where two cards were matched such that if you had deleted the @known_cards in the prompt method above one of the two matches would have been added back in with the receive_revealed_cards method and then not deleted ever, now with the deletes here, the false @known_cards being added back in that have already been matched are correctly deleted again after they are added because this method is called last after receive_revealed_card so amazing so good so lucky love your life figured it all out so great
    def receive_match(pos1, pos2) # omg doubly deleting here IS the solution because this shit fucking does send the known_card again so if you delete above it doesn't do shit LOL IT COMES BACK
        @matched_cards += [pos1, pos2] # need the brackets for array notation love it # brilliant caught the error in your code it's because the receive match comes after the board sends the receive_revealed_card thing back to it lmao so you always by bad design now receive the last card guessed in a matching pair in @known_cards since that method is passed to ComputerPlayer before this method is sent to ComputerPlayer on that turn and consequently blacklists the matching card, hence one of each matching pair is always actually in known cards, but it still shouldn't cause any issues because the other position should still be blacklisted, weird. How does it get into an infinite loop then of guessing these cards? It must be that two of the previously guessed positions somehow make it back into @known_cards, which is strange. At least you've identified half the issue for now. Let's move this out of this method.
        @known_cards.delete(pos1) # once the cards are known, delete them from the known_cards array so they aren't guessed again and you don't get stuck in an infinite loop guessing known cards. Doesn't matter if the key doesn't exist, it just returns nil, so don't have to check if it exists or not, just try deleting it anyway (one of these will have already been deleted above in the matching guess code)
        @known_cards.delete(pos2) # note can't chain deletes because delete returns the element being deleted I think so can't do @known_cards.delete(pos1).delete(pos2) which you did try first # omg if you deleted them here in the first place there would be no issues lmao
    end # testing small love it testing each bit of the code after you write it not the whole thing to make sure each bit runs, once you get code that runs at all, do this while adding new features, love it, building the beginning is always the hardest on its own

end