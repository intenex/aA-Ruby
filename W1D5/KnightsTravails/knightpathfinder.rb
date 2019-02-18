# To help us find paths, we will build a move tree. The values in the tree will be positions. A node is a child of another node if you can move from the parent position directly to the child position. The root node of the tree should be the knight's starting position. You will want to build on your PolyTreeNode work, using PolyTreeNode instances to represent each position.
# love it actually very straightforward this should definitely be doable can't wait

require_relative 'polytreenode'

class KnightPathFinder # oh fantastic this is from chess love it
    def initialize(pos)
        @pos = pos
        @considered_positions = Array.new
        @root_node = PolyTreeNode
    end

    def self.valid_moves(pos)
    end

    def new_move_positions(pos)
    end
end