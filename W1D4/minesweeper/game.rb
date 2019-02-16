# Things done
# Create Board and Tile classes
# Populate the @board with Tiles with a 10% chance of being a bomb
# Create Tile#neighbor_bomb_count to count the # of bombs near each Tile and to set a value in each tile that counts this number with Board#set_tile_values
# Render the board
# Get user input
# Implement the reveal functionality --> the recursive bit might be here call the recursive function on all the neighbor tiles unless base case is hit, and base case is if not all neighboring tiles are not bombs love it so great that they're still doing recursion --> ah no the recursive bit is in the user input section, right
# In the reveal functionality, check if the revealed tile has any adjacent bombs - if not, then reveal all of its adjacent neighbors too.
# If any of the adjacent neighbors have no bombs either, reveal all of their adjacent neighbors too.
# Basically, have a helper method that checks if any adjacent tiles to the one that is revealed are bombs and reveal or don't reveal based on that behavior.
# Check if the game is over - when a bomb is revealed, game over is triggered with a loss. If all the tiles except bombs are revealed, then the game is over with a win.
# Add functionality to not allow guessing an already revealed position

# Things to implement:
# Add functionality to flag squares
# Add save game functionality

# Bonus Features
# Very cool ones --> Cursor Input
# Time tracking for scorekeeping

require_relative './board.rb'
require 'byebug'

class Game
    def initialize; @board = Board.new; play_game end # just start the game, love it
    
    def play_game
        while !game_over?
            @board.render
            @board.guess(user_guess)
        end
        game_won? ? (puts "Congratulations, you won!") : (puts "Oh no, you hit a bomb and lost!") # if game_won? is true then put that they won otherwise put that they lost love it
        @board.reveal_all # show the whole board when the game is over
        @board.render
    end

    def inspect; end # empty method just so the game doesn't return itself as a return value when it ends, it just returns nothing now, awesome, inspect is just the default method for every class object that returns a bunch of info about that object when the object is evaluated to itself interesting so you can overwrite it like this very helpful to know

    def user_guess
        puts "Please enter a position to guess, like 0,0"
        validate_pos(gets.chomp.split(',').map(&:to_i)) # this will need to be refactored later for flagging but nice for now lol --> gets input from the user
    end

    def validate_pos(pos)
        row, col = pos
        if row == nil || col == nil || row < 0 || col < 0 || row > 8 || col > 8 # this works even though nil < 0 or something would hit an error because Ruby lazy evaluates and will return as soon as the first two ors are evaluated to true or not love it very cool
            puts "Position was not valid! Try again."
            user_guess          
        elsif @board.grid[row][col].revealed # if the revealed flag has already been turned on love it getting really good at this
            puts "Position has already been revealed! Try a new position."
            user_guess
        else
            pos
        end
    end

    def game_over?; game_won? || game_lost? end

    def game_won?; @board.grid.all? { |row| row.all? { |tile| tile.bomb ? true : tile.revealed } } end # if tile is a bomb, then return true, if it isn't, then return the value of tile.revealed, meaning that this only returns all true if all tiles are either bombs or have been revealed || this is almost recursive in its return - it returns the value of the innermost boolean for all --> if any innermost boolean is false, then the whole thing is false, and if they are all true, then the outside thing is true, love it || because you have gotten in the habit of writing these nested enumerators so much they are eaiser for you to read, which is quite nice

    def game_lost?; @board.grid.any? { |row| row.any? { |tile| (tile.bomb && tile.revealed) ? true : false } } end # wow that was easy to write like above, though likely not necessary - if a bomb is revealed, you can instantly just trigger the game over sequence but this is kind of elegant in its inefficiency lol --> checks if any tile is both a bomb and revealed, and if so, return true, if not, return false, if all false, then the thing returns false, if any is true, then it returns true, love it

end