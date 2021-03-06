require_relative 'display'
require_relative 'humanplayer'
# require_relative 'customerrors' # fucking brilliant - either put all your custom error messages here like this in a global file as part of the Main class OR specifically call the class's error message insanely great let's try that, or you can just rescue specific class errors too fucking brilliant but now you know what's going on thanks to https://blog.appsignal.com/2018/07/03/custom-exceptions-in-ruby.html

class Game # crazy that these definitions are just constants and objects in of themselves, as in you can literally call Game.object_id to get its object id and also class methods are just part of the singleton class that is automatically created as an anonymous class for the class if you append any methods to it super nuts
    def initialize
        @board = Board.new
        @display = Display.new(@board)
        @players = { :white => HumanPlayer.new(:white, @display), :black => HumanPlayer.new(:black, @display) } # a hash where the key is the symbol and the value is the instance of that player
        @current_player = :white # check that this is right later. Start with white of course
        system('clear')
        if %x( printenv TERM_PROGRAM ).chomp != "iTerm.app" # only iTerm2 displays true colors so far as you can tell so otherwise set to 256 colors unless you find other true color terminals --> printenv TERM_PROGRAM is a shell command that returns the name of the terminal app currently running, and you run shell commands in Ruby with the %x() shorthand which is pretty amazing as per https://stackoverflow.com/questions/2232/calling-shell-commands-from-ruby and printenv here https://www.computerhope.com/unix/printenv.htm thank god Paint has the 256 mode
            puts "Sadly, it appears you are not running iTerm2, and so\ndo not have true color support. For best results,\nplease run in iTerm2. If you are positive your\nterminal can support true color mode or would like\nto try, press 'tab' at any time to switch modes.\nReverting to 256 color mode...\n\n"
            Paint.mode = 256
        end
        puts "Welcome to Terminal Chess! At any point,\npress ctrl-s to save your game,\nor ctrl-l to load a saved game.\nPress ctrl-c to exit.\nPress any key to continue." # initialization message so it doesn't show up again when the game is played
        @display.cursor.read_char # just lets the player enter any key to move forward in the game
    end

    def play
        while !game_over? # so great to know how to write code love life
            @players[@current_player].make_move(@board)
            (@current_player == :white) ? (@current_player = :black) : (@current_player = :white) # if current player is white then make the next player black otherwise make it white
        end
        system('clear')
        @display.render # do a final display of the end game love it
        puts "White has been checkmated! Congratulations, black." if @board.checkmate?(:white)
        puts "Black has been checkmated! Congratulations, white." if @board.checkmate?(:black)
        puts "White can no longer move and the game is stalemated!" if @board.stalemate?(:white)
        puts "Black can no longer move and the game is stalemated!" if @board.stalemate?(:black)
        puts "There is insufficient material to mate and the game is drawn." if @board.draw?
    rescue Cursor::SaveGameEscape # since the SaveGameEscape exception was defined specifically under the Cursor class, it's a specific exception *to* that class and you have to preface calling the constant with Cursor::SaveGameEscape (the double colon :: is a namespace resolver for constants, which makes sense, since constants are accessible everywhere so it's hyper important that they're namespaced to avoid collisions https://stackoverflow.com/questions/3009477/what-is-rubys-double-colon)
        begin
            save_game
        rescue Game::GameReturnEscape # more about these namespaced class specific error messages at this excellent blog post here: https://blog.appsignal.com/2018/07/03/custom-exceptions-in-ruby.html
            self.play # just restart play no harm in this so far as I can tell since retry doesn't work here
        rescue => e # ideally you don't just rescue all exceptions but you just don't know what kinds of exceptions there are for saving and loading and this will catch them and then you can over time specifically account for all of them, but as they say don't prematurely harden your code lol. Just catch the reasonable exceptions and have the catch-all. You can read the documentation later if you *really* want to get into this though, but I think you've done the reasonable work here even though you shouldn't have a catch-all generally if you can avoid it
            puts "#{e}\nHmm, something went wrong. Please try again."
            sleep(1)
            retry # just starts the begin block again awesome
        end
    rescue Cursor::LoadGameEscape
        begin
            load_game
        rescue Game::GameReturnEscape 
            self.play
        rescue => e
            puts "#{e}\nSorry, that file could not be loaded. Please try again."
            sleep(1)
            retry
        end
    end

    def game_over?
        @board.checkmate?(:white) || @board.checkmate?(:black) || @board.stalemate?(:white) || @board.stalemate?(:black) || @board.draw? # game is over if there is a checkmate, a stalemate, or a draw
    end

    def game_over_reason # refactor play out into this later
        return "White has been checkmated! Congratulations, black." if @board.checkmate?(:white)
        return "Black has been checkmated! Congratulations, white." if @board.checkmate?(:black)
        return "White can no longer move and the game is stalemated!" if @board.stalemate?(:white)
        return "Black can no longer move and the game is stalemated!" if @board.stalemate?(:black)
        return "There is insufficient material to mate and the game is drawn." if @board.draw?
    end

    class GameReturnEscape < StandardError
    end

    def save_game # yep this is the place to write these commands fucking amazing --> raise an exception to pull the game out to this state at the cursor input level fucking love it
        puts "Please enter the filename you would like to save to,\nor type 'back' to return to your game."
        filename = gets.chomp.downcase # only save lowercase and load lowercase to make it easy
        if filename == 'back'
            puts "Game not saved. Returning back..."
            sleep(1)
            raise GameReturnEscape
        end
        saved_game = Marshal.dump(self) # holy fucking shit this worked even just natively with the fucking NullPiece Singleton object holy fucking shit as per https://ruby-doc.org/stdlib-1.9.3/libdoc/singleton/rdoc/Singleton.html all state is gone aka all instance variables and taint state but I don't think those matter anyway holy fucking shit it just fucking works
        IO.write(filename, saved_game)
        puts "Game successfully saved! Continuing on..."
        sleep(1)
        self.play
    end

    def load_game
        puts "Please enter the filename you would like to load from,\nor type 'back' to return to your game."
        filename = gets.chomp.downcase
        if filename == 'back'
            puts "Game not loaded. Returning back..."
            sleep(1)
            raise GameReturnEscape
        end
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