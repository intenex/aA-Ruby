class Piece
    def initialize(color)
        @color = color
    end
end

class Pawn < Piece
end

class King < Piece
end

class Queen < Piece
end

class Rook < Piece
end

class Bishop < Piece
end

class Knight < Piece
end

class NullPiece < Piece
    def initialize # no color here
    end
end