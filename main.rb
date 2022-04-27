#Mastermind project

# terminal-table gem is needed to display the board game

require_relative 'lib/display'
include Display

display_logo
puts "\n\nWelcome to my mastermind project! Let's start!!!\n\n"
puts "\n\nWith the settings........ \n\n"

require_relative "lib/game"

game = Game.new


