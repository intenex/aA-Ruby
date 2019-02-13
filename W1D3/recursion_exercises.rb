# wtf doesn't work fuck it lol though you *should* figure this out later to make things easier on yourself for sure but you didn't get a single stack overflow error on the last few problems lol so amazing really getting recursion love it so much
# MAX_STACK_SIZE = 200
# tracer = proc do |event|
# 	if event == ‘call’ && caller_locations.length > MAX_STACK_SIZE
# 		fail “Probable Stack Overflow”
# 	end
# end
# set_trace_func(tracer)

# Learning Goals
# Know how to reason about recursive programs
# Be able to write a base case for a recursive method
# Be able to write the inductive step for a recursive method
# Be able to explain the benefits of writing a method recursively vs. iteratively
# Be able to trace a recursive method and figure out how many recursive steps it will take
# Know how to write recursive sorting and searching algorithms

# Warmup

# boom 3 minutes done you're so good at this stuff now lol took about a minute to actually write this one you really do understand recursion well so lucky not actually that much material every day just lots of projects love it you can definitely keep pace with this and do it, so let's do it :). CS50 was every few days or something and you still crushed that and it really did cover a lot of material, you can definitely crush this can't wait
def range(s, e) # don't write end as a variable lmao you've learned that mistake lol
    return [s] if e - s == 1 # to make this exclusive have the base case end when s is 1 less than e
    [s] + range(s+1, e)
end

def sum_array_iterative(arr) # yep it is lmao
    arr.inject { |acc, num| acc + num } # I think this is how it works lmao
end

# all done in 8 minutes fuck yeah broski warmup complete!
def sum_array_recursive(arr)
    return arr[0] if arr.length == 1
    return nil if arr == []
    arr[0] + sum_array_recursive(arr[1..-1])
end

# works flawlessly, 10 minutes in wow
def exponent_1(b, n) # n is the exponent right. Well that was simple lol
    return 1 if n <= 0
    b * exponent_1(b, n-1)
end

# wow amazing this works though you don't really get why lmao, you're squaring the results
def exponent_2(b, n)
    return 1 if n <= 0
    return b if n == 1
    if n % 2 == 0 # if even
        exponent_2(b, n / 2) * exponent_2(b, n / 2) # ** is Ruby's operator for exponentiation so basically this is the result of exponent_2(b, n/2) to the power of 2, so multiplying it against itself once basically, or squaring it, beautiful, but actually they want you to just square it by multiplying it with itself love it lol
    else # if odd
        b * (exponent_2(b, (n-1) / 2) * exponent_2(b, (n-1) / 2))
    end
end

# Write out what happens with base 0 and power 0 as inputs (should be easy). e.g., if you had run exp(0,0).
# ** The second (first you understand very well so no need to look into it more) just returns 1 since power (n) is 0 and that's the hardcoded return value
# Write out what happens for base 0 and power 1. e.g., if you had run exp(0,1).
# ** Returns 0 because that's hardcoded too for n == 1
# Write out what happens for base 1 and power 0.
# ** Returns 1 because hardcoded for this
# Write out what happens for base 1 and power 1.
# ** Returns 1 because hardcoded
# Write out what happens for base 1 and power 2.
# ** Returns 1 because power is even, so it does this on exponent(1, 1) * exponent(1, 1) which returns 1 hardcoded for each of those methods exponent(1, 1)
# Write out what happens for base 2 and power 0.
# ** Returns 1 because hardcoded
# Write out what happens for base 2 and power 1.
# ** Returns 2 because hardcoded
# Write out what happens for base 2 and power 2.
# ** Returns 4 because power is even, so exponent_2(2, 1) * exponent_2(2, 1) is hardcoded to return b for both so that's 2 * 2 so that's 4

# oh interesting for evens, b^4 == b^2 * b^2 that's amazing and also true, that's how exponents work, that's right, that's how this method works, 2^2 == 4 and 2^4 == 16 so 4*4 == 16
# and if odd, you can simulate the same thing by doing the incremental step, so for 2^5 you can just do 2 * 2^(4/2) * 2^(4/2) so amazing so just do base * base^(n-1) * base^(n-1) to get the right solution for every odd number totally understand it now really glad you took the time to understand it too so fucking great love it exactly how exponents work so glad you're getting back into refreshing your basic math now so great

# omg the #dup method doens't make a deep copy wtf
# robot_parts = [
#   ["nuts", "bolts", "washers"],
#   ["capacitors", "resistors", "inductors"]
# ]

# robot_parts_copy = robot_parts.dup

# shouldn't modify robot_parts
# robot_parts_copy[1] << "LEDs"
# but it does
# robot_parts[1] # => ["capacitors", "resistors", "inductors", "LEDs"]

# omfg it doesn't create new objects for each of the arrays, what the fuck, it just copies the array itself and makes a new object for that but just copies the pointers to the objects inside the array lmao so nuts lol
# these people really know what they're doing super impressive love it
# fucking love this stuff so worth getting stuck here late to get through all this so well love it

# Sometimes you want a shallow dup and sometimes you want a deep dup. Ruby keeps things simple by giving you shallow dup, and letting you write deep dup yourself.
# lmfao dying at this humor lol

# you are totally going to be up until the morning train lmao this is such perfect motivation to keep working and get this done lmao and it's 24/7 here for food lmao so amazing just three more hours, trivial, love it

# okay start from the most basic case to figure this out
# if you have an array with no sub arrays, just duplicate that and you're done
# if you have an array with one sub array, duplicate the sub array and then return the top thing
# fuckk you got a stack overflow!! lol lmao trivial issue fixed it

# fuck yeah think this works! Time to move on fucking love this shit so lucky to be catching up! Slowly but surely :). Object IDs are all different, love it
def deep_dup(arr) # deep dup over every aspect of the array love it
    return arr if !arr.is_a?(Array) # if it's not an array, just return it as is, you're only going to duplicate every internal array, love it, this is how you know you've gone all the way deep love it
    return arr.dup if arr.all? { |ele| !ele.is_a?(Array) } # if all elements are not arrays, duplicate this array and return that duplicate
    # if it's an array and there are still subarrays, then recurse it
    # weird that they say to use the normal .each .map was def the right thing hmm
    arr.map do |ele| # this should return the new array with all the elements modified by the block love it
        if !ele.is_a?(Array) # return the element as is if it's not an array
            ele
        else
            deep_dup(ele) # otherwise deep_dup the subarray until nothing else to deep_dup love it # lmao that was the issue you did deep_dup(arr) instead of deep_dup(ele) love it lol
        end
    end
end

# test_array = [1, [2, 3], [4, [5, 6]]]

# n = 1 == 1
# n = 2 == 1, 1
# n = 3 == 1, 1, 2
# ah this code gets the last fibonacci number perfectly, love it, now just need to add it all together

# fuck this returning array thing is killing you lol just move on and come back to it fucking getting stuck at one place sucks such hard balls lmao lose so much time on it
def fibonacci_recursive(n)
    return [1, 1] if n == 2
    return [1] if n == 1
    return nil if n <= 0
    # lmao so trivial to figure out LOL just needed to find the inductive step and also solve the adding sub arrays problegm with a trivial flatten, that was literally it. So easy now that you think about it - literally just need to add the entire sequence of the fibonacci of (n-1) and add the last number in the sequence, which is to add the last two elements of the last fibonacci sequence of (n-1) so literally easy if you just talk it out took you forever LOL. Really proud of yourself for not giving up and sticking with it and figuring it out so elegantly now though lol...almost the first time that you've taken so long on such a simple thing, which should show you 100% the futility of working when you're not well rested, so always be well rested first and foremost and keep a great sleep routine always, go to sleep on time today and start over from scratch tomorrow, love it, so lucky
    ([fibonacci_recursive(n-1)] + ([fibonacci_recursive(n-1)[-1] + fibonacci_recursive(n-1)[-2]])).flatten # wow this actually worked to solve the issue lol can now actually return arrays now just need to figure out how to add them together
end

# it has to return one extra array value every time and somehow add it all together that's kinda nuts

# def fibonacci_recursive(n)
#     return 1 if n <= 2
#     arr = []
#     [fibonacci_recursive(n-1)[0] + fibonacci_recursive(n-2)[0]] + ['random'] # wow this actually worked to solve the issue lol can now actually return arrays now just need to figure out how to add them together
# end

# Wait instead you want to add the last element of the array like [-1]

# def f_r(n)
#     return 1 if n <= 2
#     [f_r(n-1)] + [f_r(n-1)[-1] + f_r(n-1)[-2]] # this would add the last two elements together of the array to return the current value to add to the array before
# end

# that is def the right fibonacci in f_r(n-1) is the whole fr sequence before the inductive step
# the base case is index <= 2 or so, and then the inductive step is adding f_r(n-1)[-1] + f_r(n-1)[-2] the second step


# how to recursively return an array you need the whole rest of the array in the previous step before the inductive step, the inductive step can only add one element to the array but it needs to get the rest some how
# so basically the first step of the array at n should return 1
# the second step should return [1, 1], so you need a way to do that, how do you do that?
# the third step should return [1, 1, 2], so how do we get there? Let's just focus on that for now
# [2] + [fibonacci_recursive(n-1)]
# then n - 1 would return 1 so that would just return 1

# oh wait you've already written these lol wtf
# well that was easy lol sigh recursive hard bc you need more sleep and not doing it right get more sleep and do it right tomorrow sigh
def fibonacci_iterative(n)
    fib_arr = [1, 1]
    (2...n).each do |i|
        fib_arr << fib_arr[i-1] + fib_arr[i-2]
    end
    fib_arr
end

# omg finally works flawlessly for every case lol
def bsearch(arr, target)
    return nil if arr == []
    return 0 if arr[0] == target && arr.length == 1 # such that it doesn't return nil if actually found but do need it to return nil if not found
    return nil if arr.length == 1
    if target == arr[arr.length/2] # the good news is if this is length 1 it will return the index 0 which is the last index which is dope
        return arr.length/2
    elsif target < arr[arr.length/2]
        bsearch(arr[0...(arr.length/2)], target)
    else
        if bsearch(arr[(arr.length/2)...arr.length], target) # if this exists and isn't nil
            arr.length/2 + bsearch(arr[(arr.length/2)...arr.length], target) # holy fuck this code actually worked wtf lmao just added the length of the index that the thing would start on if you didn't reomve all those elements and it...just worked too tired to really read too much into it but lucky that it worked, I guess lol
        else # otherwise it was nil in the end so don't return arr.length/2 lol just return nil
            nil
        end
    end
end

# omg you understand it so well here so great you get how this works man getting some sleep is great for sure take it easy until you get it then push through love it
# jesus you cleaned this up so much lmao god being awake is so insane just always be awake never write code when tired you'll think you're bad at it but really you were just tired omg so good so grateful coming together so well make sure you really understand this stuff glad you're spending extra time in this section that's hard
def merge_sort(arr)
    return arr if arr.length <= 1 # once you establish the base case, the second step is seeing how this works for the base_case + 1 --> start there and work incrementally up, then it works for every case
    first_half = merge_sort(arr.shift(arr.length/2)) # cut away the first half the array with #shift (which will cut out arr.length/2 # of elements of the array) and run merge_sort on that half
    second_half = merge_sort(arr) # run #merge_sort on the rest of the array that wasn't split away aka the second half
    merge(first_half, second_half)
end

# You definitely are getting better at this practice really is the only thing that matters once you actually looked into seeing each step of the process was so easy to figure it out love it
# finally cleaned up this looks good lmfao you can be proud of this code love it
def merge(arr1, arr2)
    sorted_arr = Array.new
    while arr1.length > 0 && arr2.length > 0 # until one of them is 0 then add the remainder of whichever array is remaining to the end of the sorted_arr
        if arr1[0] <= arr2[0]
            sorted_arr << arr1.shift # removes the whichever first element 
        else
            sorted_arr << arr2.shift
        end
    end
    sorted_arr += arr1 if arr1.length > 0 # must use += to add more than one element can't shovel a whole array into another array
    sorted_arr += arr2 if arr2.length > 0
    sorted_arr
end

# your horrific old pre-refactor merge_sort code lmao that was technically working just fine but soooo redundant and horrifically written lol this is what happens if you're sleep deprived just don't do it best lesson you've learned from this only code when not sleep deprived and well rested for sure that was worth losing the few days to truly learn and to be back on schedule now so lucky and grateful for that now let's get back on track :)
# # omg you understand it so well here so great you get how this works man getting some sleep is great for sure take it easy until you get it then push through love it
# def merge_sort(arr)
#     if arr.length == 1 # once you establish the base case, the second step is seeing how this works for the base_case + 1 --> start there and work incrementally up, then it works for every case
#         return arr
#     elsif arr.length == 0 # should happen if odd number of elements
#         return []
#     else
#         first_half = arr[0...arr.length/2] # must be exclusive since the next one is necessarily inclusive of the starting array
#         second_half = arr[arr.length/2..-1]
#         divided_first_half = merge_sort(first_half)
#         divided_second_half = merge_sort(second_half)
#     end
#     if divided_first_half != nil && divided_second_half != nil
#         return merge(divided_first_half, divided_second_half)
#     elsif divided_first_half == nil
#         return divided_second_half
#     elsif divided_second_half == nil
#         return divided_first_half
#     end
# end

# # amazing that last print shows the error in your logic lol you're def just too tired to do this you need better brain capacity for thinking through cases
# # don't factor out code when you're confused at first just write it all out then refactor each bit one at a time fair strategy when you're tired for sure
# def merge(arr1, arr2)
#     return_arr = Array.new
#     if arr1 == []
#         return arr2[0]
#     elsif arr2 == []
#         return arr1[0]
#     end
#     while arr1.length > 0 && arr2.length > 0
#         if arr1[0] <= arr2[0] || arr2 == []
#             return_arr << arr1.shift # removes the whichever first element 
#         else
#             return_arr << arr2.shift
#         end
#     end
#     return_arr += arr1 if arr1.length > 0
#     return_arr += arr2 if arr2.length > 0
#     return_arr
# end

# the hints are also amazing lmao always read them this is one of the harder days love it past this you're just good
# always just start from the simplest base case and the inductive step and flesh it out from there love it so much
# really getting somewhere now just make this code work right love it
# so amazing works flawlessly lol
class Array # monkey patching Array to include subsets love it
    def subsets
        if self == [1] # the two base cases
            return [[], [1]]
        elsif self == []
            return [[]]
        end
        last_ele_subset = Array.new
        self[0...-1].subsets.each do |ele| # from the hint - basically you just want to return the n-1 subset array + the last element in the n array added to every element of the n-1 subset array, so just run a .each enumerator on the n-1 subset array and add the last element self[-1] to of the current n array to each element of that array, then return the n-1 array with the subsets method run on it + the extra elements from adding the last element of the n array to the n-1 subset array amazing hint love it
            last_ele_subset << (ele << self[-1])
        end
        self[0...-1].subsets + last_ele_subset # wow this actually works like you expect it to that's pretty amazing lol
    end
end

# important things to note - there are n! factorials for an array of n length
# so 3 * 2 * 1 = 6 permutations for an array with 3 elements that seems important think about it more lol
# fascinating - what is the base case for this? And what is the inductive step? This is such an interesting problem love that they keep giving these 
# okay so first see how this works for one element
# it definitely has to do with factorials you should just do the factorial of array.length-1 * array.length times the permutation thing hmm

# right the reason it's factorial is because the first element in the array can be any of the 3 numbers
# the second can be 2
# and the last can be one

# so [1, 2, 3]
# [2, 1, 3]
# [3, 1, 2]
# [1, 3, 2]
# [2, 3, 1]
# [3, 2, 1]

# [1, 2, 3]
# [1, 3, 2]
# [2, 1, 3]
# [2, 3, 1]
# [3, 1, 2]
# [3, 2, 1]

# oh my god it's so simple lmao literally every single number just goes in every single element place twice
# 2 1s for the first, 2 2s, 2 3s, and same for each element
# why is that and what does it mean

# [1, 2]
# [2, 1]

# because every addition n element you add allows you to put n * # of possibilities before together
# that's going to require a lot more brain power to figure out man wow

# okay that's huge your natural conclusive order doing this now is the same as what they get that's nuts obviously means something
# what does it mean?
# such good problem solving practice skills love it so much this shit is so great you can do this forever until you get so good at it this is all you want to do in your life anyway is play with these things and now you have a good justification for playing with it as much as you want that's so insane lol

# first iterate over all the possible first elements in the array
# then iterate over the two possible switches in the second element of the array
# then do the last element of the array switch left. Because once you've put the other two in place there's only one card left to choose for the last blank love it

# oh my god you're figuring it out start from 1, then 2, then go on from there in array length
# oh god you need to return additional permutations by doing array length - 1 obviously you have to holy fuck it's coming together this shit is mind blowing truly is
# omg you've got it working for cases 2 length and 1 length that's insane

# shit this is actually getting a lot of the good answers that's nuts
# the notation is actually working and everything cannot believe you actually built this and you figured out the base case always start from that and it's all about length of course only thing that could change love it and about adding one piece on to the last so great that you discovered that before with the subsets problem
# def permutations_recursive(array)
#     return array if array.length <= 1 # this is obviously a base case because there is only one permutation if an array equals 1
#     last_permutation = permutations_recursive(array[1..-1])
#     new_permutes = Array.new
#     last_permutation.each do |permute|
#         current_permute = ([permute] + [array[0]]).flatten
#         new_permutes += [current_permute]
#     end
#     [array] + new_permutes
# end

# this requires crazy deep fundamental understanding of how permutations work and actually having discovered the pattern and why it's truly factorial arrays - the pattern did not strike out to you immediately at glancing at the problem be it because of sleep deprivation or something else - you're just beyond glad that you figured it out now and that it's almost certain to you that you'll solve it now, so crazy lucky, you will solve everything with persistence, don't be discouraged that it is taking time, just push through it and crush it
# you deeply understand how every permutation works, so lucky to have gotten to that step to figure this out, it really was a prerequisite for this solution (and really for any solution, you just have to understand how the thing works deeply and fundamentally before you can implement it, love it)
# when you write it correctly and you know *exactly* what you're doing you don't even need to walk through each step for every n number incrementally, you just know it'll work and it will just work
def permutations(array)
    return array if array.length <= 1 # base case, return the array if the length is 1 or 0, because there is no permutation there
    removed_element = array[0] # extract the first element to re-insert later - could also do unshift but this works fine. Don't even need this line, could just put this directly into the enumerators below, but this makes it more readable likely
    base_permutes = permutations(array[1..-1]) # get every permutation of array.length-1, the n-1 array, love that you figured that out that that's how to decrement to length 1, which is the base case --> whatever value the base case is measuring, that's what you need to decrement in the inductive step to get the recursion to work, love that so much that you're really picking up more insights from doing this right each time now, you can actually explain this to your partner in pair programming now, love it
    total_permutes = Array.new
    (0...array.length).each do |i| # this is how you multiply n, with n being the length of the array, by (n-1)! --> create n copies of the n-1 permutation array, which has (n-1)! elements. Walk through every one of the n-1 permutations n times and add the removed element (n-1)! times to each position in the n-1 permutation array --> in front of every other element, at index 1, at index 2, all the way to the last index. Love it so much. ||| The reason that there are 6 positions for each 4th element for each position is because the rest of the elements are an array of length 3, hence they can all be arranged in 6 unique ways as per an array of length 3, so obviously if you put a placeholder variable that stays the same ahead of that arrangement of 3, you can make 6 unique arrays. This holds true for all the 4 elements in the array - if you keep one of them constant, the other 3 can be permuted in 6 different ways just like an array of length 3. Fucking incredible, that’s the key insight. Holy fucking shit lol. Love that you literally just figured this out on your own sitting with it long enough so proud of yourself can’t wait to code this up now jesus life is good 
        base_permutes.each { |permute| total_permutes << [permute].flatten.insert(i, removed_element) } # flatten really is a lifesaver of a method lol learned that from fibonacci and learned this adding thing from the subsets problem above, which was a prime example of something you didn't truly understand to the deep depth you understand this one, but just managed to eke out with a little luck at the barest cusp of your full understanding - and then because you got it working with a little brute force and trial and error after you started to have the first inklings of the right path, you never truly understood in all its fundamental root glory how the thing *really* worked and why it *really* worked like you do this this one.
    end
    total_permutes
end

# so trivial to write these iteratively damn recursion is so much harder for you to wrap your head around for now lol. Not that this one works particularly intelligently but it works lmao, literally just random chance here lmao
def permutations_iterative(array)
    total_permutes = factorial(array.length)
    permute_arr = Array.new
    while permute_arr.length < total_permutes
        shuffled_arr = array.shuffle # hilarious hack tbh def not the right way to do it lol
        permute_arr << shuffled_arr if !permute_arr.include?(shuffled_arr)
    end
    permute_arr
end

def factorial(num)
    return 1 if num == 1
    num * factorial(num-1)
end

# find the base case, see if you're getting better at this, let's actually get back into focus mode and move faster along :)
# wow this actually kind of works totally nuts lmao
# whew lucky solved a basic greedy_make_change in 12 minutes you can do this you just need to focus and got distracted the last few days but no more, push Ben, push. Let's get back in the game. You're well rested now, so let's make this happen.
# wow works perfectly now lol
# oh wait your method doesn't take as many coins as possible it just takes one of each lol so that's a good start already
def greedy_make_change(amount, change_types)
    change_types.each do |change|
        if amount - change >= 0
            return [change] + greedy_make_change(amount-change, change_types)
        end
    end # sometimes change just can't be made and that's okay too just do the best you can basically
    return [] # this is the base case, which is the case in which no change can be made, love it --> # need this return because otherwise if nothing is returned in the enumerator above, the change_types.each will just return change_types and append that to the end of your array like https://stackoverflow.com/questions/11596879/why-does-arrayeach-return-an-array-with-the-same-elements so glad to have actually understood this stuff and to get to understand how this all works
end

# oh amazing now you just want to keep track of each solution love it
# amazing you are definitely getting way better at this this is definitely coming together super proud of yourself

# maybe you can literally just ignore that last troublesome one that goes in reverse order and doesn't return the right value because it will always be longer than the right values lol so let's try now to just return the best answer
# def make_better_change(amount, change_types)
#     possible_solutions = Array.new
#     change_types.each do |change|
#         if amount - change >= 0
#             smaller_change_types = change_types.select do |num|
#                 num <= change
#             end
#             possible_solutions += [[change] + make_better_change(amount-change, smaller_change_types)]
#         end
#     end
#     # now you just want to find the shortest answer
#     answer_lengths = Hash.new
#     possible_solutions.each_with_index do |answer, index| # lmao crushed it by actually figuring out how this works love it you just want to flatten each answer afterwards so great
#         answer_lengths[index] = answer.flatten.length
#     end
#     best_solution_index = answer_lengths.key(answer_lengths.values.min_by { |length| length })
#     p possible_solutions[best_solution_index] if best_solution_index != nil
#     possible_solutions.map do |solution|
#         solution.flatten
#     end
# end

# omfg now it works fucking love it you did just have to do the smaller change types correctly fuck yes only use coins less than or equal to the current coin amazing not sure exactly why this works yet but it does so you're real close to the answer now
# okay it doesn't work perfectly but it does work as expected love it
# wow just follow the instructions and everything is easy lol
# omfg this works now you just need to figure out how to make it return the correct answer for everything holy fuck
# holy fuck it's returning the correct answer for everything now jesus literally just needed to follow their instructions step by step lol
# now go through and make sure you understand every line of this and then watch the video walkthroguh for sure fuck yes this is amazing
# yeah it's returning the right answer for everything you can think of that's so insanely cool really walk it through later
# so lucky people thought this one was hard and that people would get stuck the ones earlier were way harder but now you *really* understand the stuff and also they literally listed out each step so you really didn't need to think it through much so this was not bad lol. Can't wait to see what word chains is like then move on to the bonus recursion problems which shouldn't be that bad if you're looking at it right (really can't wait to get to the extra practice though, soooo proud of yourself for doing all these with no help on your own) git and the rest and see how all that is
def make_better_change(amount, change_types)
    possible_solutions = Array.new # save every single possible solution
    change_types.each do |change| # for each type of change, try subtracting the change from the amount and then try subtracting all the change types smaller than the amount you used on the amount --> AH the reason that this works is that you don't iterate over larger change types on the smaller amount, which leads to problems like what you saw with (15, [15, 10, 5]) where on the last enumeration, you start with 5, then you have 10 left, and then you run make_better_change(10, [15, 10, 5]), which returns two answers of course correctly, of [10], and [5, 5], which means your last answer is [5, 10, 5, 5], instead of [5, 5, 5] as you would expect since the correct method to have run was make_better_change(10, [5]), which would have returned [5, 5], giving you the correct last answer of [5, 5, 5], so that's why this thing does now work perfectly, fuck yes you understand it now too so you'er the luckiest person in the world love it you deserve to eat now so grateful and happy lol.
        if amount - change >= 0
            smaller_change_types = change_types.select { |num| num <= change } # only pass in to the recursive n-1 method call the change types that are smaller or equal to the current change type to avoid the error as seen above
            possible_solutions += [[change] + make_better_change(amount-change, smaller_change_types)] # add the current solution to all possible solutions - the current solution is the current change you found that works + the recursive make_better_change method called on amount-change with all the change types of the current change type or less, fucking *love* it so smart yeah of course if you had larger change types it would screw this up because it would keep calling those and then the children of those until your answers got crazy fucked towards the end as change became smaller but only using the same change type or smaller perfectly solves that issue so amazing would you have ever figured that out if they didn't literally tell you step by step what to do though lol that's the real question they went easy on you here for sure
        end
    end
    answer_lengths = Hash.new # now you just want to find the shortest answer, so we're going to create a hash that stores the array.length of all the various solutions, then pick the solution with the lowest length which is the answer of how to make change with the fewest pieces of change love it
    possible_solutions.each_with_index { |sol, i| answer_lengths[i] = sol.flatten.length } # iterate over all the possible solutions, and first flatten each solution because there are a bunch of internal subarrays for each stored solution because of how your method keeps adding recursive solution to itself, and then find the length of the current answer being iterated on, then store the length of that solution in the answer_lengths hash and have the key of the hash be the index of the solution in question
    best_solution_index = answer_lengths.key(answer_lengths.values.min_by { |length| length }) # find the best solution by iterating over all the values of the hash and selecting the smallest value, which equates to the smallest length of the solution array, which means the fewest pieces of change, and then run answer_lengths.key(length) on the value (length) you just got that's the smallest length to find the index position of the solution array that had the smallest length inside the possible_solutions parent array
    if best_solution_index != nil # if possible_solutions was [] meaning that the base case was hit and there was no change type you could subtract from amount and get a value above or equal to zero, then the answer_lengths hash will also be an empty hash because possible_solutions.each_with_index would have enumerated on nothing (an empty array), and consequently answer_lengths.value.min_by would have returned [] or nil (look into it more to see what .value evaluates to on an empty hash must be [] for .min_by to work, and then see what .min_by evaluates to when there's nothing to return, also possibly [], but maybe nil), and then of course answer_lengths.key(nil or []) returns nil because there is no key with a value of nil or [] in the empty answer_lengths hash, and so best_solution_index equals nil if the base case has been reached and there is no additional change that can be added to the given solution in question, and if that's true you definitely don't want to run possible_solutions[nil] because that will return an exception of course, so make sure best_solution_index doesn't equal nil
        possible_solutions[best_solution_index] 
    else
        [] # if the best_solution_index is nil, just return an empty array, this is the base case, there were no possible solutions found which means that there was no additional change that could be added to the amount in question that would keep the resultant remaining amount greater than or equal to zero, so return [] to make sure the method adds nothing further to the chain of the change that comprises the current solution in question and to be the base case that stops the recursion from continuing further and begins to return up the recursive stacks until the final answer is reached
    end
end

# fuck yes you completely understand this method now can't wait to keep going through it and see the walkthrough and really grok it all even more walk it back from the bottom up so grateful and lucky this works so well and your method looks quite elegant to me and does exactly the amount of work needed and no more I believe just about certainly in the same magnitude of the big O of the most optimal solution