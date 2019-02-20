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
                (@cursor.cursor_pos == [row_i, col_i]) ? (print "#{col.to_s} ".colorize(:green)) : (print "#{col.to_s} ") # if the cursor position is here, overwrite the normal coloring with the cursor coloring not sure if this is the best way to do it but this should at least work. Boom works so great. So easy for you to figure out all the basics of what to do now love it now it's just about becoming a better and better coder as we go # this gets the piece in question and prints out what it should be # print is the one that doesn't put in new lines, puts does nice
            end
            puts
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