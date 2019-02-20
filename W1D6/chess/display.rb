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
        @board.grid.each do |row|
            row.each do |col|
                print "#{col.to_s} " # this gets the piece in question and prints out what it should be # print is the one that doesn't put in new lines, puts does nice
            end
            puts
        end
        nil # so it doesn't return the whole board just a placeholder while you play with this thing
    end

    def make_move # to be later refactored out into the Player class awesome

    end
end