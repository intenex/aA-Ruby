# To help us find paths, we will build a move tree. The values in the tree will be positions. A node is a child of another node if you can move from the parent position directly to the child position. The root node of the tree should be the knight's starting position. You will want to build on your PolyTreeNode work, using PolyTreeNode instances to represent each position.
# love it actually very straightforward this should definitely be doable can't wait

require_relative 'polytreenode'

class KnightPathFinder # oh fantastic this is from chess love it
    def initialize(pos)
        @pos = pos
        @considered_positions = [pos]
        @root_node = PolyTreeNode.new(pos)
        @move_tree = build_move_tree
    end

    # all valid moves for a knight are 1 displacement vertically or horizontally and 2 in the other direction, 8 total possible moves
    def self.valid_moves(pos)
        row, col = pos
        possible_moves = Array.new
        pos_displacements = [[-1, -2], [-1, 2], [1, -2], [1, 2], [-2, -1], [2, -1], [-2, 1], [2, 1]]
        pos_displacements.each do |displacement|
            x, y = displacement
            if row+x >= 0 && row+x < 8 && col+y >= 0 && col+y <8
                possible_moves << [row+x, col+y]
            end
        end
        possible_moves
    end

    # super smart on the array to iterate over with the displacements damn Alan is good
    # possible_moves << [row-1, col-2] if row-1 >= 0 && col-2 >= 0
    # possible_moves << [row-1, col+2] if row-1 >= 0 && col+2 < 8
    # possible_moves << [row+1, col-2] if row+1 < 8 && col-2 >= 0
    # possible_moves << [row+1, col+2] if row+1 < 8 && col+2 < 8
    # possible_moves << [row-2, col-1] if row-2 >= 0 && col-1 >= 0
    # possible_moves << [row+2, col-1] if row+2 < 8 && col-1 >= 0
    # possible_moves << [row-2, col+1] if row-2 >= 0 && col+1 < 8
    # possible_moves << [row+2, col+1] if row+2 < 8 && col+1 >= 8

    def new_move_positions(pos)

    end

    def build_move_tree
    end

end