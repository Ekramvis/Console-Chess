class Queen < Piece

  attr_accessor :location, :player_id, :king

  def initialize(location)
    super(location)
    @dirs = [
      :left,
      :right,
      :up,
      :down,
      :left_up,
      :left_down,
      :right_up,
      :right_down
    ]
  end


  def render
    print " Q" + @player_id[0].downcase + " |"
  end

  def move(board)
    moves = []

    @dirs.each do |dir|
      moves << generate_possible_moves(board, dir)
    end

    moves.flatten(1)
  end

  def generate_possible_moves(board, dir)
    y = self.location[0]
    x = self.location[1]

    possible_moves = []

    case dir
    when :left
      space_to_go = x - 0
      block_x = Proc.new { |a, b| a - b }
      block_y = Proc.new { |a, b| a }
    when :right
      space_to_go = 7 - x
      block_x = Proc.new { |a, b| a + b }
      block_y = Proc.new { |a, b| a }
    when :up
      space_to_go = y - 0
      block_y = Proc.new { |a, b| a - b }
      block_x = Proc.new { |a, b| a }
    when :down
      space_to_go = 7 - y
      block_y = Proc.new { |a, b| a + b }
      block_x = Proc.new { |a, b| a }
    when :left_up
      space_to_go = [x - 0, y - 0].min
      block_x = Proc.new { |a, b| a - b }
      block_y = Proc.new { |a, b| a - b }
    when :left_down
      space_to_go = [x - 0, 7 - y].min
      block_x = Proc.new { |a, b| a - b }
      block_y = Proc.new { |a, b| a + b }
    when :right_up
      space_to_go = [7 - x, y - 0].min
      block_x = Proc.new { |a, b| a + b }
      block_y = Proc.new { |a, b| a - b }
    when :right_down
      space_to_go = [7 - x, 7 - y].min
      block_x = Proc.new { |a, b| a + b }
      block_y = Proc.new { |a, b| a + b }
    end

    return possible_moves if space_to_go == 0

    (space_to_go+1).times do |n|
      next if n == 0
      if board.grid[block_y.call(y,n)][block_x.call(x,n)].nil?
        possible_moves << [block_y.call(y,n), block_x.call(x,n)]
      elsif board.grid[block_y.call(y,n)][block_x.call(x,n)].player_id != self.player_id
        possible_moves << [block_y.call(y,n), block_x.call(x,n)]
        break
      else
        break
      end
    end

    possible_moves
  end


  def dup_piece
    new_queen = Queen.new(self.location)
    new_queen.player_id = self.player_id
    new_queen
  end
end