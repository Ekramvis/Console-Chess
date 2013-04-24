class Player

  def input
    puts "Enter a start position"
    start = gets.chomp.split(" ")
    start[0] = start[0].to_i
    start[1] = start[1].to_i

    puts
    puts "Enter a stop position"
    stop = gets.chomp.split(" ")
    stop[0] = stop[0].to_i
    stop[1] = stop[1].to_i

    [start, stop]
  end


end #end Player class