class Tile

    attr_reader :bomb, :pos, :revealed
    attr_accessor :flagged, :value

    def initialize(board, pos, bomb)
        @board = board; @bomb = bomb; @revealed = false; @flagged = false; @pos = pos; @value = nil  # right need to call the getter method of board's grid later, board being the object that was just passed in...but also can't do this at exactly the same time. Have to define it later after the board is fully populated, right. || # start by setting @value to nil then later call neighbor_bomb_count to change this value for everything
    end

    def reveal
        if @value == 0 && @revealed == false # if the tile hasn't already been revealed before, do the following, otherwise skip so it doesn't inefficiently just keep doing this for tiles that have already done this recursive step
            @revealed = true # have to put this in here to not recurse forever heh you're real good at avoiding these since you did it so much in helldoku lol what a great experience honestly
            neighbors(self.pos).each do |loc|
                row, col = loc
                @board.grid[row][col].reveal # recursion! --> if it's an internal tile with no bomb neighbors reveal all the tiles next to it too love it think this is great wow so easy actually
            end
        end
        @revealed = true
    end

    def neighbor_bomb_count(pos) # just to make it explicit and not rely on hard coded values again
        neighbor_tile_locations = neighbors(pos); count = 0
        neighbor_tile_locations.each { |loc| row, col = loc; count += 1 if (@board.grid[row][col]).bomb }# if this value is true --> note that it's actually the index of the @board.grid attribute that you're calling with @grid's getter method, since @board is actual the board object you passed in, since you couldn't pass in the grid while it was being formed, you needed to wait until every Tile was initialized first and then populate these values, it has to be a two step process. So you pass in the Board object first, wait for the grid to be instantiated with tiles completely first, then call the grid from within that object passed in (a pointer to it, at least) to see how many other tiles are around it and what values they have, awesome, love it.
        count
    end

    def neighbors(pos) # ah this is the helper method to get the neighbors right love it
        neighbor_tiles = Array.new; row, col = pos # find all 8 neighbors by doing each row sequentially and getting those positions. Do three enumerators to get the top row, the middle row, and the bottom row respectively
        (-1..1).each { |offset| neighbor_tiles << [(row-1), (col+offset)] if (row-1) >= 0 && (col+offset) >= 0 && (row-1) < 9 && (col+offset) < 9 } # make sure both are within bounds and not at an edge of the board, if it's within bounds, add that position to the neighbor_tiles array to return to be checked
        [-1, 1].each { |offset| neighbor_tiles << [row, (col+offset)] if (col+offset) >= 0 && (col+offset) < 9 } # don't need a 0 here because 0 is just the current tile itself. For the enumerator's conditional check, don't just blindly copy and paste code, obviously row is fine because the current tile is in row, just check what isn't possibly fine
        (-1..1).each { |offset| neighbor_tiles << [(row+1), (col+offset)] if (row+1) >= 0 && (col+offset) >= 0 && (row+1) < 9 && (col+offset) < 9 }
        neighbor_tiles
    end

    def to_s
        if @revealed # not checked since nothing revealed yet, see if this works once revealed
            return "*" if @bomb # if it's a bomb, reveal it as such --> and since the whole board will be revealed when a mine is hit you can show these as the * since there will be no unrevealed tiles anymore
            @value != 0 ? @value.to_s : "_" # this is how to do a one line if statement love it https://stackoverflow.com/a/3827879/674794 if @value is not equal to 0 is true, then @value.to_s, otherwise if it is false and @value is 0, then print "_" to symbolize it's an interior piece surrounded by no bombs # send the string value of the count of number of bombs nearby || # if there are no bombs nearby then it's an interior square so print "_"
        elsif @flagged # if the square is revealed, that overwrites a flag and comes first, otherwise if flagged, display it as F
            "F"
        else # if not revealed or flagged, then "*" stands for just unexplored
            "*"
        end
    end

end