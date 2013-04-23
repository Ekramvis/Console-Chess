class Piece

  attr_accessor :location

  def initialize(location)
    @location = location #array of [x, y]
    @location[0] > 5  ? @player_id = "White" : @player_id = "Black"
  end

  def move(board, stop)
  end

end # end Piece class