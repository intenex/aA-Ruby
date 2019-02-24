# the literal last step is processing cursor input
# make sure that the cursor can appropriately select pieces and move them
# make sure that you can only move pieces of your own color, and that's literally the game lol insane so easy when everything is in the right place so lucky to be done with this and to be so happy with it and for it to look so good thanks to victoria

class HumanPlayer
    def initialize(color, display)
        @color = color
        @display = display
    end

    def make_move(board)
        while @display.cursor.end_pos.empty? # while there's no end position, keep running this thing, better than the way you had it before
            system('clear')
            @display.render
            puts "Current player: #{@color}"
            puts "Current selected piece: #{@display.cursor.start_pos}" if @display.cursor.selected # if there's a selected piece, print what piece is selected so they know, awesome
            @display.cursor.get_input(@color) # when you process this input make sure that the player can only select and move a piece of their color
        end
        start_pos = @display.cursor.start_pos
        end_pos = @display.cursor.end_pos
        @display.cursor.start_pos = Array.new
        @display.cursor.end_pos = Array.new # reset these so this thing can run again later
        @display.board.move_piece(start_pos, end_pos) # heh love it this actually works super well can't wait fuck how they designed the code god knows how it's supposed to work this should be fine though lol
    rescue ArgumentError => e # if any of the wrong move exceptions come up handle it and retry love it
        puts e
        sleep(1) # so they can read that error message love it
        retry # if the end position was invalid then do this whole baby over again
    end
end