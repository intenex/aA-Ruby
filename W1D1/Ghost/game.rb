# Time track on working on this problem so far - probably about 2.5 hours at most not bad - started again at about 9:45 pm --> Finished the phase 2 with two players about 1.75 hours in really
# Game is amazing works so well lol kinda great super rewarding glad it's so easy to you because you actually do understand everything so far
# comments are great super glad you're doing comments and getting good at commenting code again love it though you def don't respect the 80 char line limit lol you are way too verbose for that
# holy fuck can't believe you completely refactored all the code for multiplayer in one try without even running any of your code and barely got any mistakes and errors, truly insane - you're really good at avoiding errors now which demonstrates you really understand your code and saves tons of time though it comes at the cost of being slightly less good at debugging but man you're really getting the hang of this love it so much
# can't believe the game actually checks for almost all the error conditions love it hopefully it passes all their specs we'll see

# require 'set' # huh don't think you actually need to require this interesting seems like it's auto-included
# note that only CONSTANT variables make it across the require file divide and are imported, variables are not
require_relative './dictionary.rb' # import the set object constant WORD_DICT with all the dictionary words to check with, note that constants just have to technically start with one uppercase letter but by convention they're written all uppercase, only Classes and Modules are written in CamelCase like that without everything being uppercase, everything else is just all uppercase
require_relative './aiplayer.rb'

# yay basic game is working just fine after 1 hour 10 minutes
class Game
    attr_reader :dictionary # so great you actually get to finally take off the training wheels and design this game yourself super excited
    attr_accessor :fragment, :players, :player_array, :player_index

    # doesn't throw an error if only one name is passed into the array because the game will just auto end if that's the case which is fine no need to force multiple elements in the players array
    def initialize(players) # players should be an array that includes every player's name
        @players = Hash[players.map { |name| [name, 0] }] # this is a hash that takes the player's name as the key value and assigns 0 as the number of losses for now, obviating the need for the @losses hash. It does this by taking the players name hash that just has names, and then expanding that with map to an array that basically adds another element after each name with the default value of 0, and then the Hash[] call automatically iterates through the array, setting every other element to a key and the element immediately following that element to the value of that key love it
        @fragment = ''
        @dictionary = WORD_DICT.to_set # a set is ideal because it allows for Hash's fast lookup with Array's inter-operation facilities and doesn't have a key value pair just unordered values. Note that you actually defined it as an Array in the other document to use the very time saving %w() shorthand to define an array of words without quotes or anything - and here you can convert it to a set, so you learn more methods than one this way though you still don't know how to easily initialize a set sadly lol. Love it - it indeed works and is a set now lol
        @player_array = players # create an array that keeps track of the order in which people should play so you can switch players
        @player_index = 0
        # @losses = { player1 => 0, player2 => 0 } # keys are player objects, and values are the number of losses they have
    end # sweet confirmed that set.include?("word") works on sets

    def run 
        while @players.length > 1 # while there is at least one player left in the game
            self.play_round
            if @players.has_value?(5) # if any player has a value of 5 during after this round, remove them from the game as they've lost
                puts "#{@players.key(5)} has spelled GHOST and has lost the game!"
                @player_array.delete(@players.key(5)) # delete the current player from the @player_array, do this first before you delete it from the hash so you can use @players.key(5) to find the correct player to delete lol, alternatively you can use @player_array.delete_at(@player_index) which will delete the element at @player_index which should reference the current player, meaning the player that just lost, but this first method makes it 100% certain using the same method of matching by name that you're deleting the same person from both arrays
                @players.delete(@players.key(5)) # delete the player that just lost
            end
            self.next_player! # run next_player outside of the play_round since otherwise players would be removed after the current player index was incremented and the index might be out of bounds - if you run it like this it will bound the next player to the new player_index.length since it modulos by the new length in this method
        end
        puts "All but one player has lost! #{@player_array[0]} wins!" # get the name of the player who got 5 losses
    end

    def play_round
        print "Fragment: #{@fragment} | Current Player: #{@player_array[@player_index]}\n Scoreboard: " # these variable blocks in strings are super helpful
        @players.each_key { |k| print "#{k}: #{self.record(k)} "}
        self.take_turn(@player_index)
    end
    
    def next_player! # switches the values of current_player and previous_player
        @player_index = (@player_index + 1) % @player_array.length # this increments the player that should play next every time the game switches players love it
    end

    def take_turn(player_index) # gets a string from the player until a valid play is made, then updates the fragment and checks against the dictionary. Wow whoever writes this really gets all their grammar consistently wrong used a semicolon there so interesting where a comma should have been. You may also want to alert the player if they attempt to make an invalid move (or, if you're feeling mean, you might cause them to lose outright lol)
        puts "\nPlease enter a letter or type 1 to call the AI" # love this optionality this is exactly how to build it so great
        player_input = gets.chomp.downcase # remove the trailing \n and make it downcase
        if player_input.to_i == 1 # then the AI has been called, play the AI, amazing how simple this was to plug in don't ever be daunted by anything wow
            ai = AiPlayer.new(@fragment, @player_array.length) # this passes in the current fragment and the # of players remaining which should be up to date at this point in the code
            player_input = ai.choose_move # calls the choose_move method which returns the optimal character to play
        end
        while !self.valid_play?(player_input) # nice finally using while loops correctly while the input is not valid keep asking for a new entry
            puts "That was an invalid entry. Try again."
            player_input = gets.chomp.downcase # remove the trailing \n and make it downcase
        end
        @fragment << player_input # once the input is valid, add it to the fragment here
        if @dictionary.include?(@fragment)
            puts "A word, #{@fragment}, has been completed! A new game begins now."
            @players[@player_array[@player_index]] += 1 # find the current player by running the current @player_index on the @player_array and pass in that name as the key value to the @players hash and then increment their loss count by one
            @fragment = ''
        end
    end

    # omg this works perfectly the .any? start_with commands incredible doesn't seem to take that long either love it so great this thing totally just works now love it and didn't take you long at all everything should be working perfectly now pretty much time to push forward :) multiplayer then done!
    def valid_play?(string) # checks that string is a letter of the alphabet and that there are words we can spell after adding it to the fragment
        "abcdefghijklmnopqrstuvwxyz".include?(string) && string.length == 1 && @dictionary.any? { |word| word.start_with?(@fragment+string) } # only return true if any word starts with the extant fragment + the new string and if it's an alphanumeric string and if it was only one character.
    end

    def record(player) # Sweet works fantastic
        "GHOST"[0...@players[player]] if @players[player] > 0 # returns the substring of GHOST spelled by the number of losses love it
    end

end