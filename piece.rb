class Piece

  attr_accessor :location, :king # REV: add :player_id so your subclasses dont have to repeat this

  def initialize(location)
    @location = location #array of [y, x]
    @location[0] > 5  ? @player_id = "White" : @player_id = "Black"
    @king = false # REV: can do x = ExampleClass.new; x.class == ExampleClass; even if ExampleClass < ExampleParent
  end

  def move(board)
  end

  def dup_piece # REV: .dup does the same thing
  end

end # end Piece class