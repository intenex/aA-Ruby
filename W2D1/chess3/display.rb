require 'rainbow' # fucking colorize is a shitty gem lmao try this one instead lol --> oh god you got it working and it's fucking glorious lol you can chain two .colors and the last one will override the one before that's nice at least
require_relative 'board'
require_relative 'cursor'

class Display
    attr_reader :board # to get to call board methods hopefully lol like move_piece

    def initialize
        @board = Board.new
        @cursor = Cursor.new([0,0], @board) # they literally do tell you exactly what to do lol
    end

    def inspect # just silence it for now lol
    end

    # refactored the fuck out of this thing like a boss lol god refactoring is good
    def render
        @board.grid.each_with_index do |row, row_i|
            row.each_with_index do |col, col_i|
                if all_even?(row_i, col_i) || all_odd?(row_i, col_i) # this condition is for white # the two cases where the board is white is when either both row and col are even or both are odd, amazing, quite elegant
                    print_piece(col, row_i, col_i, piece_color(col), "8b998b")
                else
                    print_piece(col, row_i, col_i, piece_color(col), "1e721e") # this is for black lol the hex colors don't make it as clear anymore lol
                end
            end
            puts # make a new line after each row
        end
        nil # so it doesn't return the whole board just a placeholder while you play with this thing
    end

    def all_even?(row, col); (row % 2 == 0) && (col % 2 == 0) end # for printing background square colors
    def all_odd?(row, col); (row % 2 == 1) && (col % 2 == 1) end
    def cursor?(row, col); @cursor.cursor_pos == [row, col] end # check if the cursor is on the current position or not
    def prnt_cursor(prnt_str); @cursor.selected ? (print Rainbow(prnt_str).color("41f449")) : (print Rainbow(prnt_str).color("f4ee41")) end
    def piece_color(piece); ((piece.color == :white) ? "5b351d" : "040721") end # basically the colorizer method in piece before but now have to do it all here since Rainbow works differently from colorizer and can't chain like that. This chooses which color to show for white and black respectively
    def print_piece(piece, row_i, col_i, p_color, bg_color)
        prnt_str = Rainbow("#{piece.to_s} ").color(p_color).bg(bg_color) # this gets the piece in question and prints out what it should be # print is the one that doesn't put in new lines, puts does nice # can chain colorizes or just do this (:color => :light_blue, :background => :red) as per https://www.rubydoc.info/github/fazibear/colorize amazing
        cursor?(row_i, col_i) ? prnt_cursor(prnt_str) : (print prnt_str) # finally figured it out heh refactoring is a good exercise for sure this calls a helper method cursor to see if the cursor is on this position and if so calls another helper method prnt_cursor to print it correctly in re: if it's selected or not love it
    end

    def make_move # to be later refactored out into the Player class awesome
        while true # never end this loop; obviously fix it to while !game_over? later lol man y'all really are learning how to make all the terminal games lmao
            system('clear')
            self.render
            @cursor.get_input
        end
    end
end