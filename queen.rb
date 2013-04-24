class Queen < Piece

  attr_accessor :location, :player_id, :king

  def initialize(location)
    super(location)
    generate_deltas
  end

  def generate_deltas
    #makes all moves in all directions, also off board
    y = location[0]
    x = location[1]
    @deltas = []
    8.times do |n|
      next if n == 0
      @deltas << [y + n, x]
      @deltas << [y - n, x]
      @deltas << [y, x + n]
      @deltas << [y, x - n]
    end
    @deltas
  end

  def display_self
    print "Q|"
  end

  def move(board)
    generate_possible_moves(board)
  end

  def generate_possible_moves(board)
    deltas = generate_deltas

    on_board_moves = on_board(deltas)
    self_square_moves = self_squares(on_board_moves, board)
    # enemy_square_moves = enemy_squares(self_square_moves, board)
  end

  def on_board(deltas)
    deltas.select do |delta|
      delta[0].between?(0, 7) && delta[1].between?(0, 7)
    end
  end

  def self_squares(on_board_moves, board)
    left, right, up, down = nil, nil, nil, nil
    ymax, ymin, xmax, xmin = [], [], [], []

    #limit moves based on lrud based on positions of friends
    y = self.location[0]
    x = self.location[1]

    on_board_moves.sort_by! { |move| move[0] }

    if y == 7
      up = 7
    else
      (y+1).upto(on_board_moves.last[0]) do |n|

        unless board.grid[n][x].nil?
          unless board.grid[n][x].player_id != self.player_id
            ymax << board.grid[n][x].location[0]
          end
        end
      end

      ymax[0].nil? ? up = 7 : up = ymax[0]
    end

    if y == 0
      down = 0
    else
      (y-1).downto(on_board_moves.first[0]) do |n|

        unless board.grid[n][x].nil?
          unless board.grid[n][x].player_id != self.player_id
            ymin << board.grid[n][x].location[0]
          end
        end

      end
      ymin[0].nil? ? down = 0 : down = ymin[0]
    end

    on_board_moves.sort_by! { |move| move[1] }

    if x == 7
      right = 7
    else
      (x+1).upto(on_board_moves.last[1]) do |n|

        unless board.grid[y][n].nil?
          unless board.grid[y][n].player_id != self.player_id
            xmax << board.grid[y][n].location[0]
          end
        end


      end
      xmax[0].nil? ? right = 7 : right = xmax[0]
    end

    if x == 0
      left = 0
    else
      (x-1).downto(on_board_moves.first[1]) do |n|

        unless board.grid[y][n].nil?
          unless board.grid[y][n].player_id != self.player_id
            xmin << board.grid[y][n].location[0]
          end
        end


      end
      left = xmin[0]
      xmin[0].nil? ? left = 0 : left = xmin[0]
    end

    on_board_moves.select! do |move|
      move[0] < up && move[0] > down && move[1] < right && move[1] > left
    end

    on_board_moves
  end

  def enemy_squares(self_square_moves, board)
    left, right, up, down = nil, nil, nil, nil
    ymax, ymin, xmax, xmin = [], [], [], []

    #limit moves based on lrud based on positions of friends
    y = self.location[0]
    x = self.location[1]

    self_square_moves.sort_by! { |move| move[0] }

    if y == 7
      up = 7
    else
      (y+1).upto(self_square_moves.last[0]) do |n|
        ymax << board.grid[n][x].location[0] unless board.grid[n][x].nil?
      end
      ymax[0].nil? ? up = 7 : up = ymax[0]
    end

    if y == 0
      down = 0
    else
      (y-1).downto(self_square_moves.first[0]) do |n|
        ymin << board.grid[n][x].location[0] unless board.grid[n][x].nil?
      end
      ymin[0].nil? ? down = 0 : down = ymin[0]
    end

    self_square_moves.sort_by! { |move| move[1] }

    if x == 7
      right = 7
    else
      (x+1).upto(self_square_moves.last[1]) do |n|
        xmax << board.grid[y][n].location[1] unless board.grid[y][n].nil?
      end
      xmax[0].nil? ? right = 7 : right = xmax[0]
    end

    if x == 0
      left = 0
    else
      (x-1).downto(self_square_moves.first[1]) do |n|
        xmin << board.grid[y][n].location[1] unless board.grid[y][n].nil?
      end
      left = xmin[0]
      xmin[0].nil? ? left = 0 : left = xmin[0]
    end
    puts "up = #{up}, down = #{down}, left = #{left}, right = #{right}"
    puts "self_square_moves = #{self_square_moves}"
    self_square_moves.select! do |move|
      move[0] <= up && move[0] >= down && move[1] <= right && move[1] >= left
    end

    self_square_moves

  end

  def dup_piece
    new_queen = Queen.new(self.location)
    new_queen.player_id = self.player_id
    new_queen
  end
end