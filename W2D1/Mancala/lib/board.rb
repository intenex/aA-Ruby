# done in one hour and ten minutes lol not great but good for being so hyper caffeinated I suppose lol and for just getting through it when this one was not the easiest for sure love it awesome :) interesting code unconventional but it works! Man you love that conditional shorthand if else SO much lmfao so glad you learned it lol. And learning so many other awesome Ruby methods and googling them as they go so great

class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @player1 = name1 # @cups[6] is this player's side
    @player2 = name2 # @cups[13] is this player's side
    @cups = Array.new(14)
    place_stones
  end

  def place_stones
    # helper method to #initialize every non-store cup with four stones each
    @cups.map!.with_index { |store, index| (index != 6 && index != 13) ? (Array.new(4) {:stone}) : Array.new } # your code will be unconventional because you are so caffeinated lol. Finally understood what they want though lol. Should have read the specs better
  end

  def valid_move?(start_pos)
    raise ArgumentError.new("Invalid starting cup") if (start_pos < 0 || start_pos > 13)
    raise ArgumentError.new("Starting cup is empty") if @cups[start_pos].empty?
  end

  # wow this worked in one go despite being rather complex logic lol could be factored to be better but oh well
  def make_move(start_pos, current_player_name)
    num_stones = @cups[start_pos].count # pass over the number of stones
    @cups[start_pos] = Array.new # empty the position
    indexes = Array.new(num_stones).fill { |i| (start_pos + i + 1) % 14 } # creates an array of length num_stones and fills with a number starting from start_pos + 1. Modulo 14 so it doesn't go over 13, damn you got that wrong by one lol that was the error fuck byebug is gloriously good
    ending_cup_index = indexes[-1]
    if current_player_name == @player1
      if indexes.include?(13) # if it includes the index of the other players' stone box, then change this to the last increment
        index_to_change = indexes.index(13) # change this increment value to something else. Note that this only accounts for one run_through, not multiple run throughs
        indexes[index_to_change] = ((indexes[-1] + 1) % 14) # instead of adding a stone to the other player's cup, add one increment past the last increment currently being incremented
        ending_cup_index = ((indexes[-1] + 1) % 14) # fix the ending_cup_index
      end
    else
      if indexes.include?(6)
        index_to_change = indexes.index(6)
        indexes[index_to_change] = ((indexes[-1] + 1) % 14)
        ending_cup_index = ((indexes[-1] + 1) % 14)
      end
    end
    indexes.each { |index| @cups[index] << :stone } # add a stone to each cup as appropriate
    self.render
    self.next_turn(ending_cup_index)
  end

  def next_turn(ending_cup_idx)
    # helper method to determine whether #make_move returns :switch, :prompt, or ending_cup_idx
    return :prompt if (ending_cup_idx == 6 || ending_cup_idx == 13) # if the ending_cup_idx is either of the player cups that means that it was *the* players cup because it could only end on that index if it was that player awesome love it good logic skills lol. Also run this before :switch since if you end here there's a chance this cup is empty so it'll have a value of 1 the first time you land here love it
    return :switch if (@cups[ending_cup_idx].count == 1) # right want it to equal 1 because you put a stone in there love it not empty smart god conditional debuggers are god mode seriously so glad you learned how to use it
    ending_cup_idx # if neither of the above, just return the index of the cup you ended on so just pass this through
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    @cups[0..5].all? { |cup| cup.empty? } || @cups[7..12].all? { |cup| cup.empty? } # if either side is all empty
  end

  def winner
    return :draw if @cups[6].count == @cups[13].count
    (@cups[6].count > @cups[13].count) ? @player1 : @player2 # if player one's stones are greater than player two's, return player1's name, otherwise return player2
  end
end
