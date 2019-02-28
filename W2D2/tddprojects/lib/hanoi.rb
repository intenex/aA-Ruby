require 'byebug'

class Hanoi # oh thank god this is way easier lmao than solving the acutal towers of hanoi but definitely try that lol
    attr_reader :pile1, :pile2, :pile3

    def initialize(size)
        @size = size
        @pile1 = (1..@size).to_a # fucking bril
        @pile2 = Array.new
        @pile3 = Array.new
    end

    def play
        until won?
            puts "Pile 1 = #{pile1} | Pile 2 = #{pile2} | Pile 3 = #{pile3}"
            puts "Please enter a pile to move from and a pile to move to, like 1 2"
            answer = gets.chomp
            start_pile, end_pile = answer.split().map(&:to_i) # this shouldn't raise an error but it will later if these things can't be converted to integers
            move(start_pile, end_pile)
        end
        puts "Pile 1 = #{pile1} | Pile 2 = #{pile2} | Pile 3 = #{pile3}"
        puts "Congratulations! You've won!"
    rescue => e
        puts e
        retry
    end

    def move(start_pile, end_pile)
        raise ArgumentError.new('piles must be between 1 and 3') if (start_pile <= 0 || start_pile > 3 || end_pile <= 0 || end_pile > 3)
        from_pile = eval("@pile"+start_pile.to_s) # fuck it eval it is for now lol # hilariously god dammit you have to convert it back to a string LOL also this is from http://ruby-doc.org/core-2.1.2/Binding.html#method-i-local_variable_get the long more generalized form of calling a variable from a string is https://ruby-doc.org/core-2.6.1/Kernel.html#method-i-eval eval but eval is generally bad https://stackoverflow.com/questions/1902744/when-is-eval-in-ruby-justified http://rubymonk.com/learning/books/5-metaprogramming-ruby-ascent/chapters/24-eval/lessons/63-eval
        to_pile = eval("@pile"+end_pile.to_s)
        raise ArgumentError.new('the start pile is empty!') if from_pile.empty?
        raise ArgumentError.new('you cannot move a larger disk on a smaller one!') if (!to_pile.empty? && from_pile[0] > to_pile[0])
        disk_to_move = from_pile.shift
        to_pile.unshift(disk_to_move)
    end

    def won?
        @pile3 == (1..@size).to_a
    end
end