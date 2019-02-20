require 'colorize'

class Piece
    def initialize(color)
        @color = color
    end

    def colorizer(piece) # great OOP principles a parent class method awesome factored out that all the children classes use love it
        (@color == :white) ? piece.colorize(:white) : piece.colorize(:blue) # if the piece is white, print it as blue, otherwise print it as yellow lol
    end
end

class Pawn < Piece
    def to_s; colorizer("P") end # the key is to factor out even things that take the same lines of code but are just longer on that line than running a method love it
end

class King < Piece
    def to_s; colorizer("K") end
end

class Queen < Piece
    def to_s; colorizer("Q") end
end

class Rook < Piece
    def to_s; colorizer("R") end
end

class Bishop < Piece
    def to_s; colorizer("B") end
end

class Knight < Piece
    def to_s; colorizer("N") end
end

class NullPiece < Piece
    def initialize # no color here
    end

    def to_s; "-" end # just print an empty space for this bad boy --> make it a - and not a _ so it's centered in the middle of the grid display lol
end