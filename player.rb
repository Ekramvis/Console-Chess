class Player
  attr_reader :color

  def initialize(color)
    @color = color
  end

  def input
    puts self.color + ", please enter a start and stop position (E.g. a7, a6)"
    move = gets.chomp

    move.gsub!(" ","")
    unless move =~ /^[a-zA-Z]\d,[a-zA-Z]\d$/
      return [[10,10],[10,10]]
    end   
    
    move = move.split(",")
    start = move[0].split("").reverse.map { |loc| converter(loc) }
    stop = move[1].split("").reverse.map { |loc| converter(loc) }

    [start, stop]
  end

  def converter(loc)
    case loc.downcase
      when "a" then 0
      when "b" then 1
      when "c" then 2
      when "d" then 3
      when "e" then 4
      when "f" then 5
      when "g" then 6
      when "h" then 7
      when "8" then 0
      when "7" then 1
      when "6" then 2
      when "5" then 3
      when "4" then 4
      when "3" then 5
      when "2" then 6
      when "1" then 7
      else 10
    end
  end


end #end Player class