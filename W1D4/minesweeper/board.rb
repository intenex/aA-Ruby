require_relative './tile.rb'
require "byebug"

class Board

    attr_reader :grid # so that the tile class can access this - internal instance methods can access attributes of that class natively, but other class instance methods can't, right, of course that's how it works remember that

    def initialize # damn learning that you can chain multi lines of code onto one line with semicolons is so lit lol
        @grid = populate_grid; set_tile_values # things to run as soon as the board is set up shouldn't have to automatically do it right love it know where to put everything awesome
    end

    def populate_grid
        grid_arr = Array.new(9) { Array.new(9) }
        grid_arr.each_with_index { |row, row_i| row.each_index { |col_i| grid_arr[row_i][col_i] = Tile.new(self, [row_i, col_i], (rand < 0.1)) } } # could possibly just set col = the Tile but check that later. Nope, confirmed this doesn't work, awesome, your intuitions are right, don't know what Theo was testing | # rand with no argument returns a random crazy floating point between 0 and 1 so under .1 is 10% of hte time, awesome. Random number generation is such an incredible thing to be able to create pseudorandomness || rand(10) % 10 should give a 10% chance of equaling 0 and the == 0 returns a boolean, so good shorthand for random probabilities, that's nice, so you get 10%. Okay nevermind just read the better way to do this lol so your original code (rand(10)%10 == 0), while totally functional, is now deprecated for being slightly less efficient and elegant.
        grid_arr
    end

    def set_tile_values
        @grid.each { |row| row.each { |tile| tile.value = tile.neighbor_bomb_count(tile.pos) } } # set the values of each tile to how many neighbors it has now that the whole grid has been correctly created
    end

    def render
        @grid.each { |row| row.each { |tile| print "#{tile.to_s} " }; puts } # puts at the end to create a new line. Interesitng that the semi colon does work in ruby to put multiple lines of code on one line, interesting, just guessed it as the logical thing and it does indeed work https://stackoverflow.com/a/3953856/674794
    end

end