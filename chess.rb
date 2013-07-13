# encoding: utf-8

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
    @p1 = Player.new
    @p2 = Player.new
    @board = Board.new
    @current_player = @p2
    @move = [[1,0],[1,0]]
    turn_loop
  end

  def turn_loop
    until @board.checkmate(@move[1])
      @board.display_board
      @current_player == @p1 ? @p2 : @p1

      if @board.check(@move[1])
        until @board.validate_move(@move[0], @move[1]) && !@board.check(@move[1])
          puts "Please enter a start, stop"
          @move = @current_player.input
          @move = @current_player.input
          break unless @board.still_in_check?(@move)
          puts "Still in check."
        end
        puts "you got out of check!"

      else
        puts "Please enter a start, stop"
        @move = @current_player.input
        until @board.validate_move(@move[0], @move[1])
          puts "Not valid, try again"
          @move = @current_player.input
        end

      end
      @board.update_board(@move[0], @move[1])
    end

    puts "Game is over"
  end


end # end Game class


