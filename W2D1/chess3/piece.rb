require 'singleton' # right need to require it nice

# things to do for castling to work -->
# Put the move in moves for kings if they haven't moved before *and* everything is empty space between them and the rook on either side that they're moving to
# then when the move is performed in board make sure that the Rook on the side they're moving to also hasn't moved before
# make sure that they can't do the move if they are currently in check too

# for en passant
# Fucking love it you’re actually going to get castling to work and then it’s just en passant but that can definitely be saved for later since that’s a deterrent move anyway and not a real move and so people wouldn’t do it if they didn’t know you didn’t have that functionality and thought pieces could actually move like that lol and you can always put it in later it’s not *the* hardest thing to implement actually eh you might as well do it just need a method to know when a piece is performing a double jump and flag something so that on the next turn after a double jump any pawn that can capture that piece can do an en passant once that one turn flag is on love it

module Slidable # see if you need an getter method to read the current position and all that
    # @@HORIZONTAL_DIRS = Array.new # wtf are these supposed to be lol --> ooh that's smart the way they had you do it would be just saving an array of offsets duh then putting those in lmao oh well too late for that now, should have realized that lol, but still weird this seems like it would be a little harder, it would be like 4 different directions, wow she's doing so well with the popup so proud and happy for her so great aww
    # @@DIAGONAL_DIRS = Array.new
    def moves # directions being an array of symbols :diagonal and/or :straight --> should return an array of places that the piece can move to
        directions = self.move_dirs
        row, col = @pos # get the row and col to see which ways the thing can move
        possible_moves = Array.new
        possible_moves += straight_slide(row, col) if directions.include?(:straight)
        possible_moves += diagonal_slide(row, col) if directions.include?(:diagonal)
        possible_moves
    end
end

# fuck yes you're awesome this should work perfectly we'll see :) god love your life heh
def diagonal_slide(row, col) # oh cool try the .downto here instead of the reverse always nice to try new things even though it doesn't make for the most sensical code as per https://stackoverflow.com/questions/2070574/is-there-a-reason-that-we-cannot-iterate-on-reverse-range-in-ruby love it the last time you did reverse just because you didn't think about it until later now knowing this you can do it this way love it ah nevermind no need but would have been great to write smaller.downto(0).map oh well lol remember that for some other time love Ruby what a great language
    (row <= col) ? (smaller, larger = row, col) : (smaller, larger = col, row) # establish which number is the smaller of the two and the larger love it you have some crazy short code lol. For the nw and se diagonals
    nw = check_blocking_pieces((1..smaller).map { |offset| [row-offset, col-offset] }) # go by smaller because that's which one will hit 0 first
    ne = check_blocking_pieces((1..(7-row)).map { |offset| [row+offset, col-offset] if ((col-offset) >= 0) }.compact) # Need to use .compact to remove all the nil elements that were returned by .map since can't quite use select or reject since you *do* want to return the evaluation of the array but ah well code smells http://ruby-doc.org/core-1.9.3/Array.html#method-i-compact if you don't get rid of these nils then in the check_blocking_pieces() you'll run into an error since it'll be trying to get an index of a nil value in moves lol amaizng that even the most misleading errors you can debug with debugger and a good eye fuck byebug is so powerful # go by larger but check that the thing doesn't go out of bounds, the only bounds that it could go out if you have the row correct is col-offset being less than 0 # ahh these return nil for everything it doesn't return for so that's the error love it great catch # don't know what you would do without byebug it's literally god mode
    sw = check_blocking_pieces((1..(7-col)).map { |offset| [row-offset, col+offset] if ((row-offset) >= 0) }.compact) # go up until col == 7 as long as row is above or equal to 0, could do it the other way too, as long as col <= 7 go until row hits 0, but same thing
    se = check_blocking_pieces((1..(7-larger)).map { |offset| [row+offset, col+offset] }) # increase up until the largest one equals 7 basically there might be some nil issues with this but this should work can't wait to check it if you add them all up and there are some nils they might not add let's see, ah nope thankfully map returns an empty array fucking love it Ruby is the best
    (nw + ne + sw + se)
end

def straight_slide(row, col)
    up = check_blocking_pieces((0...row).map { |new_r| [new_r, col] }.reverse) # reverse this to traverse out from the piece's current location now and use the check_blocking_pieces thing to see if there are any blocking pieces in the way incredible
    down = check_blocking_pieces((row+1..7).map { |new_r| [new_r, col] })
    left = check_blocking_pieces((0...col).map { |new_c| [row, new_c] }.reverse) # you'll want to reverse this to traverse out from the piece itself hah omg this works perfectly lmao
    right = check_blocking_pieces((col+1..7).map { |new_c| [row, new_c] })
    (up + down + left + right) # return all the arrays together love it
end

# so great to have this helper method DRY is the best thing ever fucking love it
def check_blocking_pieces(positions) # works fucking brilliantly love it and testing in pry is so fucking great fucking love your workflow
    positions.each_with_index do |move, index| # omg this is using each perfectly, because if it doesn't return inside this helper method it'll just return what was passed to it as is that's what .each is good for - either doing some random action for each enumeration or even more ideally just returning a different value if something inside is different or returning the whole thing if not fucking incredible
        piece = @board.grid[move[0]][move[1]]
        if !piece.is_a?(NullPiece) # only get the moves before the first blocking piece is found, immediately return once/if a non NullPiece is found in the path # if the current position is not a null piece, then return this with a truncated version of the array
            piece.color == self.color ? (return positions.slice(0...index)) : (return positions.slice(0..index)) # check if the piece is of the same color or not - if it is of the same color, then don't include it in possible moves, if not of the same color, include it in the possible moves since you can capture it. Normally you use @color vs self.color but in this case it does seem to be more readable and make more sense to run self.color since you already have an attr_getter for it why not. And perfect use case for a protected method if you didn't need the color anywhere else let's see :) you might not let's do it just because protected methods are so cool # GOD THIS SHIT WORKS SO FUCKING GOOD AHHHHHHH
        end
    end
end

module Stepable
    def moves
        offsets = move_diffs # right instead of using compact you should just do a select on the output of the map that's the better way to do it. Good to learn .compact though even though it's a hilarious code smell lol your diagonal_slide and straight_slide are the most complex examples of code smells for sure if you've ever seen any lol so many chains - chains are code smells
        raw_move_pos = offsets.map { |offset| [offset, @pos].transpose.map(&:sum) } # oh god your hilarious code smells lmao. This fucking transposes [offset] and [@pos] so that the offset and the row and the column are aligned, then it fucking returns the sum of each of those two transpositions as the new position for each offset passed in that's then returned as the new array of raw moves that are the position + the offset for each position, which are all the positions not sanitized to see if they're within bounds which is what the select will do heh
        valid_pos = raw_move_pos.select do |p| # this will just return to def moves all the positions that are valid in that they are not negative positions off the map and in that they do not hit a piece that is of its own color
            if (p[0] >= 0) && (p[0] <= 7) && (p[1] >= 0) && (p[1] <= 7) # right should be <= 7 heh made that mistake wow so many things to watch out for in this code pretty nuts for sure
                piece = @board.grid[p[0]][p[1]]
                true if piece.is_a?(NullPiece) || piece.color != self.color # if the position is valid *and* there is either no piece at the current position or the piece at the current position is of the opposite color, then return true, else return false fucking love it
            end # awesome no explicit false needed this if will just return the piece or nil if the position is out of bounds and so the select doesn't select it love it only selects true explicitly love it
        end
        if self.is_a?(King) && !self.moved # check for potential castling moves if self is a king and hasn't moved. Remember to check in board if the king is in check and raise an exception if so to say you can't castle out of check.
            queen_offsets = [[0, -1], [0, -2], [0, -3], [0, -4]] # check that the first positions [0...-1] are all empty and then check that [-1], the rook, is first a rook and hasn't moved
            king_offsets = [[0, 1], [0, 2], [0, 3]]
            valid_pos << @castle_pos[0] if check_offsets(queen_offsets) # add the queen castle position (the first in the @castle_pos index repertoire, alteratively can do [@pos[0], @pos[1]-2] which would reference the same thing) into valid moves if this is a valid move
            valid_pos << @castle_pos[1] if check_offsets(king_offsets) # add the king castle position into valid moves if this is a valid move
        end
        valid_pos
    end

    def check_offsets(offsets)
        offset_pos = offsets.map { |offset| [offset, @pos].transpose.map(&:sum) } # your working memory allows you to just grasp and comprehend more complex things so you don't have to simplify them more and can still understand them well which is fortunate just make sure this holds true over time and you still understand this code much later not when it's just fresh in your memory
        offsets_empty = offset_pos[0...-1].all? { |position| (row, col = position); @board.grid[row][col].is_a?(NullPiece) } # check that every piece between the king and the rook is empty
        rook_row, rook_col = offset_pos[-1] # get the row and column of the rook which is the last offset_pos
        maybe_rook = @board.grid[rook_row][rook_col]
        offsets_empty && maybe_rook.is_a?(Rook) && !maybe_rook.moved # return true only if all the pieces in between the king and the rook are empty and the rook is intact and hasn't moved fucking love it
    end

end

class Piece
    attr_reader :color
    attr_accessor :board, :pos

    def initialize(color, board, pos)
        @color = color
        @board = board
        @pos = pos
    end

    def to_s; @symbol.to_s end # hmm I wonder if you can colorize symbols we'll find out I guess lol othwerise just convert it to a string wow this diagram thing is super helpful actually lmao not that much to write at all fucking love it

    def valid_moves # do this method with the board#dup and all that and check if in check. Hah, it is indeed very straightforward lol
        all_moves = moves
        all_moves.reject { |move| move_into_check?(move) } # damn code is easy to write when it's good this should just check if a move leaves you in check and if so reject all the moves for which this is true
    end

    def move_into_check?(end_pos) # wow that was easy just actually do the thing and it's not that bad lol when you're properly motivated love life
        dup_board = @board.dup # duplicate the board so you don't't fuck up the current board state by actually performing the move
        dup_board.move_piece!(@pos, end_pos)
        dup_board.in_check?(@color)
    end

end

# oh fuck you forgot it gets the double jump at the beginning if it's on the start row! Heh amazing lmao pawns are the coolest so much exceptionary behavior to build in crazyt hat they expect people to do this stuff really does take a normal person 18 hours lmao amazing so happy doing this work so fun --> seek to understand the UML for sure so many working pieces to throw together love it
class Pawn < Piece # ah an interesting piece to move! goes down if black, goes up if white. Also can only attack sideways. No sense implementing all this for now since need to understand the battle mechanism first so let's go there first to see. Just checks for now
    attr_accessor :moved
    
    def initialize(color, board, pos); super; @symbol = :♙; @moved = false end

    def moves # moving forward if not blocked by a piece, moving to each side if can capture a piece. Wow this is actually complicated enough to require all the helper methods amazing lol
        possible_moves = Array.new
        new_row = @pos[0] + forward_dir # the new forward move direction. Oh just make your code clear for god's sake lmao
        if new_row >= 0 && new_row <= 7 # if the new row is within bounds do the rest otherwise if it's not in bounds just skip it all
            f_steps, s_attacks = forward_steps(new_row), side_attacks(new_row)
            possible_moves += f_steps if !f_steps.empty? # if not empty, add it in. So much inefficiency in this code but I guess it is clear man
            possible_moves += s_attacks if !s_attacks.empty? # add whatever is returned by either of these as all the possible moves ahh now these helper methods make way more sense nice
            possible_moves
        else # else if the new row is not in bounds return an empty array
            []
        end
    end

    private
    def forward_dir
        (self.color == :white) ? -1 : 1 # if the thing moves up or down --> if it's white, it moves up, so -1, if it's black, it moves down, so +1 heh got this backwards great testing lmao
    end

    def at_start_row?
        (self.color == :white) ? (start_row = 6) : (start_row = 1) # if it's white, the start row is 6, else it's 1
        @pos[0] == start_row # if the row of the piece is at the start row then it is indeed at the start row otherwise it's not
    end

    # NB - the shovel operator is correct here to create nested arrays which is what you want to add them together above love it
    def forward_steps(new_row) # ahhh all the logic to see if this should be added or not should be in here awesome, yeah helper methods *are* supposed to be like this right to better help modularize things nice
        f_steps = Array.new
        one_step = [new_row, @pos[1]] 
        two_step_row = new_row + forward_dir # if it can jump you've gotta increment this by another step lol can't believe you forgot this about pawns wow
        if (two_step_row >= 0) && (two_step_row <= 7) # ah lmfao didn't fucking check if it's a NullPiece there or not LOL amazing bug catching god debugger is god mode
            (f_steps << [two_step_row, @pos[1]]) if (at_start_row? && @board.grid[two_step_row][@pos[1]].is_a?(NullPiece) && @board.grid[new_row][@pos[1]].is_a?(NullPiece)) # if the pawn is at the start step then add this new step if it's valid otherwise don't note can't do self.at_start_row? because this is invalid. # also added another check here wow so many things to watch out for you can't double step past a square that's occupied by another piece so have to check that the one step piece is also a NullPiece amazing catch man so much to catch lol
        end
        f_steps << one_step if @board.grid[new_row][@pos[1]].is_a?(NullPiece) # only allow this move if the new row is in bounds and there is no piece in that position
        f_steps
    end

    def side_attacks(new_row) # god the rescue...debugger...end block is so brilliant lmao and helps you catch bugs in literal seconds lmao sooo fucking good
        s_attacks = Array.new
        left = [new_row, (@pos[1]-1)] if ((@pos[1]-1 >= 0) && (@pos[1]-1 <= 7)) # the left side attack
        right = [new_row, (@pos[1]+1)] if ((@pos[1]+1 >= 0) && (@pos[1]+1 <= 7)) # the right side attack, damn you love parentheses to keep things clear lol
        (en_passant_pawn = @board.grid[@board.en_passant[0][0]][@board.en_passant[0][1]]) if !@board.en_passant.empty? # if there is an en_passant piece, set it as a shortcut so you don't have to do crazy long writing to get the piece later
        if left # if this exists and isn't nil, it will be if the thing above didn't execute, must be more elegant code but whatever this works you have been converted to the straightforward non-elegant code side for now hmm
            l_piece = @board.grid[left[0]][left[1]]
            (s_attacks << left) if (!l_piece.is_a?(NullPiece) && (l_piece.color != self.color)) || ((@board.en_passant[1] == left) && (en_passant_pawn.color != self.color)) # this is a valid move if the piece exists and is of the opposite color *OR* if the en_passant flag has been triggered and the en_passant capture position equals the left capture position here fucking love it # good to have parentheses for this purpose for sure
        end
        if right # could factor this out too but fuck it who cares lol
            r_piece = @board.grid[right[0]][right[1]]
            (s_attacks << right) if (!r_piece.is_a?(NullPiece) && (r_piece.color != self.color)) || ((@board.en_passant[1] == right) && (en_passant_pawn.color != self.color)) # note that this is safer than @board.en_passant.include?(right) because that would potentially get the position where the Pawn is right now instead of where the capture position should be, and while that *should* be fine anyway as long as you're checking colors are opposing so you don't accidentally allow a piece of the same color to capture one of its own pawns that just moved two steps by accident love it great catch
        end
        s_attacks
    end
end

class King < Piece
    include Stepable

    attr_accessor :moved
    attr_reader :castle_pos, :rook_start_pos, :rook_end_pos

    def initialize(color, board, pos)
        super
        @symbol = :♚
        @moved = false
        if color == :white
            @castle_pos = [[7, 2], [7, 6]] # hardcode the two castle positions to easily check later awesome
            @rook_start_pos = [[7, 0], [7,7]] # this is just laziness definitely an easier way to factor this out lol or just hardcode it on the spot
            @rook_end_pos = [[7, 3], [7, 5]]
        else
            @castle_pos = [[0, 2], [0, 6]]
            @rook_start_pos = [[0, 0], [0, 7]]
            @rook_end_pos = [[0, 3], [0, 5]]
        end
    end

    def move_diffs
        [[-1, -1], [0, -1], [1, -1], [1, 0], [1, 1], [0, 1], [-1, 1], [-1, 0]] # in clockwise order from top left, all the offsets of where the piece can move way easier than these sliding pieces man lmao trivial so lucky to be getting through this stuff love doing the hard stuff first in the morning when it was hard. Can't wait to have this great dinner with Mai tonight and look all nice for it and all that :)
    end

end

class Queen < Piece
    include Slidable

    def initialize(color, board, pos); super; @symbol = :♛ end
    def move_dirs; [:straight, :diagonal] end # for the Slidable module --> I feel like these should be attribute variables hmm they say to do it like this I guess we'll see if there's a reason for it...
end

class Rook < Piece
    include Slidable

    attr_accessor :moved

    def initialize(color, board, pos); super; @symbol = :♜; @moved = false end

    def move_dirs; [:straight] end
end

class Bishop < Piece
    include Slidable

    def initialize(color, board, pos); super; @symbol = :♝ end

    def move_dirs; [:diagonal] end
end

class Knight < Piece
    include Stepable

    def initialize(color, board, pos); super; @symbol = :♞ end
    def move_diffs
        [[-2, -1], [-1, -2], [1, -2], [2, -1], [2, 1], [1, 2], [-1, 2], [-2, 1]] # omfg exactly perfect character count what a miracle
    end
end

class NullPiece < Piece # hmm Singleton interesting look into that later you'll need to take out these to_s's sigh
    include Singleton

    def initialize; @color = :none; @symbol = :" " end # they say make sure to read your color here but can't see how this could have a color since there's only one NullPiece ever hmm # give it a fake dummy color so that the in_check(color) and checkmate?(color) methods work in enumerating everything; easier than accounting for it independently there, similar to the dummy #moves method, which seems like what the UML is suggesting you should have

    def moves; [] end # just return an empty array always
end