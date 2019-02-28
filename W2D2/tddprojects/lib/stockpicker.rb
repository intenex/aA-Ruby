# okay super simple: add every single number to every number that comes after it
# then put all these numbers into a hash, with the keys being all array pairs
# then just pick the value that has the biggest profit, find its key, and return that key
# note that you want the keys to be the array pairs since those will be the unique thing
# eh you could actually do it the other way around too but whatever

def stockpicker(arr)
    possible_trades = Hash.new
    arr.each_with_index do |p1, i1|
        arr.each_with_index do |p2, i2|
            possible_trades[[i1, i2]] = (p2 - p1) if i2 > i1 # only do this for sell days that are longer than the buy days ofc. # # store whatever value this comes out to
        end
    end
    max_profit = possible_trades.values.max # https://ruby-doc.org/core-2.6.1/Enumerable.html#method-i-max love it there's a method for everything lol
    possible_trades.key(max_profit)
end