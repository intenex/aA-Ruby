# okay now that you're actually diving into it this is fun and super approachable they do actually tell you all the things you need lol though you could figure that out on your own too but this makes it much easier honestly
# every problem is more than approachable if you just take the time to actually approach it. So do that. Don't ever get daunted by something seeming hard or complex or large - just take it one step at a time and you'll get it all there in the end, love it.
# can't believe this actually all ran on your first try basically without having tested any of this code before amazing just wrote it all then ran it no major errors
# love that you just get really deep into these and don't care about time as much that's actually great really dig that
# boom works flawlessly on depth one now just need to implement the nested tree thing and you're 100% ready to go here with this code so incredible
# super late but honestly super satisfying because you got this actually completed always the most satisfying feeling very grateful for that

require_relative './dictionary.rb'

class AiPlayer # this should be called every time you want an AI to run the code
    attr_reader :dictionary, :n, :fragment, :alphabet
    attr_accessor: :winning_move_count, :losing_move_count

    def initialize(fragment, num_players)
        @fragment = fragment
        @n = num_players
        @dictionary = WORD_DICT.to_set
        @alphabet = %w[a b c d e f g h i j k l m n o p q r s t u v w x y z] # create an array that's an alphabet
        @winning_move_count = Hash.new(0) # create a new hash to store the count for each character of how many wins are in the tree
        @losing_move_count = Hash.new(0) # create a new hash to store the coutn for each character of how many losses there are in each tree
    end

    def find_remaining_words(char)
        @dictionary.select { |word| word.start_with?(@fragment+char) } # this should return an array with all the words in the dictionary that start with the current fragment
    end

    def losing_move?(char) # boolean returning if this is a losing move or not
        @dictionary.include?(@fragment+char) # if any word in the dictionary matches @fragment+char, then this is a losing move
    end

    def winning_move?(char) # boolean returning if this is a winning move or not
        remaining_words = find_remaining_words(char) # retrieve an array with all the words remaining if this char is played
        if remaining_words != [] # if it's empty, that means there are no valid words if you play this so must return false
            remaining_words.all? { |word| word.length <= @fragment.length + 1 + n } # if the word lengths of all the words remaining are less than or equal to the length of the fragment + char (the 1 thing) + n, then this is a winning move because all the possible moves someone else can play would result in someone losing before you
        else
            false
        end
    end

    def valid_move?(char)
        remaining_words = find_remaining_words(char)
        remaining_words != [] # return true if there are any remaining words that could be made if you play this char, or false if there are no more words
    end
    
    def choose_move # damn you're great at finding bugs by this point really awesome and because of the way you're learning this stuff by your second time around you'll really have it cemented unlike others so lucky to get to get a ton of this done ahead of the actual class love it
        @alphabet.each { |char| return char if winning_move?(char) } # first try to return any winning move
        @alphabet.each { |char| return char if !losing_move?(char) && valid_move?(char) } # if no winning moves return any move that isn't a losing move, ah that was your error don't forget to also confirm that it's a valid move lmao you didn't do this before so the AI kept returning valid moves man byebug is powerful as fuck totally solved this and learned how to delete breakpoints with delete 1 etc note that delete num doesn't have the num specify the line the breakpoint was set on like break line_num, but rather the breakpoint #, everytime you set a breakpoint it's assigned a number, like breakpoint #3, which may point to say line # 42, so if you want to delete that breakpoint at line 42, you have to type delete 3 great to learn this and to debug man now you know you really can get through anything this would have been nuts hard to debug otherwise but byebug really did crush it for you so insanely powerful this learning shit is absolutely teaching you more practical knowledge than people going through 4 years of CS at most schools likely come out knowing incredible so practical couple that with actually being good at programming and you absolutely should be able to find a job if you can get through all of this well, truly the most insanely incredible thing ever for sure
        @alphabet.each { |char| return char if valid_move?(char) } # finally return any move that's just a valid move, crazy this thing is actually basically usable at this point so amazing how each incremental step creates something like this
    end

    def best_move
        self.deep_search(char) # must pass in the parent character to run a deep search on
    end

    # # make this real code to make this AI really automated with optimal moves later and figure out the tree search here
    # def deep_search(orig_char)
    #     # have a while conditional that runs this as long as every single move isn't a winning or losing move
    #     while !placeholder.all? { |char| winning_move?(char) || losing_move?(char) || !valid_move?(char) } # while all characters in the lowest level aren't winning or losing moves or are no longer valid moves keep running this - once they are, return it
    #         @alphabet.each do |char|
    #             if winning_move?(char)
    #                 @winning_move_count[orig_char] += 1 # if this is a winning move, add it to the original character's winning move tree count
    #             elsif losing_move?(char)
    #                 @losing_move_count[orig_char] += 1
    #             elsif valid_move?(char) # if it's not winning or losing move but is valid, then go deeper
    #                 recursion_something_go_deeper(char)
    #             end
    #         end
    #     end
    # end


    # now you just need to build a version that explores in depth all the possible paths and the whole tree all the way down and picks the right move that minimizes losses and maximizes wins really helpful that they give you exactly enough guidance to make these challenging but doable with telling you things like a winning move is less than n moves remaining so someone else has to pick it
    # steps to take:
    # 1. iterate over every single character and see if any are winning moves, if so, return that char
    # 2. then for every single character that has remaining words (that are not all winning words ofc otherwise would have returned above), add that char to a temporary extended fragment
    # 3. now iterate again with every character on the extended fragment from step 2, and count all the characters that result in losing moves, and count all the characters that result in winning moves
    # 4. if not every single character results in a losing or a winning move, then continue this recursion and create a new extended fragment for every character that isn't a losing or winning move
    # 5. run this same iteration again with every character on the new extended fragment, count all the losers and winners, and continue this recursion until there are no more characters that don't result in either a loss or a win
    # 6. at this point, you should have a count of the # of all the winning moves and all the losing moves that result down the line from any given character you can play this turn. likely you'd want to store this in a hash or some other kind of data structure, you can have two hashes, both with all the letters of the alphabets as keys and one that stores as values all the winning moves down the tree for that letter of the alphabet, and another that stores all the losing moves
    # 7. return the character that has the fewest losing moves first, and then as a tiebreaker, the character that has the most winning moves. Ideally your AI would use some kind of proportional system such that if one character had just one more losing move but a million more winning moves, you'd choose the latter and not the former, but this is a great starting point for sure

    # wow writing out each step line by line is amazing and makes this so much more easily approachable and efficiently tackeable always do this when it's not immediately obvious to you how to approach a problem, break it down into bite-size chunks. the only thing you aren't sure how to do here pretty much is how to do the infinite recursion but likely that's a job for a while loop of some kind and you're confident you'll figure it out

end