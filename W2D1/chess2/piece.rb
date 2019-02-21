require 'colorize'
require 'singleton' # right need to require it nice

module Slideable
    @@HORIZONTAL_DIRS = Array.new # wtf are these supposed to be lol
    @@DIAGONAL_DIRS = Array.new
    def moves(directions) # directions being an array of symbols :diagonal and/or :straight
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
        moves([:diagonal, :straight])
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