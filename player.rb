class Player

  def input
    puts "Enter a start position"
    start = gets.chomp

    puts
    puts "Enter a stop position"
    stop = gets.chomp

    [start, stop]
  end


end #end Player class