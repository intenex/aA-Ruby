require 'colorize'
require 'singleton' # right need to require it nice

# assume position is 4, 4
# Possible moves: --> Always 14 possible moves
# [4,5], [4,6], [4,7]
# [4,3], [4,2], [4,1], [4,0]
# [5,4], [6,4], [7,4]
# [3,4], [2,4], [1,4], [0,4]
# Easy to calculate -- great, writing it all out is the way to do things, love it. Definitely just writ eit all out for it work. Do one step at a time too break it down and add complexity later too difficult to attack just straight up
# refactoring things is easy and you're super comfortable writing code again this is fucking amazing keep being like this and just crush it with familiarity you *always* get what you put in so always put in the most and you'll crush it all fucking love this shit

# okay time for diagonal slide
# assume position is 4, 4



def straight_slide(row, col)
    up = check_blocking_pieces((0...row).map { |new_r| [new_r, col] }.reverse) # reverse this to traverse out from the piece's current location now and use the check_blocking_pieces thing to see if there are any blocking pieces in the way incredible
    down = check_blocking_pieces((row+1..7).map { |new_r| [new_r, col] })
    left = check_blocking_pieces((0...col).map { |new_c| [row, new_c] }.reverse) # you'll want to reverse this to traverse out from the piece itself hah omg this works perfectly lmao
    right = check_blocking_pieces((col+1..7).map { |new_c| [row, new_c] })
    (up + down + left + right) # return all the arrays together love it
end

def check_blocking_pieces(moves) # works fucking brilliantly love it and testing in pry is so fucking great fucking love your workflow
    moves.each_with_index do |move, index| # omg this is using each perfectly, because if it doesn't return inside this helper method it'll just return what was passed to it as is that's what .each is good for - either doing some random action for each enumeration or even more ideally just returning a different value if something inside is different or returning the whole thing if not fucking incredible
        return moves.slice(0...index) if !@board[move[0]][move[1]].is_a?(NullPiece) # only get the moves before the first blocking piece is found, immediately return once/if a non NullPiece is found in the path # if the current position is not a null piece, then return this with a truncated version of the array
    end
end

module Slideable # see if you need an getter method to read the current position and all that
    @@HORIZONTAL_DIRS = Array.new # wtf are these supposed to be lol
    @@DIAGONAL_DIRS = Array.new
    def moves(directions) # directions being an array of symbols :diagonal and/or :straight --> should return an array of places that the piece can move to
        row, col = @pos # get the row and col to see which ways the thing can move
        possible_moves = Array.new

        if directions.include?(:straight)
            # write this for :straight and :diagonal shovel into possible_moves the possible moves from te current @pos to every other position on the board *except* when blocked by another piece
            
        end
    end
end

module Stepable
    def moves
    end
end

class Piece
    def initialize(color, board, pos)
        @color = color
        @board = board
        @pos = pos
    end

    def to_s; colorizer(@symbol) end # hmm I wonder if you can colorize symbols we'll find out I guess lol othwerise just convert it to a string wow this diagram thing is super helpful actually lmao not that much to write at all fucking love it

    private
    def colorizer(piece) # great OOP principles a parent class method awesome factored out that all the children classes use love it
        return piece.to_s.colorize(:light_cyan) if piece == :- # if the piece is a NullPiece return this color otherwise return the color of the side the piece is of, white or black. Works great love it
        (@color == :white) ? piece.to_s.colorize(:white) : piece.to_s.colorize(:blue) # if the piece is white, print it as blue, otherwise print it as yellow lol # yep need to turn the symbol into a string before running colorize on it but this works great fuck yeah all greatly refactored so glad the setting the back row thing worked so fine lol
    end
end

class Pawn < Piece
    def initialize(color, board, pos); super; @symbol = :P end

    def move_dirs
    end
end

class King < Piece
    def initialize(color, board, pos); super; @symbol = :K end

    def move_diffs
    end
end

class Queen < Piece
    include Slideable

    def initialize(color, board, pos); super; @symbol = :Q end

    def move_dirs # for the Slideable module
        moves([:diagonal, :straight]) # love it should return an array of places the piece can move to love it
    end
end

class Rook < Piece
    include Slideable

    def initialize(color, board, pos); super; @symbol = :R end

    def move_dirs
        moves([:straight])
    end
end

class Bishop < Piece
    include Slideable

    def initialize(color, board, pos); super; @symbol = :B end

    def move_dirs
        moves([:diagonal])
    end
end

class Knight < Piece
    def initialize(color, board, pos); super; @symbol = :N end

    def move_diffs
    end
end

class NullPiece < Piece # hmm Singleton interesting look into that later you'll need to take out these to_s's sigh
    include Singleton

    def initialize; @symbol = :- end # they say make sure to read your color here but can't see how this could have a color since there's only one NullPiece ever hmm

    def moves
    end
end