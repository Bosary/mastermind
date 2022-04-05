require_relative "./code"
require_relative "./display"

class Game
  attr_reader :secret
  attr_accessor :guess

  def initialize
    @secret = Code.create_secret
  end

  def play_turn
    puts @secret
    guess = Code.guess
    clues = Code.check(guess, @secret)
    clues == "victory" ? end_game : Display.board(guess, clues)

  end

  def end_game
    puts "You win"
  end
end