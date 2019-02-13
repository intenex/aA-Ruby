require 'colorize' # extends String class

class Tile
    attr_reader :value

    def initialize(value, given)
        @value = value
        @given = given # ah this means if the game started with this tile or not. Ah amazing - if it's 0 it's given, if not it isn't
    end

    def value=(num) # should be able to use syntactic sugar to do this but make sure it does work love it
        if !@given # if the tile wasn't given, you can change it, otherwise you can't
            @value = num
        end
    end

    def to_s # turn the tile into a string to be rendered
        if @given # if the tile was given make it a certain color
            @value.to_s.colorize(:yellow) # amazing colorize works don't need a gemfile just needed to call gem install colorize once and then include colorize love it
        else
            @value.to_s.colorize(:green) # return the value to s --> # love this colorize shit so cool lol
        end
    end

end