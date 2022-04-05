require_relative "./code"
require_relative "./display"

class Game
  attr_accessor :guess, :clues

  def initialize
    Code.create_secret
  end

  def start_game
    turn = 0
    @@victory = false
    while turn <= 10 || victory
    play_turn
    turn += 1
    end
    end_game
  end

  def play_turn
    guess = Code.guess
    clues = Code.check(guess)
    Display.board(guess, clues)
    Code.victory?(guess)
  end

  def end_game
    if @@victory
      puts "You win"
    else
      puts "You lose"
    end
  end
end