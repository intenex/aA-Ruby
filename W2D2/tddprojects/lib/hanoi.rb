class Hanoi # oh thank god this is way easier lmao than solving the acutal towers of hanoi but definitely try that lol
    attr_reader :pile1, :pile2, :pile3

    def initialize(size)
        @pile1 = (1..size).to_a # fucking bril
        @pile2 = Array.new
        @pile3 = Array.new
    end

    def play
        
    end

    def move(start_pile, end_pile)
    end

    def won?
        @pile3 = (1..size).to_a
    end
end