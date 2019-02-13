# ### Factors
#
# Write a method `factors(num)` that returns an array containing all the
# factors of a given number.

# only works for positive numbers but does work that was easier than the problems above by far lol huh
def factors(num)
    factor_array = []
    (1..num).each { |n| factor_array << n if num % n == 0 }
    factor_array
end

# ### Bubble Sort
#
# http://en.wikipedia.org/wiki/bubble_sort
#
# Implement Bubble sort in a method, `Array#bubble_sort!`. Your method should
# modify the array so that it is in sorted order.
#
# > Bubble sort, sometimes incorrectly referred to as sinking sort, is a
# > simple sorting algorithm that works by repeatedly stepping through
# > the list to be sorted, comparing each pair of adjacent items and
# > swapping them if they are in the wrong order. The pass through the
# > list is repeated until no swaps are needed, which indicates that the
# > list is sorted. The algorithm gets its name from the way smaller
# > elements "bubble" to the top of the list. Because it only uses
# > comparisons to operate on elements, it is a comparison
# > sort. Although the algorithm is simple, most other algorithms are
# > more efficient for sorting large lists.
#
# Hint: Ruby has parallel assignment for easily swapping values:
# http://rubyquicktips.com/post/384502538/easily-swap-two-variables-values
#
# After writing `bubble_sort!`, write a `bubble_sort` that does the same
# but doesn't modify the original. Do this in two lines using `dup`.
#
# Finally, modify your `Array#bubble_sort!` method so that, instead of
# using `>` and `<` to compare elements, it takes a block to perform the
# comparison:
#
# ```ruby
# [1, 3, 5].bubble_sort! { |num1, num2| num1 <=> num2 } #sort ascending # wow that's cool the spaceship operator returns not true or false but 1, 0, or -1 depending on which side is greater or lesser than the other
# [1, 3, 5].bubble_sort! { |num1, num2| num2 <=> num1 } #sort descending
# ```
# # ah they expalin the spaceship operator and link literally the exact same stack overflow question love it. You can also define this <=> operator on your own classes wow love it so much to learn here just need to do it all to really get it all man once you really start building things then you'll be a real developer by then love it
# #### `#<=>` (the **spaceship** method) compares objects. `x.<=>(y)` returns
# `-1` if `x` is less than `y`. If `x` and `y` are equal, it returns `0`. If
# greater, `1`. For future reference, you can define `<=>` on your own classes.
#
# http://stackoverflow.com/questions/827649/what-is-the-ruby-spaceship-operator

class Array
    # sweet got it working in this shape love it
    def bubble_sort!(&prc)
        sorted = false
        while sorted != true
            sorted = true # ah just had to put this on top not at the bottom love it lol figured it out
            self.each_index do |i|
                if i+1 != self.length # make sure you don't test past the length of the array itself
                    if prc.call(self[i], self[i+1]) > 0 # using the block with the spaceship operator, returns -1 if the left is less than the right, returns 1 if the left is greater than the right. So if this is larger than 0, that means that the current element is greater than the next element, so switch them. Love it, done
                        self[i], self[i+1] = self[i+1], self[i]
                        sorted = false
                    end
                end
            end
        end
        self
    end

    # interesting that the non mutating version is the one that uses another memory space and uses more memory space and is by default less efficient than the mutated version even though it's the default version used
    def bubble_sort(&prc)
        new_array = self.dup # duplicate the bubble_sort array to create a new object id
        new_array.bubble_sort!(&prc) # run bubble_sort! on the new array and return it and pass in &prc, which is the prc block that was passed into this method converted back to a block to be passed in correctly with &
    end
end


# ### Substrings and Subwords
#
# Write a method, `substrings`, that will take a `String` and return an
# array containing each of its substrings. Don't repeat substrings.
# Example output: `substrings("cat") => ["c", "ca", "cat", "a", "at",
# "t"]`.
#
# Your `substrings` method returns many strings that are not true English
# words. Let's write a new method, `subwords`, which will call
# `substrings`, filtering it to return only valid words. To do this,
# `subwords` will accept both a string and a dictionary (an array of
# words).

# omg this works lmao finally once you figured it out it was easy
def substrings(string)
    substring_array = []
    while string.length > 0
        string.each_char.with_index do |c, i|
            substring = ''
            (0..i).each do |index|
                substring << string[index]
            end
            substring_array << substring
        end
        string.slice!(0)
    end
    substring_array
end

# again, their solution which is better:
# def substrings(string)
#     subs = []
#     (0...string.length).each do |start_idx| # iterate over it string.length times
#         (start_idx...string.length).each do |end_idx|
#             subs << string[start_idx..end_idx] # this is the way to call a whole bunch of a string great method string[start..end] that's what you didn't know then and what you don't know now and what would have made this so much easier
#         end # do the loop again except increment the start_idx by one so on first run you get c, ca, cat, then second run a, at, then third run t
#     end
#     subs
# end
# key takeaway - remember string[start_idx..end_idx]

# yay awesome still can't believe how hard substrings is compared to everything you feel better knowing it was that hard the first time around too hilariously lol
def subwords(word, dictionary)
    raw_substring_array = substrings(word)
    raw_substring_array.select { |word| dictionary.include?(word) } # only return words that are in the dictionary
end

# word = "cat"
# dictionary = ['a', 'cat']
# subwords(word, dictionary)

# review exercises

class Array
    def my_each(&prc) # successfully called in pry
        i = 0 # damn stella wrote some great code here lmao saved my ass
        while i < self.length
            prc.call(self[i]) # ah right this is the correct method you need to use to call it thank god you actually took notes way easier than going way back in the course to find the section notes are actually crazy useful have been crazy useful very lucky
            i += 1
        end
        self
    end

    # ah great refresher practice love it you've literally done this all before but doing it again all nice and straightforward
    def my_select(&prc)
        new_array = []
        self.my_each do |ele| # pass in a block of code to the my_each method which will iterate over each element of the array and run the block of code below on each element
            new_array << ele if prc.call(ele) # have the code that is run select each element that evaluates true for the block passed in
        end
        new_array
    end

    def my_reject(&prc)
        new_array = []
        self.my_each do |ele|
            new_array << ele if !prc.call(ele)
        end
        new_array
    end

    def my_any?(&prc)
        self.my_each do |ele|
            return true if prc.call(ele)
        end
        false
    end

    def my_all?(&prc)
        self.my_each do |ele|
            return false if !prc.call(ele)
        end
        true
    end

# their recursive solution is pretty amazing it calls itself
# def my_flatten
#     flattened = []

#     self.my_each do |el|
#         if el.is_a?(Array)
#             flattened.concat(el.my_flatten)
#         else
#             flattened << el
#         end
#     end
#     flattened
# end

    # holy shit can't believe this actually worked on your first try lol
    def my_flatten
        flat_array = flatten(self) # run the flatten array to start on this
        while flat_array.my_any? { |ele| ele.kind_of?(Array) } # while any element of the array is still a subarray, keep flattening
            flat_array = flatten(flat_array)
        end
        flat_array
    end

    def flatten(arr)
        flatter_array = []
        arr.my_each do |ele|
            if ele.kind_of?(Array) # if the subelement is an array, split it up and return each element itself into the array
                ele.my_each { |e| flatter_array << e }
            else
                flatter_array << ele # else if the element isn't an array, return it as is
            end
        end
        flatter_array # return the array flattened one step above
    end

    # wow your code is exactly the same as theirs nice
    # wow truly insane you got this on the first try too
    def my_zip(*arg)
        zipped_array = []
        (0...self.length).each do |i| # run this loop self.length number of times, as many times as there are elements in the self array and get the index of each element in the array
            sub_array = [self[i]] # create a new sub_array that has the current element of the self array as its first element
            arg.each { |e| sub_array << e[i] } # for each argument that was passed in, add the current element of that argument at the same index as the self array to the sub_array --> adding nil if no element exists
            zipped_array << sub_array # then add the completed sub_array to the full zipped array
        end 
        zipped_array # return the full zipped array
    end

    # huh some crazy methods self.drop and self.take look into those more
    # fuck yeah got it to work on the first try way easier than last time that feels great to know
    def my_rotate(shift=1)
        shifted_array = []
        (0...self.length).each do |i| # ah (...) is not an Array, it's a range, that's cool lol so can't run your my_each method on it oh well
            shifted_array << self[(i+shift)%self.length] # shift the array over by shift amount, if i+shift is greater than self.length then divide it by that and return the modulo so it always returns a valid index to shift to
        end
        shifted_array
    end

    # also done in one shot yay
    def my_join(separator='')
        big_string = ''
        self.my_each { |ele| big_string << ele + separator }
        big_string
    end

    # amazing works still woohoo just return the last value of the array to the first value by using the [-num] trick to enumerate backwards in an array from the last index forward
    def my_reverse
        reversed_array = []
        (1..self.length).each do |i| # make this inclusive since going backwards all the way to the beginning so 1..self.length inclusive is the same length as 0...self.length exclusive which is nice always most often the off by one errors love it
            reversed_array << self[i * -1]
        end
        reversed_array
    end

    # onwards to the iteration exercises!
end