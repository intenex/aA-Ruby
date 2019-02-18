def dfs(root, target) # for n-ary trees not binary if binary you'd need return root if root.nil?
    return root if root.val == target # if root is an object instance of say an arbitrary Node class with some attribute variable 'val'
    root.children.each do |child| # not assuming a binary tree, infinitely many possible children nodes
        search_result = dfs(child, target)
        return search_result unless search_result.nil? # wow amazing method .nil? so great --> this would return nil if nothing is returned
    end
    nil
end

# Now that you have the base cases, you just have to ask if the left subtree and the right subtree in a binary tree if they have the value

def method_A(&prc)
    helper_method_a(&prc)
end

def method_B(&prc)
    helper_method_b(prc)
end

def helper_method_a(&prc)
    random_arr = [1,2,3,4,5]
    prc.call(random_arr)
end

def helper_method_b(prc)
    random_arr = [1,2,3,4,5]
    prc.call(random_arr)
end



