require_relative 'display'
require_relative 'humanplayer'

class Game # crazy that these definitions are just constants and objects in of themselves, as in you can literally call Game.object_id to get its object id and also class methods are just part of the singleton class that is automatically created as an anonymous class for the class if you append any methods to it super nuts
    def initialize
        @board = Board.new
        @display = Display.new(@board)
        @players = { :white => HumanPlayer.new(:white, @display), :black => HumanPlayer.new(:black, @display) } # a hash where the key is the symbol and the value is the instance of that player
        @current_player = :white # check that this is right later. Start with white of course
    end

    class SaveGameEscape < StandardError # just a way to bubble up the error call love it heh
    end

    class LoadGameEscape < StandardError
    end

    def play
        puts "Welcome to chess! At any point, press ctrl-s to save your game, or ctrl-l to load a saved game."
        sleep(2)
        while !@board.checkmate?(:white) && !@board.checkmate?(:black) # so great to know how to write code love life
            @players[@current_player].make_move(@board)
            (@current_player == :white) ? (@current_player = :black) : (@current_player = :white) # if current player is white then make the next player black otherwise make it white
        end
        system('clear')
        @display.render # do a final display of the end game love it
        @board.checkmate?(:white) ? (puts "White has been checkmated! Congratulations, black.") : (puts "Black has been checkmated! Congratulations, white.")
    rescue TypeError
        begin
            save_game
        rescue => e
            puts "#{e}\nHmm, something went wrong. Please try again."
            sleep(1)
            retry # just starts the begin block again awesome
        end
    rescue NameError
        begin
            load_game
        rescue => e
            puts "#{e}\nSorry, that file could not be loaded. Please try again."
            sleep(1)
            retry
        end
    end

    def save_game # yep this is the place to write these commands fucking amazing --> raise an exception to pull the game out to this state at the cursor input level fucking love it
        puts "Please enter the filename you would like to save to:"
        filename = gets.chomp.downcase # only save lowercase and load lowercase to make it easy
        IO.write(filename, self.to_yaml)
        puts "Game successfully saved! Continuing on..."
        sleep(1)
        self.play
    end

    def load_game
        puts "Please enter the filename you would like to load from:"
        filename = gets.chomp.downcase
        loaded_file = YAML::load(IO.read(filename))
        if loaded_file.is_a?(Game)
            loaded_file.play # start running a nested play from that point in the game fucking love it lol, this preserves the current player value so things should work appropriately
        else
            raise ArgumentError.new("Loaded file is not a valid Game instance.")
        end
    end

end