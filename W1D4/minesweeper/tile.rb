class Tile

    attr_reader :bomb, :board
    attr_accessor :revealed, :flagged

    def initialize(board, bomb) # true or false
        @board = board
        @bomb = bomb
        @revealed = false
        @flagged = false
    end

    # def inspect learn how to make this work correctly lol
    #     puts "Bomb: #{@bomb}, Flagged: #{@flagged}, Revealed: #{@revealed}"
    # end

    def reveal
        @revealed = true
    end

    def neighbors
    end

    def neighbor_bomb_count
    end

    def to_s
    end

end