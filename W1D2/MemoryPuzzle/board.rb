class Board
    attr_accessor :cards

    def initialize # maybe let them choose the number of cards later right now just hardcode to 16 cards, 8 pairs, grid of 4x4 to start
        @cards = Array.new(4) { Array.new(4) } # this is a hardcoded grid of 4x4 (8 pairs, 16 cards), all values nil in the subarrays for now until populated # the first number should be the row and the second is the column so @cards[0][1] gets from the first row, second column like so.
        self.populate # populate the board on initialization
    end

    # board:
    # @cards = [
    # [1, 2, 3, 4],
    # [1, 2, 3, 4],
    # [1, 2, 3, 4],
    # [1, 2, 3, 4]
    # ]

    # so it's an array with length 4 with 4 elements that are all arrays of length 4 such that you can call @cards[1][2] to get the card at row 2, column 3 love it super easy just walk through each step to make things less daunting always approach them and don't be afraid to approach things
    # very helpful to visualize that

    def [](pos)
        row, column = pos
        @cards[row][column]
    end

    def []=(pos, value)
        row, column = pos
        @cards[row][column] = value
    end

    def populate # should fill the board with all the shuffled card pairs
        face_values = ['cat','cat','dog','dog','mouse','mouse','squirrel','squirrel','octopus','octopus','lion','lion','seal','seal','frog','frog'] # 8 hardcoded possible face values
        # because the card index is random you can just go in sequential order and assign a new card awesome
        (0..3).each do |row| # iterate over subarray in the parent array
            (0..3).each do |column| # iterate over every element of each subarray in the parent array
                card_index = rand(0...face_values.length) # pick a random index of face_values to assign to the Card instance being instantiated
                pos = [row, column] # need to do this to define the array before passing it in below to the [] method
                self[pos] = Card.new(face_values[card_index]) # instantiate a new Card instance at the given position - note that you have to pass in to @cards an array with both columns, like [row, column], not two like [row][column] bc of how the #[]= method works, taking in an array of values instead of two values, love it, great debugging byebug is the best so glad you found this out. Also the second error was that the method [] and []= are for the board variable and are hence called on self, not on @cards[pos] that was screwing you up for a bit really grateful you figured it out in the end this course is amazing for really challenging your intellect cannot wait you know you can 100% perform in these tasks but man it really does challenge your intellect so crazy lucky 
                face_values.delete_at(card_index) # delete the face_value that was used so no repeats # ah bug was just used wrong method should be delete_at to delete at the index not delete which deletes all elements that match the value specified
            end
        end
    end

    def render # should print out a representation of the Board's current state
        system("clear") # clear output from the player in the terminal before rendering the board again so the player can't just see previous guesses
        @cards.each do |row|
            row.each do |card|
                if card.face_down # if card is face down, print "hidden"
                    print "hidden" + (" " * 4) # print out 4 trailing whitespaces to make everything a standard 10 characters of length so everything is displayed nicely and evenly
                else # oh man these whitespace multiplier things work flawlessly to render the board love it the game almost all works correctly just a few tiny bugs to smush out incredible
                    print card.display + (" " * (10 - card.display.length)) # else print the face value plus however many whitespaces are needed to create a total length of 10 characters # that was a strange typo you had card.reveal instead of card.display lol thank god for byebug so great crushes everything so fast love it
                end
            end
            puts # to create a new line
        end
        sleep(1) # pauses the program for a second to show the guesses before flipping the cards face-down again
    end

    def won? # should return true if all cards have been revealed
        @cards.all? { |row| row.all? { |card| !card.face_down } } # only returns true if every card is face_up and revealed
    end

    def reveal(guessed_pos) # should reveal a Card at guessed_pos (unless already face-up, in which case it should do nothing). It should also return the value of the card it revealed
        if @cards[guess_pos].face_down
            @cards[guess_pos].reveal # flip the card face_up
            @cards[guess_pos].display # show the card's value
        end
    end
end