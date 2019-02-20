require 'colorize'
require_relative 'board'
require_relative 'cursor'

class Display
    def initialize
        @board = Board.new
        @cursor = Cursor.new([0,0], @board) # they literally do tell you exactly what to do lol
    end

    def inspect # just silence it for now lol
    end

    def render
        @board.grid.each_with_index do |row, row_i|
            row.each_with_index do |col, col_i|
                if @cursor.cursor_pos == [row_i, col_i]
                    @cursor.selected ? (print "#{col.to_s} ".colorize(:green)) : (print "#{col.to_s} ".colorize(:yellow)) # if the cursor position is here, overwrite the normal coloring with the cursor coloring. If a piece is selected, then toggle the selected piece color (green is selected, yellow is just a normal cursor)
                else
                    print "#{col.to_s} "  # this gets the piece in question and prints out what it should be # print is the one that doesn't put in new lines, puts does nice
                end
            end
            puts # make a new line after each row
        end
        nil # so it doesn't return the whole board just a placeholder while you play with this thing
    end

    def make_move # to be later refactored out into the Player class awesome
        while true # never end this loop; obviously fix it to while !game_over? later lol man y'all really are learning how to make all the terminal games lmao
            system('clear')
            self.render
            @cursor.get_input
        end
    end
end