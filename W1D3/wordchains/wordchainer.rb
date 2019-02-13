# Given two words of equal length as command-line arguments, build a chain of words connecting the first to the second. Each word in the chain must be in the dictionary and every step along the chain changes exactly one letter from the previous word.
# Again, your program should accept input as two command-line arguments. Your program should also allow a -d command-line switch followed by a dictionary file to use, but feel free to choose a sensible default for your system. The result should be a word chain starting with the first word and ending with the last printed to STDOUT, one word per line. Print an error message if a chain cannot be found.

# definitely take the time to understand this code and work hard to get through it again later and do all the bonuses and all that
class WordChainer

    attr_reader :dictionary, :alphabet, :current_words, :all_seen_words, :word_chain

    def initialize(dictionary_file_name)
        @dictionary = File.readlines(dictionary_file_name).map(&:chomp).to_set # readlines returns an array I suppose and then you have to return the array with the \n character chopped from every input since it reads in the new lines too in the dictionary, makes sense, then do to_set to turn it into a set to have faster search time
        @alphabet = 'abcdefghijklmnopqrstuvwxyz'
        @current_words = Array.new
        @all_seen_words = Array.new
        @word_chain = Array.new
    end

    # so good to know how to do this love it really getting better at this stuff even when tired love life
    # works flawlessly first try love it you def know what you're doing now
    def adjacent_words(word)
        word_array = word.split('') # split up the word so you can change each character and see if it makes a new word and store it if it does
        all_adjacent_words = Array.new
        word_array.each_index do |i| # you could just operate on the word directly actually but whatever this works too
            @alphabet.each_char do |l|
                new_pos_word = word_array.dup # oh good this does work whew tested in pry
                new_pos_word[i] = l # create the new possible word and see if it's a word
                all_adjacent_words << new_pos_word.join('') if @dictionary.include?(new_pos_word.join('')) # if it is indeed a word, add it to the list of all adjacent words
            end
        end
        all_adjacent_words
    end

    # worked perfectly first try becuase they literally told you step by step everything to do lol
    def run(source, target)
        @current_words = [source]
        @all_seen_words = { source => nil }
        while @current_words.length != 0
            new_current_words = self.explore_current_words(target) # pass target to the submethod here so it can check to see if it has found the target word and a path to it and cut the program short if so
            @current_words = new_current_words # this way it will end when new_current_words has nothing added to it and there's nothing left to add or when the target word is found early and returns [] as the hardcoded return value
        end
        build_path(target)
        @word_chain.reverse! << target # since build_path constructs the @word_chain list in reverse order from the last adjacent word before the target was found as the first word in the array and the last element being the first word, or the source word, in the array, you need to run reverse! on it to change this order. Then add the target word to the end of the array, since it wasn't added in build_path since the first word build_path adds to the array is the last adjacent word before the target word was found 
        @word_chain # return the whole completed word path in all it glory from the source word to the target word!
    end

    # refactor still perfect first try despite not having slept in forever
    def explore_current_words(target)
        new_curr_words = Array.new
        @current_words.each do |word| # iterate over all the current words, starting from just the single source word
            adjacents = adjacent_words(word) # find all the adjacent words for each of the current words
            adjacents.each do |adj_word| # iterate over every single adjacent word
                if !@all_seen_words.include?(adj_word) # if the word hasn't been seen before, do the rest - if it has, the rest has already been done so no need to repeat
                    new_curr_words << adj_word # add this adjacent word to the return array --> this will be an array of all the adjacent words to all the current source words in the current_words array, and will consequently become the next current_words array passed into this #explore_current_words method on the next run through - so you're going through each iteration/step of the puzzle basically
                    @all_seen_words[adj_word] = word # add this word to the total list of all the words seen in every single step of the word chain, such that you can prevent repeating yourself and also trace your steps back once you find the target word, as this is basically a linked list you just created - the key/value pairs of this hash all_seen_words are a chain pointing from the target word all the way to the source word as the key is the last word in the chain (the target), and the value is the word that was the parent adjacent word to that last word, and the value of the parent adjacent word plugged in as the key is the parent to that parent, and so forth, all the way until you reach nil, which means you hit the source, the starting word in the chain
                    return [] if @all_seen_words.include?(target) # this returns a nil array to break the while loop in #run from running any more numbers once the target number is found and it's unnecessary to get any more numbers - this works because the while loop ends when @current_words.length = 0 and @current_words is set to the return output of this #explore_current_words method in the loop after this is run so by returning [] you're setting it early to a 0 length array so that the while loop will evaluate to its stop condition and move on to the rest of the method call
                end
            end
        end
        new_curr_words
    end

    # wow this is brilliant lol def would have been hard to think of on our own, getting the entire space of all the possible word permutations first then working backwards like this
    # fuck yeah you *did* use recursion to solve this one because obviously you would why would they say not to
    def build_path(target)
        return nil if !@all_seen_words[target] # base case, just end once this is reached and return nothing
        @word_chain << @all_seen_words[target] # add the current word in the word chain to the @word_chain array which contains all the words to get from the target end word all the way back to the source starting word - in reverse order, which is to say the last words next to the target first all the way back to the source word being the last word in this chain. You could fix this now with something like @word_chain = @all_seen_words[target] + @word_chain or something to put that word first, or use shift to do that, but no real need, your code works the same since you run .reverse on your array all the way back up in the @run method before returning that output
        build_path(@all_seen_words[target]) # the recursive step to keep calling this method and plugging in the last word until the thing hits the source, or nil
    end

end