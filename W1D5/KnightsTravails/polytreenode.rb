class PolyTreeNode
    attr_reader :parent, :value, :children
    def initialize(value)
        @value = value
        @parent = nil
        @children = Array.new
    end

    def parent=(node) # ooh this sets the parent for a given node right lol so if you run this as node2.parent = node1, it should set the @parent node for node2 to node1 and set node1.children to self, aka node2, as long as that hasn't been added before already
        @parent.children.delete(self) if @parent != nil # if there is already a parent, remove this node from the old parent's children list
        @parent = node
        @parent.children << self if @parent != nil && !@parent.children.include?(self) # weird that @parent.children works without an setter method for it hmm I guess you're not reassigning you're shoveling into it? --> Holy fuck you tested this in depth and you are 100% correct that was an insane catch and so good that you actually dove into it instead of just being like 'hmm weird' and then just move on without investigating like everyone else seems to do -_-. Never take any behavior for granted and always investigate everything they are the greatest learning opportunities never could have expected this but it's so true and insane
    end

    def add_child(child_node); child_node.parent=(self) end

    def remove_child(child_node)
        child_node.parent == self ? child_node.parent=(nil) : raise # if the child_node is indeed a child of the current node then reset its parent to nil otherwise raise an exception
    end

    # killed it on your first shot without even referencing the lecture material so grea
    def dfs(target_value)
        return self if self.value == target_value # if the value is found, return the value
        @children.each do |child| # amazing yeah this search does just go all the way down super fast really incredible that you see that happen with the nested enumerator
            node = child.dfs(target_value) # this captures the value of each child, which returns the node that was found up the stack of children if its in the subtree with root being that given child node, or the whole thing returns nil if the thing isn't to be found anywhere so great
            return node if !node.nil? # right love it you totally just did this right lol
        end
        nil
    end

    # boom worked great love it
    def bfs(target_value) # wait they just tell you what to do that's nice lmao
        queue = [self] #FIFO --> first start with the current self value and check that
        while !queue.empty? # then run this until the queue is empty
            queue.each do |node| # iterate over every node in the queue in order
                return node if node.value == target_value # return the node if it is the target we are searching for
                queue += node.children # if it isn't, then add all its children to the queue to search later, to the *end* of the line, so every current sibling of the current node is searched before any of the children are searched in this enumerator as BFS is supposed to do
                queue.shift # remove the element that was just checked
            end
        end
        nil # if nothing in the array returned the value, then end this by returning nil
    end

end