# Memory Puzzle goals:
# Understand how classes interact in an object-oriented program
# Be able to use require_relative
# Be able to write the methods [] and []= and explain how they work
# Develop a workflow that uses pry to test small parts of your code
# Know how to initialize an Array with a default value
# Know how to use duck typing to allow different classes to interact with your program

# tells you exactly what to do still which is nice

# omg the game is kind of working crazy proud of yourself lol
# omg so crazy rewarding it all works just need to handle exceptions now
# if you can get through all the material on your own then you know that the material is good and one can indeed learn from it, though perhaps not at such a pace as they'll teach you, so amazing

require_relative './board.rb'
require_relative './card.rb'
require_relative './HumanPlayer.rb'
require_relative './ComputerPlayer.rb'

class Game
    attr_accessor :previous_guess, :board, :player # ahh I think your mistake was that board does indeed need to be an attr_accessor in order to call its methods to manipulate its variables that took a while for you to figure out lol, omg all finally fixed, so rewarding

    def initialize(player)
        @player = player
        @board = Board.new
        @previous_guess = []
    end

    def play
        while !@board.won? # while the game is not yet won
            @board.render # render the board and ask for a prompt
            guessed_pos = player.prompt(self) # pass the self Game object to the player class so the AI can call it to see if @previous_guess matches anything to see how it should guess cards and to know if it's on its first turn of a set or its second
            while self.already_guessed?(guessed_pos)
                puts "That position has already been guessed! Try something new."
                guessed_pos = player.prompt(self) # keep prompting again if already guessed until not guessed
            end
            self.make_guess(guessed_pos)
        end
        puts "Congratulations, you won!"
    end

    def already_guessed?(guessed_pos) # check if the guess was already guessed - either if it is the same position as the last guess, or if the card that it would reveal has already been revealed with the Card.revealed attribute
        return true if guessed_pos == @previous_guess # if the guess is the same as the previous guessed position, return true
        @board[guessed_pos].revealed # otherwise, return the boolean of .revealed, which is false if not already revealed, which means this should return false too as in not already guessed, or true if revealed, which means this also returns true, as in already guessed
    end

    def make_guess(guessed_pos) # wow just one last piece of logic left then this is runnable so incredible
        @board[guessed_pos].reveal # reveal the card that was guessed and flip it face up
        @player.receive_revealed_card(guessed_pos, @board[guessed_pos].face_value) # send the position guessed and the face value of the card at that position to the player so they can store it #omg you idiot you deleted the wrong method that was working correctly lmao this was the issue and you NEVER FIXED IT LOL
        @board.render # render the board with the new card that was guessed, then decide what to do next, whether a guess was already in progress and both cards match and should be kept up, or both don't and both should be turned down, or if there was no guess and this was the first guess and should be kept up until the next guess
        if @previous_guess == [] # if there was no previous guess
            @previous_guess = guessed_pos # set the previous_guess to the guessed position
        else # otherwise, if a card was already guessed, see if it matches the current guessed card. ### NOTE - put something in here to make sure they can't just guess the same position again
            check_guess(guessed_pos) # call this method that determines if a guess is correct or not and does the appropriate behavior - either revealing both cards or hiding them
        end
    end

    def check_guess(guessed_pos)
        if @board[guessed_pos] == @board[@previous_guess] # if the positions are correct, then set the revealed flag on both cards to true so the cards can't be guessed again
            @board[guessed_pos].revealed = true
            @board[@previous_guess].revealed = true # wow you had a misspelling here truly errors can come from anywhere lucky to have spotted it so quickly coding is tough debugging is everything for sure love this so much
            @player.receive_match(guessed_pos, @previous_guess)
        else # if the current guessed card is not equal to the last guessed card, hide both cards, otherwise keep them face up. Can just do object == object bc the method is defined in the Card class with exactly what to compare (face_values)
            @board[guessed_pos].hide # hide the current guessed card
            @board[@previous_guess].hide # hide the last guessed card
        end
        @previous_guess = [] # reset this since two guesses have been made and it's time to replay
    end

end

# can't believe that this really is all the logic to the game and you did actually write it out and there was nothing particularly challenging just needed to break it down into steps such a great lesson can't wait to run this and see how it works and amazing how well you can just read code and be able to expect how it works man bootcamps are literally the best so amazing that they exist don't ever listen to stigma duck type qualifications - if they can quack like a duck and fly like a duck, they are a duck. Judge the people who come out of these programs by how good they really are versus those who go to a 4 year university, don't just assume on the face of things without evaluation that they can't be as good. Can't wait to see where you get after this. Review all your code from the day before for each lesson up to the point where you've done it when you start your cohort. Lucky enough you should be able to help Stella get through the first 6 weeks so she can't get kicked out anymore after that by the time you start your cohort, so that's great motivation to get through the first 6 weeks of material both for yourself and for her before your cohort starts, can't wait. Just need to 100% really crush this and keep studying as much stuff as is humanly possibly and learn all the algorithms and truly understand OOP and everything, can't wait. Teaching everyone after you're done with this class would be amazing if you can pull it off as a TA or something, love it. Be better than the teachers, always focus to be better and learn more until you know absolutely everything.