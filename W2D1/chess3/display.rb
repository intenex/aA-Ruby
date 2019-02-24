require 'paint' # rainbow was okay but man paint is glorious with true color support - need to run on iTerm2 though VSCode doesn't have true color support and strangely the pawn unicode doesn't work great on iTerm2 is some other hyperrealistic pawn will need to change it up lol weird the black pawn just doesn't work the white one does it's too hollow sadly but better than nothing guess it'll do for now
require_relative 'board'
require_relative 'cursor'

class Display
    attr_reader :board, :cursor # to get to call board methods hopefully lol like move_piece

    def initialize(board)
        @board = board
        @cursor = Cursor.new([0,0], @board) # they literally do tell you exactly what to do lol
    end

    # refactored the fuck out of this thing like a boss lol god refactoring is good
    def render
        @board.grid.each_with_index do |row, row_i|
            row.each_with_index do |col, col_i|
                if all_even?(row_i, col_i) || all_odd?(row_i, col_i) # this condition is for white # the two cases where the board is white is when either both row and col are even or both are odd, amazing, quite elegant
                    print_piece(col, row_i, col_i, piece_color(col), "#9AB3C9")
                else
                    print_piece(col, row_i, col_i, piece_color(col), "#4A7190") # this is for black lol the hex colors don't make it as clear anymore lol
                end
            end
            puts # make a new line after each row
        end
        nil # so it doesn't return the whole board just a placeholder while you play with this thing
    end

    # all the epic helper methods for the board rendering logic damn chess is a much more complex game than any game before lmfao
    def all_even?(row, col); (row % 2 == 0) && (col % 2 == 0) end # for printing background square colors
    def all_odd?(row, col); (row % 2 == 1) && (col % 2 == 1) end
    def cursor?(row, col); @cursor.cursor_pos == [row, col] end # check if the cursor is on the current position or not
    def prnt_cursor; @cursor.selected ? "#E56373" : "#FFD768" end # if selected, return one color, else return the other, this actually is better code all this refactoring is great lmao
    def piece_color(piece); ((piece.color == :white) ? "#FFEED5" : "#063848") end # basically the colorizer method in piece before but now have to do it all here since Rainbow works differently from colorizer and can't chain like that. This chooses which color to show for white and black respectively
    def print_piece(piece, row_i, col_i, p_color, bg_color)
        if cursor?(row_i, col_i) # fuck yes let's refactor this even better, this changes the print color if the current position is the cursor position and two more choices on whether or not the cursor is selected which is exactly as the code should be fucking love it such good refactoring lol
            p_color = prnt_cursor
            if piece.is_a?(NullPiece) # if the cursor is currently over a NullPiece, if the cursor is selected, display the piece currently selected, otherwise display just a really fucking cool Khmer Unicode circle lol https://en.wikipedia.org/wiki/Khmer_(Unicode_block)
                @cursor.selected ? (piece = @board.grid[@cursor.start_pos[0]][@cursor.start_pos[1]]) : (piece = :៙)
            end
        end
        print Paint["#{piece.to_s} ", p_color, bg_color] # boom a single print line this is correctly factored code fucking amazing
    end

end