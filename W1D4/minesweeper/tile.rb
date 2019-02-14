class Tile

    attr_reader :bomb, :board, :pos # many not needed like @pos likely prune later don't make elegant in the very beginning be safe and redundant then clean up and protect what's not needed
    attr_accessor :revealed, :flagged, :value

    def initialize(board, pos, bomb) # true or false
        @board = board # right need to call the getter method of board's grid later, board being the object that was just passed in...but also can't do this at exactly the same time. Have to define it later after the board is fully populated, right.
        @bomb = bomb
        @revealed = false
        @flagged = false
        @pos = pos
        @value = nil # later call neighbor_bomb_count to change this value for everything
    end

    # def inspect learn how to make this work correctly lol
    #     puts "Bomb: #{@bomb}, Flagged: #{@flagged}, Revealed: #{@revealed}"
    # end

    def reveal
        @revealed = true
    end

    def neighbor_bomb_count(pos) # just to make it explicit and not rely on hard coded values again
        neighbor_tile_locations = neighbors(pos)
        count = 0
        neighbor_tile_locations.each do |loc|
            row, col = loc
            count += 1 if (@board.grid[row][col]).bomb # if this value is true --> note that it's actually the index of the @board.grid attribute that you're calling with @grid's getter method, since @board is actual the board object you passed in, since you couldn't pass in the grid while it was being formed, you needed to wait until every Tile was initialized first and then populate these values, it has to be a two step process. So you pass in the Board object first, wait for the grid to be instantiated with tiles completely first, then call the grid from within that object passed in (a pointer to it, at least) to see how many other tiles are around it and what values they have, awesome, love it.
        end
        count
    end

    # amazing bug that byebug helped you find, you had an accidental col-offset in neighbors that was creating a very occasional error when there was just like one tile that exceeded the bounds of the grid love it but thanks to a conditional debugger call you found it pretty much instantly, so amazing. Byebug is the greatest tool ever and knowing how to use it is so insanely powerful for sure no questions.

    # so basically you need to do 3 elements of (row-1) for all 3, then col-1, col, col+1
    # then two of row, then col-1, col, col+1
    # then three of row+1, then col-1, col, col+1
    # the opposite obviously also works but this is good
    # [0,0], [0,1], [0,2]
    # [1,0], [1,1], [1,2]
    # [2,0], [2,1], [2,2]

    def neighbors(pos) # ah this is the helper method to get the neighbors right love it
        row, col = pos
        neighbor_tiles = Array.new # find all 8 neighbors by doing each row sequentially and getting those positions. Do three enumerators to get the top row, the middle row, and the bottom row respectively
        (-1..1).each { |offset| neighbor_tiles << [(row-1), (col+offset)] if (row-1) >= 0 && (col+offset) >= 0 && (row-1) < 9 && (col+offset) < 9 } # make sure both are within bounds and not at an edge of the board, if it's within bounds, add that position to the neighbor_tiles array to return to be checked
        [-1,1].each { |offset| neighbor_tiles << [row, (col+offset)] if (col+offset) >= 0 && (col+offset) < 9 } # don't need a 0 here because 0 is just the current tile itself. For the enumerator's conditional check, don't just blindly copy and paste code, obviously row is fine because the current tile is in row, just check what isn't possibly fine
        (-1..1).each { |offset| neighbor_tiles << [(row+1), (col+offset)] if (row+1) >= 0 && (col+offset) >= 0 && (row+1) < 9 && (col+offset) < 9 }
        neighbor_tiles
    end

    def to_s
        if @revealed
            if @value != 0
                @value.to_s # send the string value of the count of number of bombs nearby
            else # if there are no bombs nearby then it's an interior square so print "_"
                "_"
            end
        elsif @flagged # if the square is revealed, that overwrites a flag and comes first, otherwise if flagged, display it as F
            "F"
        else # if not revealed or flagged, then "*" stands for just unexplored
            "*"
        end
    end

end