def my_uniq(arr) # interesting the various ways you figure out of doing something truly am lucky to just be smart it's huge
    uniq_hash = Hash.new(true)
    arr.each { |ele| uniq_hash[ele] = true }
    uniq_hash.keys
end