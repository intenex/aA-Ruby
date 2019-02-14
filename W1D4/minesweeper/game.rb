# Things done
# Create Board and Tile classes
# Populate the @board with Tiles with a 10% chance of being a bomb

# Things to implement:
# Render the board --> the recursive bit might be here call the recursive function on all the neighbor tiles unless base case is hit, and base case is if not all neighboring tiles are not bombs love it so great that they're still doing recursion
# Randomly assign the bomb values to each tile with some probability (like 10% are bombs)
# Implement the reveal functionality
# In the reveal functionality, check if the revealed tile has any adjacent bombs - if not, then reveal all of its adjacent neighbors too.
# If any of the adjacent neighbors have no bombs either, reveal all of their adjacent neighbors too.
# Basically, have a helper method that checks if any adjacent tiles to the one that is revealed are bombs and reveal or don't reveal based on that behavior.
# Check if the game is over - when a bomb is revealed, game over is triggered with a loss. If all the tiles except bombs are revealed, then the game is over with a win.
# Add functionality to flag squares
# Add save game functionality

class Game
    def initialize
    end
end