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

end

class Piece

  def initialize(location)
    @location = location #array of [x, y]
    @location[0] > 5  ? @player_id = "White" : @player_id = "Black"
  end

  def display_self

  end
end

class Pawn < Piece

  def initialize(location)
    super(location)
  end

  def display_self
    print "P|"
  end
end



