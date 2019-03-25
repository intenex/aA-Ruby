require 'byebug'

# Given a list of integers find the smallest number in the list

# First, write a function that compares each element to every other element of the list. Return the element if all other elements in the array are larger.
# O(n^2) since nested loop here
def my_min_1(arr)
    arr.each { |n1| return n1 if arr.all? { |n2| n1 <= n2 } }
end

# O(n) here since you iterate through the entire array once
# identical to the homework lol
def my_min_2(arr)
    min_num = arr[0]
    arr.each { |num| min_num = num if num < min_num }
    min_num
end

# largest continuous sub-sum
# find all the subsums then find the largest, two part problem just like above, love solving these
# fucking love this free recursive practice in Big-O, which is great since it's all about algorithms
# subsets sum is one of those classic Big-O questions I think look into it more for sure

# ah yes the iterative approach to this is just nested loops which is rather easy
# these problems are not so hard you're just really tired today lol never be tired basically going forward is the key
# you do have to finish these today so let's just do it and get it done

# base case = [], [1] --> if length 1 or length 0, return
# inductive step - [1, 2] --> [1], [2], [1, 2]
# next inductive step [1, 2, 3]
# damn need a base case [[], [1]] because .map doesn't work on an empty array ah well
# this does it recursively not with nested loops and this actually isn't even useful because this doesn't just get contiguous subsets this gets every subset lol oh well good practice
def not_useful_but_perfect_recursive_subsets_practice(arr) # awesome to get to do all this without flatten and really grok it more now clearly love it can't wait to keep going through all of this and really understand it and be able to explain it
    return [[], arr] if arr.length == 1
    return [] if arr.length == 0
    last_ele = arr.pop
    last_subset = subsets(arr)
    current_subset = last_subset.map { |subset| subset + [last_ele] }
    last_subset + current_subset # finally it works this is pretty good just needed the base case for arr.length 1 sad
end # nvm exactly how you did it last time lol the ones you had to flatten were fibonacci and permutations and make better change so spend more time on those later too for sure love all this shit

def largest_contiguous_subsum_1(arr)
    contiguous_subsets = contiguous_subsets(arr)
    contiguous_subsets.max_by { |subset| subset.sum }
end

def contiguous_subsets(arr)
    all_subsets = Array.new
    arr.each_index do |i1|
        all_subsets << [arr[i1]]
        arr.each_index do |i2|
            all_subsets << arr[i1..i2] if i2 > i1 # yeah ranges are the way to go awesome
        end
    end
    all_subsets
end

