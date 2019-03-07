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