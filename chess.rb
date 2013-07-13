require_relative 'board.rb'
require_relative 'player.rb'
require_relative 'piece.rb'
require_relative 'pawn.rb'
require_relative 'king.rb'
require_relative 'queen.rb'
require_relative 'bishop.rb'
require_relative 'rook.rb'
require_relative 'knight.rb'


class Game
  attr_accessor :board

  def initialize
    @p1 = Player.new("White")
    @p2 = Player.new("Black")
    @board = Board.new
    @current_player = @p2
    @move = [[0,0],[0,0]]
    turn_loop
  end

  def turn_loop
    until @board.checkmate(@move[1])
      @board.display_board
      @current_player = @current_player == @p1 ? @p2 : @p1

      if @board.check(@move[1])
        last_move = @move[1]
        puts @current_player.color + ", you are in check."
        until @board.validate_move(@move[0], @move[1], @current_player.color) && !@board.check(last_move)
          2.times { puts "" }
          @move = @current_player.input
          break unless @board.still_in_check?(@move)
          puts "Still in check."
        end
        puts "you got out of check!"

      else
        2.times { puts "" }
        @move = @current_player.input
        until @board.validate_move(@move[0], @move[1], @current_player.color)
          puts ""
          puts "Not a valid move, please try again"
          puts ""
          @move = @current_player.input
        end

      end
      @board.update_board(@move[0], @move[1])
    end

    @board.display_board
    puts "The game is over: " + @current_player.color + " wins!"
  end

end 


Game.new