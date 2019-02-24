require_relative 'display'
require_relative 'humanplayer'

class Game # crazy that these definitions are just constants and objects in of themselves, as in you can literally call Game.object_id to get its object id and also class methods are just part of the singleton class that is automatically created as an anonymous class for the class if you append any methods to it super nuts
    def initialize
        @board = Board.new
        @display = Display.new(@board)
        @players = { :white => HumanPlayer.new(:white, @display), :black => HumanPlayer.new(:black, @display) } # a hash where the key is the symbol and the value is the instance of that player
        @current_player = :white # check that this is right later. Start with white of course
    end

    def play
        while !@board.checkmate?(:white) && !@board.checkmate?(:black) # so great to know how to write code love life
            @players[@current_player].make_move(@board)
            (@current_player == :white) ? (@current_player = :black) : (@current_player = :white) # if current player is white then make the next player black otherwise make it white
        end
        system('clear')
        @display.render # do a final display of the end game love it
        @board.checkmate?(:white) ? (puts "White has been checkmated! Congratulations, black.") : (puts "Black has been checkmated! Congratulations, white.")
    end

end