class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) {nil} }
    fill_board
  end

  def fill_board
    piece = Pawn.new([1, 1])
    piece1 = Pawn.new([1, 2])
    piece2 = Pawn.new([1, 3])
    king = King.new([7, 4])
    @grid[1][1] = piece
    @grid[1][2] = piece1
    @grid[1][3] = piece2
    @grid[7][4] = king
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

  def check(loc)
    check = false

    possible_moves = @grid[loc[0]][loc[1]].move(self)
    possible_moves.each do |move|
      next if @grid[move[0]][move[1]].nil?

      if @grid[move[0]][move[1]].king == true && @grid[move[0]][move[1]].player_id != @grid[loc[0]][loc[1]].player_id
        check = true
      end
    end

    check
  end

end #End of board class