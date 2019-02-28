def my_transpose(arr) # yay perfect
    trans_arr = Array.new
    arr.each_with_index do |row, index|
        new_row = Array.new
        arr.length.times do |i2|
            new_row << arr[i2][index]
        end
        trans_arr << new_row
    end
    trans_arr
end