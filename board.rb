class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) {nil} }
    fill_board
  end

  def fill_board
    @grid[0][0] = Rook.new([0, 0])
    @grid[0][1] = Knight.new([0, 1])
    @grid[0][2] = Bishop.new([0, 2])
    @grid[0][3] = King.new([0, 3])
    @grid[0][4] = Queen.new([0, 4])
    @grid[0][5] = Bishop.new([0, 5])
    @grid[0][6] = Knight.new([0, 6])
    @grid[0][7] = Rook.new([0, 7])

    @grid[7][0] = Rook.new([7, 0])
    @grid[7][1] = Knight.new([7, 1])
    @grid[7][2] = Bishop.new([7, 2])
    @grid[7][3] = King.new([7, 3])
    @grid[7][4] = Queen.new([7, 4])
    @grid[7][5] = Bishop.new([7, 5])
    @grid[7][6] = Knight.new([7, 6])
    @grid[7][7] = Rook.new([7, 7])

    @grid[1][0] = Pawn.new([1, 0])
    @grid[1][1] = Pawn.new([1, 1])
    @grid[1][2] = Pawn.new([1, 2])
    @grid[1][3] = Pawn.new([1, 3])
    @grid[1][4] = Pawn.new([1, 4])
    @grid[1][5] = Pawn.new([1, 5])
    @grid[1][6] = Pawn.new([1, 6])
    @grid[1][7] = Pawn.new([1, 7])

    @grid[6][0] = Pawn.new([6, 0])
    @grid[6][1] = Pawn.new([6, 1])
    @grid[6][2] = Pawn.new([6, 2])
    @grid[6][3] = Pawn.new([6, 3])
    @grid[6][4] = Pawn.new([6, 4])
    @grid[6][5] = Pawn.new([6, 5])
    @grid[6][6] = Pawn.new([6, 6])
    @grid[6][7] = Pawn.new([6, 7])
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

  def still_in_check(move)
    test_board = self.deep_dup
    test_board.update_board(move[0],move[1])

    player_in_check = test_board.grid[move[1][0]][move[1][1]].player_id

    enemy_pieces = []
    test_board.grid.each_with_index do |row, j|
      row.each_index do |i|
        enemy_piece = test_board.grid[j][i]
        next if enemy_piece.nil?
        next if enemy_piece.player_id == player_in_check
        enemy_pieces << enemy_piece
      end
    end

    still_in_check = enemy_pieces.any? do |e_piece|
      test_board.check(e_piece.location)
    end

    return false if !still_in_check
  end

  def checkmate(loc)
    return false if check(loc) == false
    enemy = @grid[loc[0]][loc[1]].player_id

    @grid.each_with_index do |row, y|
      row.each_index do |x|
        piece = @grid[y][x]
        next if piece.nil?
        next if piece.player_id == enemy
        possible_moves = piece.move(self)
        possible_moves.each do |move|

          test_board = self.deep_dup
          test_board.update_board(piece.location,move)

          #is new test_board still in check?
          # return true if *any* enemy has king in check
          enemy_pieces = []
          test_board.grid.each_with_index do |row, j|
            row.each_index do |i|
              enemy_piece = test_board.grid[j][i]
              next if enemy_piece.nil?
              next if enemy_piece.player_id != enemy
              enemy_pieces << enemy_piece
            end
          end

          still_in_check = enemy_pieces.any? do |e_piece|
            test_board.check(e_piece.location)
          end

          return false if !still_in_check
        end
      end
    end
    true
    #return checkmate #remove "return"
  end

  def deep_dup
    new_board = Board.new
    new_board.grid.each_with_index do |row, y|
      row.each_index do |x|
        new_board.grid[y][x] = nil
      end
    end

    @grid.each_with_index do |row, y|
      row.each_index do |x|
        next if @grid[y][x].nil?
        new_board.grid[y][x] = @grid[y][x].dup_piece
      end
    end
    new_board
  end


end #End of board class