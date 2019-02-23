require_relative 'piece'
require 'byebug' # byebug finds every bug in literally seconds lol so insane you're so lucky to love this stuff *and* be rather good at it and to especially be good at debugging really was worth getting really good at no question can identify every bug so quickly now
# 2.5 hours to finish part 1 with all the extra bonus ends and pieces and really taking your time to dive into everything well love it
# last thing you need to do in part 2 is to get the #checkmate? method working but yeah you're fucking lit to move on fucking awesome

class Board # getting very good at this love it just fucking dive in and crush it don't ever get discouraged by large projects you know that by now man being well rested is so fucking good, no distractions just killing it
    # include Singleton # should only be one of these --> nvm fuck this no idea how to use it yet save it for later lol

    attr_accessor :grid # only the board itself should move pieces on the board, display should just display them obviously, so only a reader needed here

    def initialize
        @grid = Array.new(8) { Array.new(8) } # an 8 x 8 chess grid
        set_back_row(:black, 0)
        set_pawns(:black, 1)
        set_back_row(:white, 7)
        set_pawns(:white, 6)
        (2..5).each { |row| @grid[row].each_index { |col| @grid[row][col] = NullPiece.instance } } # set the NullPieces in all the places where real pieces haven't been set. use .instance and not .new since you included Singleton for NullPiece meaning .new is now a private method and you use .instance to call the one instance ever made of NullPiece lol
    end

    # insane you can actually start testing moving pieces right now amazing
    def move_piece(start_pos, end_pos)
        s_row, s_col = start_pos
        e_row, e_col = end_pos
        piece = @grid[s_row][s_col] # yeah these variables are very helpful actually just write your code cleaner like this it obviously pays off on the larger projects like this so definitely do it better and be better about your code it doesn't matter if it's longer if it's more maintainable obviously better, and the *more* lines of code you write the more impressive something is, not the other way around usually lmao so longer programs are better lol when you get into the real world, versus your strange fixation on hyper conciseness and efficiency here lol when you know you're doing the same thing so if you can do it shorter it feels better lol, fix that
        if piece.is_a?(NullPiece)
            raise ArgumentError.new("There is no piece at that start position. Try again.") # handle this exception with a retry in the method that calls this method
        elsif !piece.moves.include?(end_pos) # if the moves the piece can move to don't include the end_pos then you can't move there so raise an error # wow modularity and good methods make this so simple incredible
            raise ArgumentError.new("The selected piece cannot move to that position. Try again.")
        else # if no errors, then replace the current start position with the NullPiece no matter what since if it's an empty space you're putting a NullPiece there, and if it's not an empty space well, you're still capturing the piece so not swapping them awesome
            @grid[s_row][s_col], @grid[e_row][e_col] = NullPiece.instance, piece # swap the two positions with a parallel assignment - later raise an error if the piece cannot be moved there with an InvalidPositionError or something and then handle it elsewhere. See if this piece swap works now amazing
            piece.pos[0], piece.pos[1] = e_row, e_col # must update the piece's position after moving otherwise it still thinks it's at the original position # hilariously this shortsteps you needing an attr_accessor for Piece.pos because you aren't changing the assignment just each individual element lmao so bad though should just make an attr_accessor to make it more readable but this is just so cool but yeah will lead to more confusion around why things are the way they are later probably, but that's what your billions of comments are for, crazy that this game is coming along so well, literally cannot believe you forgot you made this method lol
        end
    end

    def dup # whew think this finally works great lol
        new_board = Board.new
        new_board.grid.map!.with_index do |row, row_i| # mutate the old array to be all these returns
            row.map.with_index do |col, col_i| # don't need to mutate this one since it'll be mutated above with the return from this anyway
                old_piece = @grid[row_i][col_i]
                if old_piece.is_a?(NullPiece) # if it's a NullPiece just return it as is otherwise create the new one
                    new_piece = old_piece # same as calling NullPiece.instance again, just another NullPiece
                else
                    new_piece = old_piece.clone # not 100% sure on the differences between clone and dup yet but clone seems safer to preserve the singleton state of NullPiece at least
                    new_piece.board = new_board
                    new_piece
                end
            end
        end
        new_board
    end

    def valid_pos?(pos)
        row, col = pos
        row >= 0 && row < 8 && col >= 0 && col < 8 # return the result of this lol if it's true then return true else false see if it works wow you love writing code on your own actually better than pair programming you think better by yourself for sure not someone who concentrates or can function well pair programming yet at least. You need time to be able to reflect on your own. Hmm.
    end

    # omfg briefly tested and it WORKS LOL modular coding holy fuck and method breaking actually works learn how to make modular methods way better but my god this is incredible
    def in_check?(color)
        king_pos = [] # may not need this if the variable assignment can just happen for the first time in the line below check it later
        @grid.each { |row| row.each { |piece| (king_pos = piece.pos) if (piece.is_a?(King) && piece.color == color) } } # I think eaches work like this we'll see lol a nested each may not, yeah it doesn't fix it for now and do it later. This is poor code writing figure out a better way
        @grid.any? { |row| row.any? { |piece| (piece.moves.include?(king_pos)) && (piece.color != color) } } # return the result of this double nested any of which the innermost returns any value other than false or nil - note that, it doesn't only return true if any value inside returns true, just if it returns anything besides false or nil, interesting. Interesting design and very important to read the documentation for everything in depth. And then if the innermost any? returns true then the outermost any? returns true then the whole method returns true, otherwise the whole thing returns false heh awesome. Very Ruby specific things. Will need to learn how to do these in other languages for sure though thankfully most things are the same.
    end

    def checkmate?(color)
        # write an enumerator that checks if any of :color player's pieces have any #valid_moves, if not then in check, like something like this
        !@grid.any? { |row| row.any? { |piece| (!piece.valid_moves.empty?) && (piece.color == color) } } # then the ! changes the return boolean value so hopefully this works if #valid_moves works as you think it might lol and it's specific to some check function thing --> I guess maybe valid_moves might change with a conditional if check is activated to only see positions that can protect the king that would be interesting
    end

    private # these shouldn't be called by anything else, only in initialize

    def set_back_row(color, row) # awesome you can pass in symbols and not specify here that it should be a symbol explicitly nice, in fact you *can't* specify a symbol here awesome if you did that it wouldn't put the variable you passed in it would just put the symbol love it no real need to pass in a symbol but why not lol learn more about symbols and when to use them correctly later for sure though so good to be off Slack all distractions from better coding and more coding so lucky to be in this focused state now so much wasted time it's insane no more now # you actually do need to instantiate each piece in here not out of here so better to just keep it like two separate methods instead of one single set_row method where you pass in the pieces to set hmm
        pieces = [:Rook, :Knight, :Bishop, :Queen, :King, :Bishop, :Knight, :Rook] # need to call these from inside the @grid[row][col] thing to be able to pass the position [row, col] correctly to the piece as specified in the Chess UML - use this Array and const_get to correctly convert this to a call of the Class name lol amazing there's a way to do everything if you just know how insane amazing that StackOverflow exists and people really know everything programmers really are the best and so nice with StackOverflow the basic truth of human nature is people love helping each other create a StackOverflow for everything, really, though they already did do that lmao https://stackoverflow.com/questions/10568173/class-instance-creating-with-class-name-in-variable-ruby # omfg this makes sense const_get works because Class names are CONSTANTS LOL so it checks if there's a constant with that name given AMAZING you can definitely do this on symbols too so make it a symbol since that's more *symbolic* of a constant fucking love it brilliant hack
        @grid[row].each_index { |col| @grid[row][col] = Object.const_get(pieces.shift).new(color, self, [row, col]) } #remove a piece from pieces and set the @grid at that index location to that piece
    end

    def set_pawns(color, row)
        @grid[row].each_index { |col| @grid[row][col] = Pawn.new(color, self, [row, col]) }
    end
end