def render_ascii
  file_path = File.join(__dir__, 'ascii_art.txt')
  File.open(file_path).readlines.each do |line|
    puts line
  end
end


render_ascii
puts "\n\nWelcome to my mastermind project! Let's start!!!\n\n"
puts "\n\nWith the settings........ \n\n"

require_relative "lib/game"

game = Game.new
 
puts game.p1.name
puts game.p2.name
puts game.difficulty