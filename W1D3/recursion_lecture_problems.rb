# code to trace all the stack frames in an infinitely recursive method --> put this at the top of your program to read the output when it hits over MAX_STACK_SIZE
MAX_STACK_SIZE = 200
tracer = proc do |event|
	if event == ‘call’ && caller_locations.length > MAX_STACK_SIZE
		fail “Probable Stack Overflow”
	end
end
set_trace_func(tracer)

def upcase(str)
	return str.upcase if str.length <= 1
	puts str
	p str[0].upcase + upcase(str[1..-1])
end

# wow this will take some work to get again love it can't wait
def iterative_upcase(str)
	str.chars.inject(“”) do |upcased_str, char|
		upcased_str << char.upcase
	end
end

# love it return just the str itself if it's 1 length or less but it never should be
def reverse(str) # you can also reverse this with an interative enumerator too but this works great
	return str if str.length <= 1 # the <= 1 helps so that even if someone calls your function with an empty string argument et
	puts str
	str[-1] + reverse(str[0..-2]) # return the last character + reverse run on every substring until the string is just one character long
end # each substring should be everything in the string but the last character that was printed, hence start at 0 and end at -2, removing the -1 last character, love it

def factorial(num)
    # ooh the reason this works is because every version returns the number * the numbers below it except when factorial(1) in which case it returns 1 love it base case brillaint getting it
    return 1 if num==1 # weird that return 1 returns the right number actually kind of strange that this works return 1 must mean something special
    num * factorial(num-1) # oh weird return 2 just doubles the last return value, interesting, so return 1 just means return the return value * 1 interesting
end # fascinating you can return 100 etc and it'll just multiply the return value 100 times fascinating it won't return literally 100 I guess that makes sense kind of

# awesome quicksort looks at the first number in the array and sorts two subarrays, one with everything less than the first element on the right and one with everything greater than on the left, then runs quicksort on each of those parts too, and then adds them all together, love it
# your own quicksort algorithm love it, awesome that you can come up with this stuff on your own trivially now definitely getting better, love it
def quicksort(arr)
    return arr if arr.length <= 1
    less_than = []
    greater_than = []
    equal_to = []
    arr.each do |num|
        less_than << num if num < arr[0]
        greater_than << num if num > arr[0]
        equal_to << num if num == arr[0] # this will shovel arr[0] in there too since you iterate over arr[0] love this shit so much
    end
    quicksort(less_than) + equal_to + quicksort(greater_than)
end

# their quicksort algorithm
# def quicksort(arr)
#     return arr if arr.length <= 1
#     pivot = [arr.first] # oh cool just like arr[0] love it --> need to wrap this in an array so that you can add it together with the rest of the arrays you'll be adding together
#     left_side = arr[1..-1].select { |el| el < arr.first }
#     right_side = arr[1..-1].select { |el| el > arr.first }
#     quicksort(left_side) + pivot + quicksort(right_side)
# end

# quicksort((1..1000).to_a.shuffle)