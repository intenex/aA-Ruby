class Game # crazy that these definitions are just constants and objects in of themselves, as in you can literally call Game.object_id to get its object id and also class methods are just part of the singleton class that is automatically created as an anonymous class for the class if you append any methods to it super nuts

    def initialize
        @board = Board.new
        @display = Display.new(@board)
        @players = { :white => HumanPlayer.new(:white, @display), :black => HumanPlayer.new(:black, @display) } # a hash where the key is the symbol and the value is the instance of that player
        @current_player = @players[:white] # check that this is right later. Start with white of course
    end

    def play
        while !@board.checkmate?(:white) && !@board.checkmate?(:black) # so great to know how to write code love life
            @current_player.make_move(@board)
            (@current_player == @players[:white]) ? (@current_player = @players[:black]) : (@current_player = @players[:white]) # if current player is white then make the next player black otherwise make it white
        end
    end
end