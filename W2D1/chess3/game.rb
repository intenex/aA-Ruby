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
        saved_game = Marshal.dump(self) # holy fucking shit this worked even just natively with the fucking NullPiece Singleton object holy fucking shit as per https://ruby-doc.org/stdlib-1.9.3/libdoc/singleton/rdoc/Singleton.html all state is gone aka all instance variables and taint state but I don't think those matter anyway holy fucking shit it just fucking works
        IO.write(filename, saved_game)
        puts "Game successfully saved! Continuing on..."
        sleep(1)
        self.play
    end

    def load_game
        puts "Please enter the filename you would like to load from:"
        filename = gets.chomp.downcase
        loaded_file = Marshal.load(IO.read(filename)) # the docs for Marshal say to pass it "an IO instance or an object that responds to #to_str" so this seems like an IO instance https://ruby-doc.org/core-2.2.0/Marshal.html#method-c-load so glad you learned Marshal way better and more correct than yaml and is the native Ruby way to save objects in bytestreams so fucking great
        if loaded_file.is_a?(Game)
            puts "Game successfully loaded! Beginning play now..."
            sleep(1)
            loaded_file.play # start running a nested play from that point in the game fucking love it lol, this preserves the current player value so things should work appropriately
        else
            raise ArgumentError.new("Loaded file is not a valid Game instance.")
        end
    end

end