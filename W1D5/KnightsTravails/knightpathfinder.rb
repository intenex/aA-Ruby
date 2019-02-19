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

    def inspect
        @move_tree.length # amazing it really does equal 64 perfect so great then it must really be going through every single move wow
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

    def new_move_positions(pos)
        possible_moves = KnightPathFinder.valid_moves(pos)
        possible_moves.select do |move| # shovels into the @considered_positions array all the moves not already considered then returns true for those moves so that they're returned by the select
            if !@considered_positions.include?(move)
                @considered_positions << move
                true
            else
                false
            end
        end
    end

    def build_move_tree # wow amazing this is just a BFS implementation totally nuts, just with no search results
        queue = [@root_node] # love it these all should be PolyTreeNode object instances
        all_nodes = Array.new
        while !queue.empty?
            current_node = queue.shift
            new_moves = self.new_move_positions(current_node.value) # ah right this keeps all the positions period on the board a total of 64 because this path class keeps track of all the positions nicely done the way they structure this awesome
            new_moves.each do |move|
                new_node = PolyTreeNode.new(move)
                new_node.parent = current_node
                queue << new_node
            end
            all_nodes << current_node
        end
        all_nodes
    end

    def find_path(end_pos)
        end_node = @root_node.dfs(end_pos) # doesn't matter if you do dfs or bfs because there's no way to know if the end_pos will be near the top with a short path or near the bottom with a long path so both are equally likely to take the same amount of time
        trace_path_back(end_node)
    end

    # wow works flawlessly literally done in like 5 minutes on this estimated 4 hour section nuts lol the other sections are actually shorter so great let's keep pushing
    def trace_path_back(end_node) # love it just like word chains find the end target word/node/position then trace back up with it so great
        path_arr = [end_node.value] # start the path with the end value
        until end_node == @root_node # until the last node is equal to the start root node, keep running this - could also make this nil
            end_node = end_node.parent # set the next node in the path to the parent of the current node
            path_arr.unshift(end_node.value) # add the value of this parent node to the beginning of the path array
        end
        path_arr
    end
end