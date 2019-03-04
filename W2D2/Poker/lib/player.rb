require 'hand'

# 2 to 6 players - so enter 2 to 6 players when the game starts
# cards are dealt one at a time for each player nice to be precise in game play that's how to do it
# before play begins, an ante is added to the pot

class Player
    attr_accessor :chips, :side_pot
    attr_reader :hand, :pot, :name

    def initialize(name, game, deck, starting_chips) # initialized with a starting pot amount nice
        @name = name
        @hand = Hand.new(self)
        @chips = starting_chips
        @side_pot = nil # if this is active and not nil that means they're all in
        @folded = false
        @game = game
        @deck = deck # so you can draw cards from the deck and add them to the hand, this should be passed from game love it all coming together so well getting through the card logic was the only hard part so great now all the little ends and pieces
    end

    def reset_hand
        @deck.discards += @hand.cards
        @hand.cards = Array.new
    end

    # either fold, check (see the bet), or raise
    def get_move # damn getting so good at all this shit lol
        return if @side_pot # if the side_pot is not nil then this player doesn't 
        puts "Your turn, #{name}!\nWould you like to [f]old, [c]heck/[c]all, or [r]aise?"
        answer = gets.chomp.downcase
        case answer
        when "f"
            # call fold
        when "c"
            # find the call_amt
            # raise an error if the call_amt is higher than the pot amt of the player, otherwise go through
            # match the current bet amount and stay in
        when "r"
            puts "How much would you like to raise?"
            raise_amt = gets.chomp.to_i
            if (raise_amt + @game.current_bet) < @chips
                @game.current_bet += raise_amt # could refactor that into a game method too which would be slightly more accurate likely in good class delineation
                @chips -= @game.current_bet
                @game.pot += @game.current_bet
            else
                raise ArgumentError.new("That was not a valid amount to raise. Try again.")
            end
        else
            raise ArgumentError.new("That was not a valid entry. Try again.")
        end
    rescue ArgumentError => e
        puts e
        retry
    end

    def discard
        puts "Your turn, #{@name}!\nWould you like to discard any cards? Y/N"
        answer = gets.chomp.downcase
        case answer
        when "y"
            c = @hand.cards.sort_by { |card| card.value }
            puts "Choose up to three cards to discard like so: 1 2 3
            1: #{c[0].to_s}, 2: #{c[1].to_s}, 3: #{c[2].to_s}, 4: #{c[3].to_s}, 5: #{c[4].to_s}"
            chosen_cards = gets.chomp.split.map(&:to_i)
            if chosen_cards.length > 3 || chosen_cards.length == 0
                raise ArgumentError.new("Choose between 1-3 cards. Try again.")
            elsif !chosen_cards.all? { |num| num <= 5 && num > 0 } # if not all the cards are between 1 and 5
                raise ArgumentError.new("Those numbers were out of bounds. Try again.")
            elsif chosen_cards.detect { |num| chosen_cards.count(num) > 1 } # if this isn't nil it means it found some number that was repeated more than once amazing #detect method look into this more for sure https://stackoverflow.com/questions/8921999/ruby-how-to-find-and-return-a-duplicate-value-in-array
                raise ArgumentError.new("No duplicate choices, please. Try again.")
            else # if all those pass then should be good to go lol
                chosen_cards.each { |card| @deck.discards << @hand.cards.delete(card) } # delete each card that was chosen from the hand, and shovel it into the discard pile of the @deck lol
                chosen_cards.length.times { @hand.cards << @deck.get_card } # shovel in a card from the @deck.get_card method which should get a card from the top of the deck and return it and delete it love it (pop)
                c = @hand.cards.sort_by { |card| card.value } # get the new cards think this is necessary who knows
                puts "#{chosen_cards.length} new cards added successfully. Your new hand is:
                1: #{c[0].to_s}, 2: #{c[1].to_s}, 3: #{c[2].to_s}, 4: #{c[3].to_s}, 5: #{c[4].to_s}"
                sleep(2)
            end
        when "n"
            puts "No cards discarded. Moving on..."
            sleep(1)
        else
            raise ArgumentError.new("That was not a valid entry. Try again.")
        end
    rescue => e
        puts e
        retry
    end

    # discard method --> this happens after betting, all the players get to decide what to discard and whatnot
    # discarded cards don't get reshuffled back in, they're set aside until all cards are drawn through in which case the cards reset fucking love it

    # at the end of each game or when cards run out, the deck is reshuffled

    # if all players check during the first round of betting, the dealer moves to the next player and another ante is added by each player awesome
end