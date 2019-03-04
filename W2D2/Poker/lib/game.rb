# don't forget to account for the ante at one point too
# your game is way over-engineered for edge cases that can never realistically happen because there are only 2 turns because you didn't realize that about five card draw
# it is indeed way easier to just play a game you actually know lol

# side pots and ante and showdown and I think the game is literally done just about lol without ever having tested a thing so hilariously bad and nuts

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
        pay_ante(active_players)
        active_players.each { |player| player.hand.cards << @deck.get_card } until active_players.all? { |player| player.hand.cards == 5 } # until all players have 5 cards --> this simulates the correct dealing of cards of one at a time in order to all the cards
        remaining_players = play_turn(active_players)
        if remaining_players.length == 1 # if there's only one player left after betting then just have them win the pot
            winning_player(remaining_players[0])
            reset_round(active_players)
            return
        elsif @current_bet == 0 # aka if everyone checked and no one bet, then restart the game, throw in all the cards, shuffle the deck, change the dealers, etc
            reset_round(active_players) # pot stays the same no one wins it just continues again love it
            return # restart hell yeah # this does the same thing as just calling the same method except doesn't go lower in the stack and goes back up to the stack so you don't go arbitrarily deep in the stack same deal
        end
        discard_cards(remaining_players)
        final_players = play_turn(remaining_players)
        if final_players.length > 1 # if there's more than one player then show cards
            showdown(final_players)
        else # if there's just one player then give the pot to that player
            winning_player(final_player[0])
        end
        reset_round(active_players)
    end

    def winning_player(player)
        player.chips += @pot
        puts "#{player.name} wins the round with #{@pot} chips!"
        @pot = 0
        sleep(1)
    end

    def reset_round
        active_players.each { |player| player.reset_hand; player.folded = false; player.side_pot = nil } # this is the only time all players have their hands reset maybe you should do it when they fold and put their cards back in the discard pile then but this should work fine # reset folded # just in case reset the side_pot too because why not just to be safe and avoid edge cases since you've already learned that lesson
        @deck.reset_deck
        new_remaining_players = @players.select { |player| player.chips != 0 }.compact # okay you're doing this enough that you really should just fucking move everyone into a new array when they leave the game let's do that later sigh
        @current_bet = 0
        @dealer = (@dealer + 1) % new_remaining_players.length # this makes sure the dealer wraps around to 0 when there are 5 players on 5 it'll modulo to 0 love it so it'll do 0 1 2 3 4 perfect
        @current_player = (@dealer + 1) % new_remaining_players.length # this also goes one forward from the new dealer to start over again hilariously lol think this is right though not up to date on your poker nuances like you are on chess but this should definitely be good enough love it
    end

    def play_turn(players) # this should return all the players left in the round after the turn
        players.each { |player| player.get_move }
    end

    def discard_cards(players)
        players.each { |player| player.discard }
    end

    # account for any possible side pots here
    # basically if the winning player has a side pot, check for that
    # and if so only give them the total amount of the side pot times
    # all the players at showdown and then the rest of the pot is split
    # amongst the next largest winner

    # you're really close to making this all work now so my best suggestion is to not take into account side pots for now and get the code all working at its basic state then slowly incorporate side pot logic or just move the fuck on because you did all the work now pretty much as long as it works move on for now and come back to this shit lol
    def showdown(final_players)
        hand1 = final_players.pop.hand # crazy method chaining lmao chaining an instance method of the element you just popped out to assign let's see if this works lol Ruby is an insane language
        hand2 = final_players.pop.hand
        last_hand = hand1 # for when there is no winner in the logic below super nuts
        # okay your winning_hand method is SUPER weird because the guidelines led you astray ugh
        winner = hand1.winning_hand(hand1, hand2)
        until final_players.empty? # until this is true
            if winner # if this isn't nil then continue lol
                next_hand = final_players.pop.hand 
                last_hand = winner # update the last hand if there is a winner for use when there isn't a winner
                winner = winner.winning_hand(winner, next_hand)
            else
                next_hand = final_players.pop.hand
                winner = last_hand.winning_hand(last_hand, next_hand) # use whichever hand was set as the last_hand when there isn't a winner - this was either the hand1 that was set in the very beginning or the last winner when there was actually a winner before the last draw
            end
        end
        if winner # if there is a winner after all the hands are evaluated
            # check if the winner has a side pot if not just give them all the money
            # if they have a side pot...good luck figuring that shit out and make the calls to find the next player to award all the money too lol so much logic here man so close to the finish line
        else
            # if there was no winner then split pot between last_hand and next_hand, which were the last two to draw, AND POSSIBLY ALL THE OTHER PEOPLE WHO DREW BEFORE LOL so much to keep track of as edge cases jfc
            # check if either drawer has a side pot if so this is very tricky to calculate actually, I believe they get everything in the pot split minus however much more the other person has bet than them, which that person gets back in full --> but how to calculate how much more one person has bet than another? damn. Fuck side pots are hard to calculate actually lol https://www.pokerlistings.com/rules-for-poker-all-in-situations-poker-side-pot-calculator
            # if no side pot, just split the pot perfectly evenly between both players
        end
    end

    def pay_ante(players)
        ante = 50 # arbitrary number
        players.each do |player|
            if player.chips >= 50
                player.chips -= 50
                @pot += 50
            else # if chips are less than the pot the player can only be paid the side_pot amount and posts all their remaining chips as ante
                @pot += player.chips
                player.side_pot = player.chips
                player.chips = 0
            end
        end
    end

    def game_over?
        @players.one? { |player| player.chips != 0 } # when there is only one player left with any chips the game is over otherwise it continues love it wow literally just so much programming work to finish anything actually hilarious that they expect us to be able to finish all of these in a single day lmao
    end
end