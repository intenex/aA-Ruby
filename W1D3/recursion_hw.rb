# 1. Read each problem statement to make sure you fully understand the problem
# 2. Identify the base case(s)
# 3. Determine the inductive step (the thing to do in each run-through on the last step --> basically everything except calling the method(step-1))
# 4. Write the function
# 5. Run the provided test cases to verify you have a working solution

# as you learn recursion, it's super important that you break down each problem into these steps. Doing so will help you devise solutions and avoid stack overflow errors. Remember to use byebug if you encounter strange bugs or errors!

# wow these are trivial so far lmao way less hard than you've expected so far let's see what the projects are like I guess

# write a function sum_to(n) that uses recursiont o calculate the sum from 1 to n (inclusive fo n)
def sum_to(n)
    return 1 if n == 1 # again must do <= just in case some asshole runs your method with a number less than 1 lol
    return nil if n < 1
    n + sum_to(n-1)
end

# write a function add_numbers(nums_array) that takes in an array of integers and returns the sum of those numbers. Write this method recursively.
def add_numbers(nums_array)
    return nums_array[0] if nums_array.length == 1
    return nil if nums_array.length == 0
    nums_array[0] + add_numbers(nums_array[1..-1])
end

# trivial so far did the above in 6 minutes or so

# flawless in 12 minutes so far including looking up the Gamma function and going to the bathroom lol
# Write a method that will solve Gamma Function recursively. The Gamma Function is defined Γ(n) = (n-1)! Gamma n is n-1 factorial lol fascinating, weird literally just factorial shifted down one lol
def gamma_fnc(n)
    return 1 if n == 1 # becuase (0)! is actually 1 strangely lol. Don't need to do if n == 2 because the same shit will happen no need to be redundant since 1 * anything is just 1 so one more redundant method call is fine
    return nil if n <= 0
    (n-1) * gamma_fnc(n-1)
end

# works flawlessly on the first try love it flavors[1..-1] will return an empty array if there are no actual indexes there, won't return an error, so great
# Write a function ice_cream_shop(flavors, favorite) that takes in an array of ice cream flavors available at the ice cream shop, as well as the user's favorite ice cream flavor. Recursively find out whether or not the shop offers their favorite flavor.
def ice_cream_shop(flavors, favorite)
    return false if flavors == [] # if flavors is an empty array then return false, base case, love it, good problem for sure, so great
    flavors[0] == favorite || ice_cream_shop(flavors[1..-1], favorite) # return true if either of these are true, either the flavor is found in this first index or in every other index until this thing hits rock bottom in flavors, in which case return false all the way up
end

# done in 19 minutes all in fucking love it lmao so great such trivial problems though truly nuts
def reverse(string) # trivial we've already done this in the lecture videos love it lol
    return string if string.length <= 1
    reverse(string[1..-1]) + string[0]
end