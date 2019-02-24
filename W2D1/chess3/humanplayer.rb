# the literal last step is processing cursor input
# make sure that the cursor can appropriately select pieces and move them
# make sure that you can only move pieces of your own color, and that's literally the game lol insane so easy when everything is in the right place so lucky to be done with this and to be so happy with it and for it to look so good thanks to victoria

class HumanPlayer
    def initialize(color, display)
        @color = color
        @display = display
    end

    def make_move(board)
        system('clear')
        self.render
        @display.cursor.get_input # when you process this input make sure that the player can only select and move a piece of their color
    rescue => e # if any of the wrong move exceptions come up handle it and retry love it
        puts e
        retry
    end
end