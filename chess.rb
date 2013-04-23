class Board

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

  end

end #End of board class


class Piece

  attr_accessor :location

  def initialize(location)
    @location = location #array of [x, y]
    @location[0] > 5  ? @player_id = "White" : @player_id = "Black"
  end

  def move(board)
  end

end

class Pawn < Piece

  attr_accessor :location

  def initialize(location)
    super(location)
  end

  def display_self
    print "P|"
  end

  def move(board)
    board = board
  end

  #legal moves - white pawns must move up one y only. Can move one diagonal if another piece in there.
end



