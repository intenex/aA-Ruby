# don't forget to account for the ante at one point too

class Game
    attr_accessor :current_bet, :pot

    def initialize(*players)
        @deck = Deck.new
        @players = players.map { |player_name| Player.new(player_name, @deck, 1000) } # starting chips of 1000 per player
        @current_bet = 0
        @pot = 0
    end
end