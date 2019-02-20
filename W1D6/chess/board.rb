require_relative 'piece'
require 'byebug' # byebug finds every bug in literally seconds lol so insane you're so lucky to love this stuff *and* be rather good at it and to especially be good at debugging really was worth getting really good at no question can identify every bug so quickly now

class Board # getting very good at this love it just fucking dive in and crush it don't ever get discouraged by large projects you know that by now man being well rested is so fucking good, no distractions just killing it
    # include Singleton # should only be one of these --> nvm fuck this no idea how to use it yet save it for later lol

    def initialize
        @grid = Array.new(8) { Array.new(8) } # an 8 x 8 chess grid
        set_back_row(:black, 0)
        set_pawns(:black, 1)
        set_back_row(:white, 7)
        set_pawns(:white, 6)
        (2..5).each { |row| @grid[row].each_index { |col| @grid[row][col] = NullPiece.new } } # set the NullPieces in all the places where real pieces haven't been set
    end

    def set_back_row(color, row) # awesome you can pass in symbols and not specify here that it should be a symbol explicitly nice, in fact you *can't* specify a symbol here awesome if you did that it wouldn't put the variable you passed in it would just put the symbol love it no real need to pass in a symbol but why not lol learn more about symbols and when to use them correctly later for sure though so good to be off Slack all distractions from better coding and more coding so lucky to be in this focused state now so much wasted time it's insane no more now # you actually do need to instantiate each piece in here not out of here so better to just keep it like two separate methods instead of one single set_row method where you pass in the pieces to set hmm
        pieces = [Rook.new(color), Knight.new(color), Bishop.new(color), Queen.new(color), King.new(color), Bishop.new(color), Knight.new(color), Rook.new(color)]
        @grid[row].each_index { |col| @grid[row][col] = pieces.shift } #remove a piece from pieces and set the @grid at that index location to that piece
    end

    def set_pawns(color, row)
        @grid[row].each_index { |col| @grid[row][col] = Pawn.new(color) }
    end

    def move_piece(start_pos, end_pos)
    end

end