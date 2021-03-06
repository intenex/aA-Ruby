# The cursor manages user input, according to which it updates its @cursor_pos. The display will render the square at @cursor_pos in a different color. Awesome

require "io/console"
require "byebug"

KEYMAP = {
  " " => :space,
  "h" => :left,
  "j" => :down,
  "k" => :up,
  "l" => :right,
  "w" => :up, # hah nice they give you three different ways to move up left down right love it the three standard formats amazing
  "a" => :left,
  "s" => :down,
  "d" => :right,
  "\t" => :tab,
  "\r" => :return,
  "\n" => :newline,
  "\e" => :escape,
  "\e[A" => :up,
  "\e[B" => :down,
  "\e[C" => :right,
  "\e[D" => :left,
  "\177" => :backspace,
  "\004" => :delete,
  "\u0003" => :ctrl_c,
}

MOVES = {
  left: [0, -1],
  right: [0, 1],
  up: [-1, 0],
  down: [1, 0]
}

class Cursor

  attr_reader :cursor_pos, :board, :selected

  def initialize(cursor_pos, board)
    @cursor_pos = cursor_pos
    @board = board
    @selected = false # change this to true if a piece is selected --> make sure later you can only select your own pieces and whatnot
  end

  def get_input
    key = KEYMAP[read_char]
    handle_key(key)
  end

  private # ah nice they already made it all private sweet

  def read_char
    STDIN.echo = false # stops the console from printing return values # whoah this is awesome love it

    STDIN.raw! # in raw mode data is given as is to the program--the system
                 # doesn't preprocess special characters such as control-c

    input = STDIN.getc.chr # STDIN.getc reads a one-character string as a
                             # numeric keycode. chr returns a string of the
                             # character represented by the keycode.
                             # (e.g. 65.chr => "A") # nice

    if input == "\e" then
      input << STDIN.read_nonblock(3) rescue nil # read_nonblock(maxlen) reads
                                                   # at most maxlen bytes from a
                                                   # data stream; it's nonblocking,
                                                   # meaning the method executes # hmm what does async execution mean in this case
                                                   # asynchronously; it raises an
                                                   # error if no data is available,
                                                   # hence the need for rescue

      input << STDIN.read_nonblock(2) rescue nil
    end

    STDIN.echo = true # the console prints return values again # ah have to manually set this back
    STDIN.cooked! # the opposite of raw mode :) # hahaha hilarious have to manually set the mode back nice interesting otherwise it would just stay like that forever hmm

    return input
  end

  # always write out all the steps of a large problem so you can tackle it effectively for sure, you obviously have to do this stuff, so just do it lol, really crazy they don't seem to give you more direction about it though like they walk through a bunch of stuff then just skip huge sections
  # to handle selecting and moving a piece, there must be one selected piece
  # to deselect a piece and reselect another, you must deselect on the selected piece
  # to move somewhere else, you must check if the move is a valid move for the given piece
  # if it is a valid move, 

  def handle_key(key)
    case key # whoah *that's* how it works right say what we're casing is the variable key which is what was passed in amazing. case is just a conditional like an if/else just simplified syntactic sugar, switch statements same thing, just specifies in all the different cases what to do but same as an if/else for sure https://www.rubyguides.com/2015/10/ruby-case/
    when :return, :space # if key = :return or :space, return the cursor pos
      row, col = @cursor_pos
      if !@board.grid[row][col].is_a?(NullPiece)
        toggle_selected # if the current position is a NullPiece then don't do anything, otherwise if it's a piece, toggle selected --> you'll need to make this way more robust later in ensuring that it's only the specific piece that's selected that is currently on cursor_pos, etc., but fuck it for now let's see what the rest of making this game entails first then you can fix all the little odds and ends later :)
      end
      @cursor_pos
    when :left, :right, :up, :down
      update_pos(MOVES[key]) # MOVES is an array with symbols as the keys love it
      nil # return nil after calling @update_pos
    when :ctrl_c
      Process.exit(0) # http://ruby-doc.org/core-2.2.0/Process.html#method-c-exit # omg this is amazing lmao it literally just terminates the Ruby script by raising the SystemExit exception - you can literally catch this exception and prevent the exit if you want LOL so amazing the *function* is to raise a terminal exception wow lol
    end
  end

  def toggle_selected
    @selected ? (@selected = false) : (@selected = true) # if selected is true, make it false, else, make it true
  end

  def update_pos(diff)
    transposed_pos = [@cursor_pos, diff].transpose.map(&:sum) # this will transpose the rows together, such that if @cursor_pos = [1,2] and diff = [0, -1], the transposed thing will be [[cursor_pos[0], diff[0]], [cursor_pos[1], diff[1]]], or [[1, 0], [2, -1]], and then .map will run on [1, 0] and [2, -1] and sum them together to return a final array of [1, 1] heh amazing
    @board.valid_pos?(transposed_pos) ? (@cursor_pos = transposed_pos) : nil # perhaps have a different exception later, but for now only return the transposed position if it is a valid position as per the @board.valid_pos method. By returning nil it should just not update the position so nothing should happen I think
  end
end