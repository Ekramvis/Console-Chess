class Knight < Piece

  attr_accessor :location, :player_id, :king

  def initialize(location)
    super(location)
    generate_deltas
  end

  def generate_deltas
    #makes all moves in all directions, also off board
    y = location[0]
    x = location[1]

    @deltas = [
      [y + 1, x + 2], [y + 1, x - 2],
      [y - 1, x + 2], [y - 1, x - 2],
      [y + 2, x + 1], [y + 2, x - 1],
      [y - 2, x + 1], [y - 2, x - 1]
      ]
  end

  def display_self
    print "H|" # REV: unicode ♘ / ♞
  end

  def move(board)
    generate_possible_moves(board)
  end

  def generate_possible_moves(board)
    deltas = generate_deltas

    on_board_moves = on_board(deltas)
    self_square_moves = self_squares(on_board_moves, board) # REV: variable assignement useless
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
    new_knight = Knight.new(self.location)
    new_knight.player_id = self.player_id
    new_knight
  end

end #end Knight class