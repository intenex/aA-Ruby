require_relative 'tic_tac_toe_node'

# boom done in 7 minutes total just about one hour to finish all of TicTacToe when fully well rested fucking love it push ahead and push ahead faster and be focused with no distractions and you can definitely do this in time. Picking up steam well. Let's keep pushing. 19 days - let's make the most of this. 10 more lessons at least. That'll get you through SQL and into Rails ideally. One can hope. Or just go into Javascript after Ruby. We'll decide that when we get there. You have some JS experience so might be better to do SQL; we'll see. Plus they don't even test on JS so that's that too lol.

class SuperComputerPlayer < ComputerPlayer # subclass of ComputerPlayer, awesome
  def move(game, mark)
    root_node = TicTacToeNode.new(game.board, mark) # ah yes awesome we pick the next move that is guaranteed to have us win love it
    root_node.children.each do |child|
      return child.prev_move_pos if child.winning_node?(mark)
    end
    root_node.children.each do |child|
      return child.prev_move_pos if !child.losing_node?(mark) # if no winning moves then just pick any move that's not a losing move
    end
    raise # if nothing was picked then there was an error since the SuperComputerPlayer should always be able to force at least a draw
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
