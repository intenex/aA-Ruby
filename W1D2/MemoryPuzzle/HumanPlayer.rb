class HumanPlayer
    attr_reader :name
    def initialize # do you even need an initialize def if nothing in here probably not
    end

    def prompt(board) # need to pass the board as a dummy variable to match ComputerPlayer's prompt class which needs it for checking if a board.previous_guess exists
        puts "Enter a position to guess like so: '1 2'"
        guessed_pos = gets.chomp.split.map!(&:to_i) # get the input, take out the new line character, split it into an array based on whitespace, and convert every element to an integer # flesh this out more later to return an error if this isn't all possible especially the to_i method is important to get right # update wow super lucky don't actually have to flesh this out it doesn't return an error now and the prompt seems to be foolproof love it so lucky lol now just need to fix the other minor errors and the game legitimately just works great wow
        if guessed_pos.kind_of?(Array) && guessed_pos.length == 2 && guessed_pos.all? { |num| num >= 0 && num <= 3 } # if you were passed a correct guess with an array with two numbers and they're all between 0 and 3 then good else not good # wow nuts their valid_pos checker is literally exactly the same as this totally nuts
            guessed_pos # return the guessed_position if it passes all the sanitation checks
        else
            puts "That was an invalid entry. Please try again."
            self.prompt(board) # infinite recursion woohoo! Do this more later love this stuff
        end
    end

    def receive_revealed_card(pos, value) # dummy method for humans that computers need to receive results and save the results
    end

    def receive_match(pos1, pos2)
    end

end