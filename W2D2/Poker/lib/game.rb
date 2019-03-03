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
        until game_over?
        end
    end

    def game_over?
        @players.one? { |player| player.chips != 0 } # when there is only one player left with any chips the game is over otherwise it continues love it wow literally just so much programming work to finish anything actually hilarious that they expect us to be able to finish all of these in a single day lmao
    end
end