# don't forget to account for the ante at one point too

class Game
    attr_accessor :current_bet, :pot

    def initialize(*players)
        @deck = Deck.new
        @players = players.map { |player_name| Player.new(player_name, @deck, 1000) } # starting chips of 1000 per player
        @current_bet = 0
        @pot = 0
        @dealer = player[0]
        @current_player = player[1] # starts as the player next to the dealer then increments and then both dealer and player shift forward one at the reset of each turn
    end

    def play_game
        play_round until game_over?
        winning_player = @players.select { |player| player.chips != 0 }.compact # select the one player who has non-zero chips and compact it down so you remove all the nils lol
        puts "The game is over! #{winning_player[0].name} wins!" # this gets the one array element in winning_player which I think needs to be called with [0] but we'll see lol test it
    end

    # give each player cards
    # then
    def play_round
        active_players = @players.select { |player| player.chips != 0 }.compact # instead of removing the players when they run out of cards you do this maybe it's better to just remove the players lol oh well
    end

    def game_over?
        @players.one? { |player| player.chips != 0 } # when there is only one player left with any chips the game is over otherwise it continues love it wow literally just so much programming work to finish anything actually hilarious that they expect us to be able to finish all of these in a single day lmao
    end
end