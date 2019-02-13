require_relative './tile.rb'

class Board
    attr_reader :grid

    def initialize(grid)
        @grid = grid
    end

    # .foreach vs .open doesn't slurp/read the whole file at once, just takes it one line at a time, so way more effective and prevents against crashes/slowdowns from loading enormously large files, just a good practice
    def self.from_file(file) # this is a method hopefully it works as such --> should read a file and parse it into a two dimensional Array containing Tile instances
        tiled_board = Array.new(9) { Array.new(9) } # create the board to fill with Tile instances 9x9
        row = 0
        File.foreach(file) do |line| # file being the path of the file --> omfg it works
            numbers = line.chomp.split('')
            numbers.each_with_index do |num, col| # the index is equal to the column to put into the tiled board
                tiled_board[row][col] = Tile.new(num.to_i, num.to_i != 0) # so lucky to test small and catch the .to_i method needed here love testing small so great so good to have learned that # if num != 0, then the second argument will return true and mean that the given attribute of the Tile instance will be set to true, as it was a given number, otherwise set it to false, love it programming is so great and you really are figuring out these things well you really do have a knack for this stuff mainly because knack == how much you're interested in something and you just happen to be really interested in this stuff figure out what makes a person this way and then figure out how to raise kids like this etc, so lucky to be like this
            end
            row += 1 # increment the row at the end of each line to move on to the next subarray
        end
        tiled_board
    end

    def [](pos)
        row, column = pos
        @grid[row][column].to_s # display the tile value of the given position
    end

    # amazing works flawlessly everything really is coming along so smoothly now so crazy you really do understand what you're doing nuts
    def []=(pos, value)
        row, column = pos
        @grid[row][column].value = value # don't need to check if given bc that's checked in the value= method itself in the Tile class
    end

    def render # well that was easy getting way better at these love it just keep pushing forward as fast as possible some will be faster than others to complete for sure
        @grid.each do |row|
            row.each do |tile|
                print "#{tile.to_s} " # print each tile love it the to_s method should handle this really smart that's what the .to_s in ghost should have done makes sense now
            end
            puts # start a new line to print the next tiles
        end # testing small is amazing so lucky to be able to do that with pry so great

    end

    def solved? # several helper methods here holy fuck so much stuff to do no chance you'll be able to keep up
        return false if !row_solved?
        return false if !column_solved?
        starting_indexes = [0, 3, 6] # create all the starting indexes to check in the square solver, need to check 9 of these
        starting_indexes.each { |row| starting_indexes.each { |col| return false if !square_solved?(row, col) } } # if any of the squares return false, return false --> this iterates through [0, 0], then [0, 3], then [0, 6], then [3, 0], [3, 3], [3, 6], then [6, 0], [6, 3], [6, 6] amazing love it
        true # if nothing has returned false, return true
    end

    def row_solved? # checks if every row has been solved
        @grid.each do |row|
            counter_hash = Hash.new(0) # count the occurrences of each value
            row.each do |tile| # iterate over every row and count the numbers per each row
                counter_hash[tile.value] += 1
            end
            tile_values = counter_hash.values # get all the counts from the counter_hash
            return false if tile_values.length != 9 # return false if there aren't at least 9 unique digits, i.e 1 2 3 4 5 6 7 8 9
            return false if tile_values.any? { |num| num != 1 }  # return false if any number doesn't equal 1 - the entire array should just be 9 elements with a value of 1 counting each unique number
            return false if counter_hash.keys.any? { |key| key <= 0 || key > 9 } # could add another return false to make sure the values are between 1 and 9 with a return false if but shouldn't be necessary since this should be validated elsewhere --> actually throw this in there bc if there are any zeros the game will resolve to solved and they start as zero so important to take that into account
        end
        true # return true if never any false returns
    end

    # wow I think these both work flawlessly on your first shot kind of nuts very lucky
    def column_solved? # checks if every column has been solved
        (0...9).each do |col| # alternatively you could use the index from @grid.each_index and just use the indexes backwards in the search of the @grid hash, but that's probably more hacky and confusing
            counter_hash = Hash.new(0)
            (0...9).each do |row|
                counter_hash[@grid[row][col].value] += 1 # hopefully this code works as intended, which is to get the exact Tile instance stored in the 2D array @grid and pull its value and then increment by 1, doing the same thing as the code in the row_solved? method ### Update amazingly it does work as expected
            end
            tile_values = counter_hash.values
            return false if tile_values.length != 9
            return false if tile_values.any? { |num| num != 1 }
            return false if counter_hash.keys.any? { |key| key <= 0 || key > 9 }
        end
        true
    end

    # can't believe this all works as expected amazing
    def square_solved?(start_row, start_col) # checks if every 3x3 square has been solved, start should be the start index of the square and end the end index, like 0, 2 for the first square
        counter_hash = Hash.new(0) # this only checks 9 squares in a go not 81 so must have this outside the whole thing
        (start_row..(start_row + 2)).each do |row| # don't name a variable end lmao that's a special word keyword fucks shit up
            (start_col..(start_col + 2)).each do |col|
                counter_hash[@grid[row][col].value] += 1 # e.g. start..end of 0, 2, this checks [0][0], [0][1], etc, then [1][0], etc.
            end
        end
        tile_values = counter_hash.values
        return false if tile_values.length != 9
        return false if tile_values.any? { |num| num != 1 }
        return false if counter_hash.keys.any? { |key| key <= 0 || key > 9 } # so lucky you wrote this just in case anyway and turns out it is needed after all love it love coding and making good code and wow this stuff really does just take time
        true
    end

end