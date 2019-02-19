# the specs will tell you everything you need to know easily love it
# finished all of this in 55 minutes not too bad at all

require_relative 'tic_tac_toe'
require "byebug"

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil) # default values love it right use that more
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  # omfg killed it if your code is right and you believe it to be look logically for where you believe it to be wrong can't believe that actually worked out so lucky
  def losing_node?(evaluator)
    evaluator == :x ? (opponent_mark = :o) : (opponent_mark = :x)
    return true if @board.over? && @board.winner == opponent_mark # base case - if the board is over and the winner is the opponent's mark, then we've lost
    return false if @board.over? && @board.winner != opponent_mark # if the winner is nil or us, basically
    if @next_mover_mark == evaluator # if it is our turn, check if all the child nodes return a loss here too
      self.children.all? { |child| child.losing_node?(evaluator) } # only return true if all of these are true, in which case it is indeed a recursively losing node, otherwise return false because there's at least one winning move
    else # if it's opponent's turn, as long as one child node returns a loss it's a losing node because the opponent will force us to lose
      self.children.any? { |child| child.losing_node?(evaluator) } # if any children lose for this given mark it's a loss so return true, otherwise false
    end
  end

  def winning_node?(evaluator)
    return true if @board.over? && @board.winner == evaluator
    return false if @board.over? && @board.winner != evaluator
    if @next_mover_mark == evaluator
      self.children.any? { |child| child.winning_node?(evaluator) }
    else
      self.children.all? { |child| child.winning_node?(evaluator) }
    end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  # ahh by dupes they mean don't have the board have the same object ID but a different one.
  # killed it awesome woohoo hehe
  def children
    @next_mover_mark == :x ? (new_mover_mark = :o) : (new_mover_mark = :x) # if the next mover mark is :x then turn it to :o otherwise if it's :o then turn it to :x
    child_nodes = Array.new
    @board.rows.each_with_index do |row, row_i|
      row.each_with_index do |col, col_i|
        if col == nil # if the position is empty
          new_board = @board.dup
          new_board[[row_i, col_i]] = @next_mover_mark
          child_nodes << TicTacToeNode.new(new_board, new_mover_mark, [row_i, col_i])
        end
      end
    end
    child_nodes
  end

end
