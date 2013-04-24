class Pawn < Piece

  attr_accessor :location, :player_id, :king

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

end # end Pawn class






