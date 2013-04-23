class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) {nil} }
    fill_board
  end

  def fill_board
    piece = Pawn.new([6, 0])
    @grid[6][0] = piece
  end

  def display_board
    @grid.each_with_index do |row, y|
      puts ""
      row.each_with_index do |square, x|
        if @grid[y][x]
          print @grid[y][x].display_self
        else
          print "_|"
        end
      end
    end
  end

  def update_board(start, stop)
    y1 = start[0]
    x1 = start[1]
    y2 = stop[0]
    x2 = stop[1]

    piece = @grid[y1][x1]
    @grid[y1][x1] = nil

    #check if position he will take is occupied

    @grid[y2][x2] = piece
    piece.location = [y2, x2]
  end

  def validate_move(start, stop)
    valid_moves = @grid[start[0]][start[1]].move(self)
    valid_moves.include?(stop)
  end

end #End of board class


class Piece

  attr_accessor :location

  def initialize(location)
    @location = location #array of [x, y]
    @location[0] > 5  ? @player_id = "White" : @player_id = "Black"
  end

  def move(board, stop)
  end

end

class Pawn < Piece

  attr_accessor :location

  def initialize(location)
    super(location)
    generate_deltas
  end

  def generate_deltas
    #makes all moves in all directions, also off board
    y = location[0]
    x = location[1]
    if @player_id == "White"
      @deltas = [[y-1,x],[y-1,x-1],[y-1,x+1]]
    else
      @deltas = [[y+1,x],[y+1,x-1],[y+1,x+1]]
    end
    @deltas
  end

  def display_self
    print "P|"
  end

  def move(board)
    generate_possible_moves(board)
  end

  def generate_possible_moves(board)
    deltas = generate_deltas

    on_board_moves = on_board(deltas)
    self_square_moves = self_squares(on_board_moves, board)
    enemy_square_moves = enemy_squares(self_square_moves, board)
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

  def enemy_squares(self_square_moves, board)
    # pawn has a lot of rules
    self_square_moves.select do |move|
      y = move[0]
      x = move[1]

      if board.grid[y][x].nil? && x != self.location[1]
        false
      elsif board.grid[y][x] && x != self.location[1]
        true
      elsif board.grid[y][x] && x == self.location[1]
        false
      elsif board.grid[y][x].nil? && x == self.location[1]
        true
      end
    end
  end

  #legal moves - white pawns must move up one y only. Can move one diagonal if another piece in there.
end



