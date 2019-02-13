#Problem 1: 

# literally so easy lol so strange how out of order all of these are in difficulty lol
def sum_recur(array)
    return 0 if array.length == 0
    array[0] + sum_recur(array[1..-1])
end

#Problem 2: 

# literally another minute or so so easy so nuts
def includes?(array, target)
    return false if array.length == 0 # base case, if the array is empty, then the value was not found and return false all the way up all the recursive method calls and stack frames
    return true if array[0] == target
    return includes?(array[1..-1], target) # return the result of all the recursive calls on each progressively smaller array until either the target is found in which case this returns true all the way up or it isn't and it returns false all the way up love it
end

# Problem 3: 

# also in like 2 minutes so easy literally less than 8 minutes so far the time estimates are so hilariously off for thse problems lol and you're also just doing well now can't wait to keep going ahead and catch up then push further ahead for sure
def num_occur(array, target)
    return 0 if array.length == 0 # base case, stop recursively calling and return zero if the array is empty
    increment = 0
    increment = 1 if array[0] == target # if the target matches the first element in the array, add one to the ultimate return count, otherwise add 0
    increment + num_occur(array[1..-1], target) # add the current increment to all the increments of the target in the array of n-1 size, removing the first index that you've checked against target to see if it matches already each time until the array is empty
end

# Problem 4: 

# also in a minute nuts
def add_to_twelve?(array)
    return false if array.length <= 1 # if there's only one element left, every adjacent element has already been checked and you should return false now otherwise you'll get an error checking array[1] because there is only one element in the array and no array[1] in the next line
    return true if array[0] + array[1] == 12
    return add_to_twelve?(array[1..-1])
end

# Problem 5: 

# turned out to be very simple but you got distracted for a bit on this one so ended up finishing the whole problem set in 28 minutes instead of like 15 had you really just busted through all of these when well rested, totally nuts how trivial they all are o.o. Get insanely good at recursion and it'll pay huge dividends for sure, love it so much. Always see where you can recurse because of course it comes less naturally right now than something iterative, so practice it more. It's like  weak left hand to your dominant right hand when you have the choice of doing any given task that requires one hand, basically. You have to actively choose to train your left hand.
# iterate over each element of the array, return false if any element to the right of the first element in each recursively smaller array is larger than the first element in that array until you've gone through all the elements
def sorted?(array)
    return true if array.length == 0
    array[1..-1].each do |num|
        return false if array[0] > num # if the first element is larger than any following element, then the array is not sorted so return false
    end
    sorted?(array[1..-1]) # if it hasn't returned false yet, check incrementally each next piece of the array and see if the next first element of the array n-1 elements is smaller than everything after it too --> return whatever this ends up returning. If it never finds a false value before the array size becomes 0, then it will return true as the array is indeed sorted, otherwise false, so great love it boom done
end

# Problem 6: 

# literally in a minute too lol
def reverse(string)
    return '' if string == '' # base case nothing more to add
    reverse(string[1..-1]) + string[0]
end
