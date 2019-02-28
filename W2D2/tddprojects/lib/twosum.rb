def two_sum(arr)
    pairs = Array.new
    arr.each_with_index do |n1, i1| # glad you actually do remember this stuff real nice the chat groups are actually a distraction don't get bogged down in that for sure
        arr.each_with_index do |n2, i2|
            if i2 > i1 # don't compare the same number with itself, and in fact only compare larger indexes to avoid duplicate pairs as smaller ones will have already been compared once so you don't go in reverse order double pairing everything
                pairs << [i1, i2] if (n1 + n2 == 0)
            end
        end
    end
    pairs
end