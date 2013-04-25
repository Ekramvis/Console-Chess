class King < Piece

  attr_accessor :location, :player_id, :king

  def initialize(location)
    super(location)
    generate_deltas
    @king = true # REV: can do x = ExampleClass.new; x.class == ExampleClass; even if ExampleClass < ExampleParent
  end

  def generate_deltas
    #makes all moves in all directions, also off board
    y = location[0]
    x = location[1]

    @deltas = [
        [y-1,x], [y-1,x-1],[y-1,x+1],
        [y+1,x], [y+1,x-1], [y+1,x+1],
        [y, x+1], [y, x-1]
      ]
  end

  def display_self
    print "K|" # REV: unicode ♔ / ♚
  end

  def move(board)
    generate_possible_moves(board)
  end

  def generate_possible_moves(board)
    deltas = generate_deltas

    on_board_moves = on_board(deltas)
    self_square_moves = self_squares(on_board_moves, board) # REV: don't need to assign it to a variable
  end

  def on_board(deltas)
    deltas.select do |delta|
      delta[0].between?(0, 7) && delta[1].between?(0, 7)
    end
  end

  def self_squares(on_board_moves, board)

    on_board_moves.select do |move|
      y = move[0]
      x = move[1]

      if board.grid[y][x]
        if board.grid[y][x].player_id == self.player_id
          false
        else
          true
        end
      else
        true
      end
    end
  end

  def dup_piece
    new_king = King.new(self.location)
    new_king.player_id = self.player_id
    new_king
  end

end #end King class