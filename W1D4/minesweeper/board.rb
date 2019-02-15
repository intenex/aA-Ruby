require_relative './tile.rb'
require "byebug"

class Board

    attr_reader :grid # so that the tile class can access this - internal instance methods can access attributes of that class natively, but other class instance methods can't, right, of course that's how it works remember that

    def initialize
        @grid = populate_grid
        set_tile_values # things to run as soon as the board is set up shouldn't have to automatically do it right love it know where to put everything awesome
    end

    def populate_grid
        grid_arr = Array.new(9) { Array.new(9) }
        grid_arr.each_with_index do |row, row_i|
            row.each_with_index do |col, col_i| # could possibly just set col = the Tile but check that later
                grid_arr[row_i][col_i] = Tile.new(self, [row_i, col_i], (rand < 0.1)) # rand with no argument returns a random crazy floating point between 0 and 1 so under .1 is 10% of hte time, awesome. Random number generation is such an incredible thing to be able to create pseudorandomness || rand(10) % 10 should give a 10% chance of equaling 0 and the == 0 returns a boolean, so good shorthand for random probabilities, that's nice, so you get 10%. Okay nevermind just read the better way to do this lol so your original code (rand(10)%10 == 0), while totally functional, is now deprecated for being slightly less efficient and elegant.
            end
        end
        grid_arr
    end

    def set_tile_values
        @grid.each { |subgrid| subgrid.each { |tile| tile.value = tile.neighbor_bomb_count(tile.pos) } } # set the values of each tile to how many neighbors it has now that the whole grid has been correctly created
    end

    def render
        @grid.each do |subgrid|
            subgrid.each do |tile|
                print "#{tile.to_s} " # boom works flawlessly love it
            end
            puts # to create a new line
        end
    end

end