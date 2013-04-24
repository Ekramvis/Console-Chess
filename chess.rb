require_relative 'board.rb'
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
    # init 2 player objects
    @board = Board.new
    #game_loop
  end



end # end Game class


