class Piece

  attr_accessor :location, :king

  def initialize(location)
    @location = location #array of [y, x]
    @location[0] > 5  ? @player_id = "White" : @player_id = "Black"
    @king = false
  end

  def move(board)
  end

end # end Piece class