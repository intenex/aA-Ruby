require 'colorize'
require 'singleton' # right need to require it nice
require 'byebug'

# wow think the moving things are working flawlessly so nuts lol

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
    def moves # not yet tested confirm this works later
        offsets = move_diffs # right instead of using compact you should just do a select on the output of the map that's the better way to do it. Good to learn .compact though even though it's a hilarious code smell lol your diagonal_slide and straight_slide are the most complex examples of code smells for sure if you've ever seen any lol so many chains - chains are code smells
        raw_move_pos = offsets.map { |offset| [offset, @pos].transpose.map(&:sum) } # oh god your hilarious code smells lmao. This fucking transposes [offset] and [@pos] so that the offset and the row and the column are aligned, then it fucking returns the sum of each of those two transpositions as the new position for each offset passed in that's then returned as the new array of raw moves that are the position + the offset for each position, which are all the positions not sanitized to see if they're within bounds which is what the select will do heh
        raw_move_pos.select do |p| # this will just return to def moves all the positions that are valid in that they are not negative positions off the map and in that they do not hit a piece that is of its own color
            if (p[0] >= 0) && (p[0] < 7) && (p[1] >= 0) && (p[1] < 7)
                piece = @board.grid[p[0]][p[1]]
                true if piece.is_a?(NullPiece) || piece.color != self.color # if the position is valid *and* there is either no piece at the current position or the piece at the current position is of the opposite color, then return true, else return false fucking love it
            end # awesome no explicit false needed this if will just return the piece or nil if the position is out of bounds and so the select doesn't select it love it only selects true explicitly love it
        end
    end
end

class Piece
    def initialize(color, board, pos)
        @color = color
        @board = board
        @pos = pos
    end

    def to_s; colorizer(@symbol) end # hmm I wonder if you can colorize symbols we'll find out I guess lol othwerise just convert it to a string wow this diagram thing is super helpful actually lmao not that much to write at all fucking love it

    protected
    attr_reader :color

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
    include Stepable

    def initialize(color, board, pos); super; @symbol = :K end
    def move_diffs
        [[-1, -1], [0, -1], [1, -1], [1, 0], [1, 1], [0, 1], [-1, 1], [-1, 0]] # in clockwise order from top left, all the offsets of where the piece can move way easier than these sliding pieces man lmao trivial so lucky to be getting through this stuff love doing the hard stuff first in the morning when it was hard. Can't wait to have this great dinner with Mai tonight and look all nice for it and all that :)
    end
end

class Queen < Piece
    include Slidable

    def initialize(color, board, pos); super; @symbol = :Q end
    def move_dirs; [:straight, :diagonal] end # for the Slidable module --> I feel like these should be attribute variables hmm they say to do it like this I guess we'll see if there's a reason for it...
end

class Rook < Piece
    include Slidable

    def initialize(color, board, pos); super; @symbol = :R end

    def move_dirs; [:straight] end
end

class Bishop < Piece
    include Slidable

    def initialize(color, board, pos); super; @symbol = :B end

    def move_dirs; [:diagonal] end
end

class Knight < Piece
    include Stepable

    def initialize(color, board, pos); super; @symbol = :N end
    def move_diffs
        [[-2, -1], [-1, -2], [1, -2], [2, -1], [2, 1], [1, 2], [-1, 2], [-2, 1]] # omfg exactly perfect character count what a miracle
    end
end

class NullPiece < Piece # hmm Singleton interesting look into that later you'll need to take out these to_s's sigh
    include Singleton

    def initialize; @symbol = :- end # they say make sure to read your color here but can't see how this could have a color since there's only one NullPiece ever hmm

    def moves
    end
end