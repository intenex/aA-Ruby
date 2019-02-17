# Things to implement:
# Add save game functionality

# Bonus Features
# Very cool ones --> Cursor Input
# Time tracking for scorekeeping

require_relative './board.rb'
require 'yaml'
require 'byebug'

class Game
    def initialize; @board = Board.new; play_game end # just start the game, love it
    
    def play_game
        load_game
        while !game_over?
            @board.render
            @board.guess_or_flag(user_guess)
        end
        game_won? ? (puts "Congratulations, you won!") : (puts "Oh no, you hit a bomb and lost!") # if game_won? is true then put that they won otherwise put that they lost love it
        @board.reveal_all # show the whole board when the game is over
        @board.render
    end

    def load_game
        puts "Would you like to load a game? Y/N"
        answer = gets.chomp.downcase
        if answer == "y"
            puts "Please enter the filename you would like to load."
            begin
                loaded_file = YAML::load(IO.read(gets.chomp)) # http://ruby-doc.org/core-2.6.1/IO.html#method-c-read on IO and https://github.com/appacademy/curriculum/blob/master/ruby/readings/serialization.md on YAML loading awesome. Set the board equal to this object basically
                if loaded_file.is_a?(Board) # check if this is indeed a valid Board object that was loaded - if so, continue the game, if not, have them reload
                    @board = loaded_file
                else
                    puts "Sorry, that was not a valid save game file. Please try again."
                    load_game
                end
            rescue => exception
                puts "Sorry, that file could not be loaded. Please try again."
                load_game
            end
        elsif answer != "n" # no need to have a condition for N bc it'll just return nothing and move on with the game if N
            puts "Sorry, that was an invalid command. Please enter Y or N."
            load_game # yay recursion
        end
    end

    def inspect; end # empty method just so the game doesn't return itself as a return value when it ends, it just returns nothing now, awesome, inspect is just the default method for every class object that returns a bunch of info about that object when the object is evaluated to itself interesting so you can overwrite it like this very helpful to know

    def user_guess
        puts "Please enter a position to guess (G,1,2),\nflag (F,2,3), unflag (U,3,4), or save the game (S)"
        validate_pos(gets.chomp.split(',')) # this will need to be refactored later for flagging but nice for now lol --> gets input from the user
    end

    def validate_pos(pos)
        g_or_f_or_s, row, col = pos
        row = row.to_i; col = col.to_i # ah did two == signs here by accident that was the issue of course
        if g_or_f_or_s.downcase != "g" && g_or_f_or_s.downcase != "f" && g_or_f_or_s.downcase != "u" # these statements evaluate in order and that's important if these were in different order there could be some errors here
            puts "That was not a valid guess, flag, or unflag. Try again."
            user_guess
        elsif row == nil || col == nil || row < 0 || col < 0 || row > 8 || col > 8 # this works even though nil < 0 or something would hit an error because Ruby lazy evaluates and will return as soon as the first two ors are evaluated to true or not love it very cool
            puts "Position was not valid! Try again."
            user_guess
        elsif @board.grid[row][col].revealed # if the revealed flag has already been turned on love it getting really good at this
            puts "Position has already been revealed! Try a new position."
            user_guess
        elsif @board.grid[row][col].flagged && g_or_f_or_s.downcase != "u" # if they're trying to guess or flag a position and not unflag it and it's been flagged
            puts "That position has been flagged. It must be unflagged before being guessed."
            user_guess
        elsif !@board.grid[row][col].flagged && g_or_f_or_s.downcase == "u"
            puts "That position has not been flagged, so it cannot be unflagged. Try again."
            user_guess
        else
            [g_or_f_or_s.downcase, row, col]
        end
    end

    def game_over?; game_won? || game_lost? end

    def game_won?; @board.grid.all? { |row| row.all? { |tile| tile.bomb ? true : tile.revealed } } end # if tile is a bomb, then return true, if it isn't, then return the value of tile.revealed, meaning that this only returns all true if all tiles are either bombs or have been revealed || this is almost recursive in its return - it returns the value of the innermost boolean for all --> if any innermost boolean is false, then the whole thing is false, and if they are all true, then the outside thing is true, love it || because you have gotten in the habit of writing these nested enumerators so much they are eaiser for you to read, which is quite nice

    def game_lost?; @board.grid.any? { |row| row.any? { |tile| (tile.bomb && tile.revealed) ? true : false } } end # wow that was easy to write like above, though likely not necessary - if a bomb is revealed, you can instantly just trigger the game over sequence but this is kind of elegant in its inefficiency lol --> checks if any tile is both a bomb and revealed, and if so, return true, if not, return false, if all false, then the thing returns false, if any is true, then it returns true, love it

end