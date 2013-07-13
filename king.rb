class King < Piece

  attr_accessor :location, :king

  def initialize(location)
    super(location)
    generate_deltas
    @king = true
  end

  def generate_deltas
    #makes all moves in all directions, also off board
    y = self.location[0]
    x = self.location[1]

    @deltas = [
        [y-1,x], [y-1,x-1],[y-1,x+1],
        [y+1,x], [y+1,x-1], [y+1,x+1],
        [y, x+1], [y, x-1]
      ]
  end

  def render
    print " K" + @player_id[0].downcase + " |"
  end

  def move(board)
    generate_possible_moves(board)
  end

  def generate_possible_moves(board)
    deltas = generate_deltas

    on_board_moves = on_board(deltas)
    self_square_moves = self_squares(on_board_moves, board)
    check_safe_moves = check_safe(self_square_moves, board)
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

  def check_safe(self_square_moves, board)
    enemy_pieces = board.grid.flatten.compact.select { |piece| (piece.player_id != self.player_id) }
    enemy_moves = []

    enemy_pieces.each do |enemy|
      if enemy.king
        enemy_moves += enemy.generate_deltas 
      else
        enemy_moves += enemy.move(board)
      end
    end

    enemy_moves.uniq!

    self_square_moves.select do |move|
      !enemy_moves.include?(move)
    end
  end

  def dup_piece
    new_king = King.new(self.location)
    new_king.player_id = self.player_id
    new_king
  end

end #end King class