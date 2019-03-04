# don't forget to account for the ante at one point too
# your game is way over-engineered for edge cases that can never realistically happen because there are only 2 turns because you didn't realize that about five card draw
# it is indeed way easier to just play a game you actually know lol

class Game
    attr_accessor :current_bet, :pot

    def initialize(*players)
        @deck = Deck.new
        @players = players.map { |player_name| Player.new(player_name, @deck, 1000) } # starting chips of 1000 per player
        @current_bet = 0
        @pot = 0
        @dealer = 0
        @current_player = players[1] # starts as the player next to the dealer then increments and then both dealer and player shift forward one at the reset of each turn
    end

    def play_game
        play_round until game_over?
        winning_player = @players.select { |player| player.chips != 0 }.compact # select the one player who has non-zero chips and compact it down so you remove all the nils lol
        puts "The game is over! #{winning_player[0].name} wins!" # this gets the one array element in winning_player which I think needs to be called with [0] but we'll see lol test it
    end

    # give each player cards
    # then start with the current player, go around until the betting stops, give the pot to whoever wins it
    # then reset the cards (put every card in each player's hand in the discard pile, set each player's hand to an empty array, call deck#reset_deck)
    # then increment the dealer and the current_player to players[dealer + 1] and that's it love it heh
    # oh interesting there are just two rounds and then a show down love it
    def play_round
        active_players = @players.select { |player| player.chips != 0 }.compact # instead of removing the players when they run out of cards you do this maybe it's better to just remove the players lol oh well
        active_players.each { |player| player.hand.cards << @deck.get_card } until active_players.all? { |player| player.hand.cards == 5 } # until all players have 5 cards --> this simulates the correct dealing of cards of one at a time in order to all the cards
        original_bet = @current_bet
        remaining_players = play_turn(active_players)
        if @current_bet == original_bet # aka if everyone checked and no one bet, then restart the game, throw in all the cards, shuffle the deck, change the dealers, etc
            players.each { |player| player.reset_hand }
            self.reset_round
            play_round # restart hell yeah
        end
        discard_cards(remaining_players)
        final_players = play_turn(remaining_players)
        if final_players.length > 1 # if there's more than one player then show cards
            showdown(final_players)
        else # if there's just one player then give the pot to that player
            final_player[0].chips += @pot
            puts "#{final_player[0].name} wins the round with @{pot} chips!"
            @pot = 0
            sleep(1)
        end
        active_players.each { |player| player.reset_hand } # this is the only time all players have their hands reset maybe you should do it when they fold and put their cards back in the discard pile then but this should work fine
        self.reset_round
    end

    def reset_round
        @deck.reset_deck
        new_remaining_players = @players.select { |player| player.chips != 0 }.compact # okay you're doing this enough that you really should just fucking move everyone into a new array when they leave the game let's do that later sigh
        @dealer = (@dealer + 1) % new_remaining_players.length # this makes sure the dealer wraps around to 0 when there are 5 players on 5 it'll modulo to 0 love it so it'll do 0 1 2 3 4 perfect
        @current_player = (@dealer + 1) % new_remaining_players.length # this also goes one forward from the new dealer to start over again hilariously lol think this is right though not up to date on your poker nuances like you are on chess but this should definitely be good enough love it
    end

    def play_turn(players) # this should return all the players left in the round after the turn
        players.each { |player| player.get_move }
    end

    def discard_cards(players)
        players.each { |player| player.discard }
    end

    def showdown(final_players)

    end

    def game_over?
        @players.one? { |player| player.chips != 0 } # when there is only one player left with any chips the game is over otherwise it continues love it wow literally just so much programming work to finish anything actually hilarious that they expect us to be able to finish all of these in a single day lmao
    end
end