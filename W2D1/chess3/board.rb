require_relative 'piece'
require 'byebug'
# byebug finds every bug in literally seconds lol so insane you're so lucky to love this stuff *and* be rather good at it and to especially be good at debugging really was worth getting really good at no question can identify every bug so quickly now
# 2.5 hours to finish part 1 with all the extra bonus ends and pieces and really taking your time to dive into everything well love it
# last thing you need to do in part 2 is to get the #checkmate? method working but yeah you're fucking lit to move on fucking awesome

class Board # getting very good at this love it just fucking dive in and crush it don't ever get discouraged by large projects you know that by now man being well rested is so fucking good, no distractions just killing it
    # include Singleton # should only be one of these --> nvm fuck this no idea how to use it yet save it for later lol

    attr_accessor :grid # only the board itself should move pieces on the board, display should just display them obviously, so only a reader needed here
    attr_reader :en_passant

    def initialize
        @grid = Array.new(8) { Array.new(8) } # an 8 x 8 chess grid
        @en_passant = Array.new # when this is set, the first position in the array is the position of the pawn to be captured, and the second position is the position that the pawn to be capturing is moving into # fucking awesome, this sets the en_passant flag for one turn, whenever a pawn makes a double_step move this flag is triggered by going from empty to holding two positions - first the position of the pawn that just did a double step, and two the position that the pawn trying to capture the double jumped pawn needs to move into to capture it, then on the next turn if en_passant is triggered, check if the current moving piece is attempting to capture the pawn that just set this @en_passant, if not, reset the @en_passant to empty, fucking perfect and so easy. Just need to now put this in the Pawn's valid moves too on that one turn, that's the last step, fucking amazing, but since this is all happening in the board that's easy enough to do since the @board is passed to each Piece fucking love this shit glad you got castling out of the way because this is easier though that wasn't obvious to see at first until you dove in and started working with it, love this shit so much
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
        elsif !piece.valid_moves.include?(end_pos) # love it awesome test this
            raise ArgumentError.new("That move would leave you in check! Try again.")
        elsif piece.is_a?(King) && piece.castle_pos.include?(end_pos) # if the piece is a King (note - don't need to check if it hasn't already moved because that check is already handled in Piece where it only appends castling moves as valid if the King has never moved love it) nd it is attempting to move to one of its castle positions then it must be attempting to castle
            castle(piece, start_pos, end_pos) # unlike the pawn_promotion don't rescue here, you want to rescue the pawn promotion here since you don't want them to put in another move, just to enter a right promotion value, here you want the error to actually bubble up to the HumanPlayer and for them to select another move since if it's an invalid move it'll always be invalid if you keep retrying just here so they need to select another move
        elsif piece.is_a?(Pawn) && ((end_pos[0] == 0) || (end_pos[0] == 7)) # if the pawn is upgrading into a full piece amazing and castling
            begin
                pawn_promote(piece, start_pos, end_pos)
            rescue ArgumentError => e
                puts e
                retry
            end
        elsif !@en_passant.empty? && piece.is_a?(Pawn) && (end_pos == @en_passant[1]) && (piece.color != @grid[@en_passant[0][0]][@en_passant[0][1]].color) # && (piece.pos[1] != @en_passant[0][1]) # NOTE - this last commented out piece doesn't hurt to add it but it isn't necessary, it just double checks that the pawn doing the en passant capture is not on the same column as the pawn being captured and that it is indeed a valid side attack and not some insane situation where a pawn of the opposite color happens to be able to not side attack and just step into that place where the en passant should have happened this is I think impossible on the board though so fine to leave it out until further notice man actually knowing how chess is played is kind of important super lucky you have that knowledge to really put this thing together # if an @en_passant is available and the current piece is a Pawn that's moving to the capture square of the @en_passant (the empty space that the enemy Pawn double stepped over) and the Pawn that's moving to that square is of a different color from the @en_passant square, then it must be an en passant so execute that behavior and reset the en passant flag love it. Love that because you play chess you can think of all the edge cases easily so you really are the best suited to make this game, so lucky to get to do this. # NOTE: Importantly, the *column* of the capturing pawn must be different from the pawn being captured, otherwise all the other checks fail and you can literally just move a pawn up to the en passant pawn piece and capture it even of the different color actually weird that shouldn't have been able to happen hmm look into it. The collection of moves was e4, d5, e5, then e6 by black somehow captured the e5 pawn by white despite the en_passant likely having been flagged by the black pawn jumping to d5 two moves ago, otherwise no idea what it was. Putting that final check in here seems to have caught this error though fundamentally somewhere else there is likely still this error, let's leave it out and catch it again and see what happens. Ahhh the problem was you never set the piece.moved flag for the pawn amazing super crazy easy for you to debug and to do it correctly now and actually find these things so lucky amazing man great that you solved it correctly and also figured out this last safety check just because why not though it should never happen actually it could yeah you could somehow have a pawn that moved into that position no that's not possible at all but it's not a bad check but yeah I don't think there's ever a case in which a pawn of an opposite color would be able to move into the space where it jumped passed yeah totally impossible
            @grid[s_row][s_col], @grid[e_row][e_col] = NullPiece.instance, piece # move the Pawn accordingly
            @grid[@en_passant[0][0]][@en_passant[0][1]] = NullPiece.instance # remove the enemy pawn that should be captured fucking love it I think this is all the en passant logic you need holy shit that was not too hard even though it actually did take a hilarious amount of time so amazing though lmao you actually implemented fucking pawn promotion, castling, and en passant and the game is a perfect rendition of chess now holy fucking shit
            piece.pos = end_pos # gotta remember this bad boy! heh. Lots of refactoring to do still but my god does it all work gloriously
            @en_passant = Array.new # reset the @en_passant
        else # if no errors, then replace the current start position with the NullPiece no matter what since if it's an empty space you're putting a NullPiece there, and if it's not an empty space well, you're still capturing the piece so not swapping them awesome
            (@en_passant = Array.new) if !@en_passant.empty? # if the @en_passant trigger has been set from last turn and hasn't been triggered already in an elsif above then remove the flag as it can no longer be attacked on the next turn love it
            if piece.is_a?(Pawn) && !piece.moved && ((end_pos[0] == 4) || (end_pos[0] == 3)) # if the piece is a pawn and it's never moved and it just moved two spots, aka a double step move, then set the en_passant flag for one turn
                (end_pos[0] == 4) ? (capture_pos = [5, e_col]) : (capture_pos = [2, e_col]) # if the Pawn is a white pawn then the capture position is on row 5, else if black pawn, capture position is on row 2
                @en_passant = [end_pos, capture_pos] # this sets the @en_passant attribute with two positions, one with the position of the Pawn to be captured that just double step moved (so you know which position to replace with a NullPiece easily), and one with the position that a Pawn needs to move to in order to capture the piece, and so you can use the second position easily to see if it's a pawn moving to an en_passant capture position here and in Piece to add it to valid_moves
            end
            (piece.moved = true) if ((piece.is_a?(King) || piece.is_a?(Rook) || piece.is_a?(Pawn)) && !piece.moved) # if you're moving either the King or the Rook and they haven't been moved before set their moved flag to true for castling purposes
            @grid[s_row][s_col], @grid[e_row][e_col] = NullPiece.instance, piece # swap the two positions with a parallel assignment - later raise an error if the piece cannot be moved there with an InvalidPositionError or something and then handle it elsewhere. See if this piece swap works now amazing
            piece.pos = end_pos # OMG THE OLD VERSION OF THIS TOTALLY FUCKED YOU UP LOL IT TURNED OUT TO ACTUALLY BITE YOU IN THE ASS LOLOLOL because you were fucking playing with attr_reader/fire and wanted to do the trolly piece.pos[0], piece.pos[1] = e_row, e_col instead of just the totally fucking reasonable reassignment of piece.pos = end_pos with an attr_accessor you didn't reassign it and just changed the pointer of the old position which totally fucked up the board when you were running checkmate? when valid_moves? dupes the board yet you had the pointer to the same position and that totally fucked shit up lmfao let's fix this now dying thank god your debugging skills are god and you figured this out so quickly shockingly LOL had it been a while before you saw your code though would have been hard I think # must update the piece's position after moving otherwise it still thinks it's at the original position # hilariously this shortsteps you needing an attr_accessor for Piece.pos because you aren't changing the assignment just each individual element lmao so bad though should just make an attr_accessor to make it more readable but this is just so cool but yeah will lead to more confusion around why things are the way they are later probably, but that's what your billions of comments are for, crazy that this game is coming along so well, literally cannot believe you forgot you made this method lol
        end
    end

    def move_piece!(start_pos, end_pos) # for Piece#valid_moves to see if a move would leave a player in check
        s_row, s_col = start_pos
        e_row, e_col = end_pos
        piece = @grid[s_row][s_col]
        if !piece.is_a?(NullPiece) # just don't do anything if it's a NullPiece since this is used by checkmate? which enumerates over every piece including NullPieces and simulates moving them important that NullPieces are accounted for here and just silently pass instead of raising an exception --> this thing will automatically evaluate to nil for NullPieces and just skip over it I believe
            @grid[s_row][s_col], @grid[e_row][e_col] = NullPiece.instance, piece
            piece.pos = end_pos # reassign this thing entirely to a new pointer so that when you dup the board in Piece#valid_moves it doesn't totally fuck you up lmfao dying
        end # don't need the elsif "!piece.valid_moves.include?(end_pos)" as it should never be triggered because you're only iterating over positions that are *in* piece.moves lol in #valid_moves which is the only method that calls this method
    end

    def dup # whew think this finally works great lol
        new_board = Board.new
        new_board.grid.map!.with_index do |row, row_i| # mutate the old array to be all these returns
            row.map.with_index do |col, col_i| # don't need to mutate this one since it'll be mutated above with the return from this anyway
                old_piece = @grid[row_i][col_i]
                if old_piece.is_a?(NullPiece) # if it's a NullPiece just return it as is otherwise create the new one
                    new_piece = old_piece # same as calling NullPiece.instance again, just another NullPiece
                else
                    new_piece = old_piece.clone # not 100% sure on all the differences between clone and dup yet but clone is totally fine, dup should be too though
                    new_piece.board = new_board # note that you could want to do new_piece.pos = old_piece.pos.dup as well to be safe which would protect you from the stupid move_piece! move where you did piece.pos[0], piece.pos[1] = e_row, e_col instead of piece.pos = end_pos lmao but doing that above should be fine too we'll see, anyway just the most hilarious thing that you fucking did that but super lucky that you actually understand pointers quite well and can sort through this well. Super lucky with that for sure.
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

    # omfg briefly tested and it WORKS LOL modular coding holy fuck and method decomposition actually works learn how to make modular methods way better but my god this is incredible
    def in_check?(color)
        king_pos = [] # may not need this if the variable assignment can just happen for the first time in the line below check it later
        @grid.each { |row| row.each { |piece| (king_pos = piece.pos) if (piece.is_a?(King) && piece.color == color) } } # I think eaches work like this we'll see lol a nested each may not, yeah it doesn't fix it for now and do it later. This is poor code writing figure out a better way
        @grid.any? { |row| row.any? { |piece| (piece.moves.include?(king_pos)) && (piece.color != color) } } # return the result of this double nested any of which the innermost returns any value other than false or nil - note that, it doesn't only return true if any value inside returns true, just if it returns anything besides false or nil, interesting. Interesting design and very important to read the documentation for everything in depth. And then if the innermost any? returns true then the outermost any? returns true then the whole method returns true, otherwise the whole thing returns false heh awesome. Very Ruby specific things. Will need to learn how to do these in other languages for sure though thankfully most things are the same.
    end
    
    def checkmate?(color) # write an enumerator that checks if any of :color player's pieces have any #valid_moves, if not then in check, like something like this
        !@grid.any? { |row| row.any? { |piece| !piece.valid_moves.empty? && (piece.color == color) } } # basically check if any move of the same color as the color being checked for checkmate has any valid moves, aka moves that after moving don't leave the king in check - if not, then the game is over awesome heh # then the ! changes the return boolean value so hopefully this works if #valid_moves works as you think it might lol and it's specific to some check function thing --> I guess maybe valid_moves might change with a conditional if check is activated to only see positions that can protect the king that would be interesting
    end

    def castle(piece, start_pos, end_pos) # ugh fucking amazing that you have the #in_check? method and that was already created method decomposition for modularity in reusing code for everything is the greatest thing ever man
        raise ArgumentError.new("You cannot castle out of check. Try again.") if in_check?(piece.color)
        castle_side = piece.castle_pos.index(end_pos) # find which position you're castling to to know which pieces to change
        raise ArgumentError.new("You cannot castle through an attacked position. Try again.") if piece.move_into_check?(piece.rook_end_pos[castle_side]) # the rook's end position is the position that the King skips to move into its final position - if moving into this position would leave the King in check, the move isn't valid. Having modularized methods are so insanely great for checking all of this man so incredible you'd already written this non-insignificantly complex method and it was already decomposed into such a wonderfully repurposable helper method method decomposition and helper methods really are the greatest things ever you never know when you'll want to reuse one of them for something else and it's a breeze when your code is factored correctly incredible
        s_row, s_col = start_pos
        e_row, e_col = end_pos # alternatively piece.castle_pos[castle_side]
        r_s_row, r_s_col = piece.rook_start_pos[castle_side]
        r_e_row, r_e_col = piece.rook_end_pos[castle_side]
        rook = @grid[r_s_row][r_s_col]
        @grid[s_row][s_col], @grid[e_row][e_col] = NullPiece.instance, piece # swapping the king and the 
        @grid[r_s_row][r_s_col], @grid[r_e_row][r_e_col] = NullPiece.instance, rook
        piece.pos = end_pos
        rook.pos = piece.rook_end_pos[castle_side] # update the piece positions accordingly
    end

    def pawn_promote(piece, start_pos, end_pos)
        s_row, s_col = start_pos
        e_row, e_col = end_pos
        puts "Congratulations! Which piece would you like to promote to?\nQ for Queen, R for Rook, B for Bishop, and N for Knight."
        input = gets.chomp.downcase
        case input # fucking perfect love it really learning this stuff well in application so great and you absolutely can figure out all the features and functionality yourself now so amazing really am learning a lot
        when "q"
            @grid[s_row][s_col], @grid[e_row][e_col] = NullPiece.instance, Queen.new(piece.color, self, end_pos) # make the color the same as the color of the current pawn, pass the board, and pass the current position
        when "r"
            @grid[s_row][s_col], @grid[e_row][e_col] = NullPiece.instance, Rook.new(piece.color, self, end_pos)
        when "b"
            @grid[s_row][s_col], @grid[e_row][e_col] = NullPiece.instance, Bishop.new(piece.color, self, end_pos)
        when "n"
            @grid[s_row][s_col], @grid[e_row][e_col] = NullPiece.instance, Knight.new(piece.color, self, end_pos)
        else
            raise ArgumentError.new("That was not a valid promotion piece. Please try again.")
        end
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