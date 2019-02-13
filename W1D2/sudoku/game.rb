require_relative './board.rb' # ./ means current directory that's all

# omg it's done lmfao and you got the reader attributes correct no accessors love it
# omg no major issues no need to debug with byebug in the slightest getting so good at this love it so much fuck yeah can't wait to push ahead

# Amazing things to do, this *should* be easier than the Memory Puzzle thing and should be doable since just checking, so hopefully you can put it together, let's fucking do this shit :)
# 1. Read the sudoku text file --> Done hell yeah!
# 2. Create a grid with all the tiles from the Sudoku text file, with 0s being values that can be changed and the others being given tiles that cannot be changed --> Done hell yeah! Def getting way better at this love it
# 3. Create a way to render the board --> Done hell yeah!
# 4. Create a method that allows you to update the values of each tile, with only valid tiles allowed --> done hell yeah!
# 4. Check to see if the game is won - namely if each sub grid has all the values from 1-9 and each row and column adds up to 9 --> Done hell yeah!

# testing small is the best thing ever love it so much no need for byebug or debugger at all this time saves sooo much time

class Game
    attr_reader :grid

    # god you're getting good at all this shit love it so much
    def initialize(file)
        @grid = Board.from_file(file)
        @board = Board.new(grid)
    end

    def play
        while !@board.solved? # while not solved, play this
            @board.render
            pos, value = self.prompt
            @board[pos] = value
        end
        puts "Congratulations, you've won!"
    end

    def prompt
        puts "Please enter a position and a value with the first two numbers\nbeing the position and the last being the value, like so: '1 2 3'"
        input = validate_input(gets.chomp)
        if !input # input either returns false or the sanitized input, if false, then re-prompt
            puts "That was not a valid input! Please try again."
            self.prompt
        else
            input # if input isn't false, then it's valid and you should return it, input should be an array like [[1, 2], 1], with the first element being a subarray that's a position and the second being a value, love it
        end
    end

    def validate_input(input)
        if input.split.length == 3
            row, column, value = input.split.map(&:to_i)
        else
            return false # if not 3 items have to return false otherwise will throw exception
        end
        return false if (row < 0 || row > 8)
        return false if (column < 0 || column > 8)
        return false if (value <=0 || value > 9)
        [[row, column], value] # if all are correct, then return it all
    end

end