class Pawn < Piece

  attr_accessor :location, :player_id, :king, :first_move

  def initialize(location)
    super(location)
    generate_deltas
    @first_move = true
  end

  def generate_deltas
    #makes all moves in all directions, also off board
    y = self.location[0]
    x = self.location[1]
    if @player_id == "White"
      @deltas = [[y-1,x],[y-1,x-1],[y-1,x+1]]
      if @first_move 
        @deltas << [y-2,x] 
        @first_move = false
      end
    else
      @deltas = [[y+1,x],[y+1,x-1],[y+1,x+1]]
      if @first_move 
        @deltas << [y+2,x] 
        @first_move = false
      end
    end

    @deltas
  end

  def render
    print " P" + @player_id[0].downcase + " |"
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

  def dup_piece
    new_pawn = Pawn.new(self.location)
    new_pawn.player_id = self.player_id
    new_pawn
  end

end # end Pawn class






