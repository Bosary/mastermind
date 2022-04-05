require_relative "./code"
require_relative "./display"

class Game
  attr_accessor :guess, :clues
  @@victory = false

  def initialize
    Code.create_secret
  end

  def start_game
    turn = 0
    while turn <= 10
    play_turn
    turn += 1
    break if @@victory
    end

    end_game(turn)
  end

  def play_turn
    guess = Code.guess
    clues = Code.check(guess)
    Display.board(guess, clues)
    @@victory = Code.victory?(guess)
  end

  def end_game(turn)
    if @@victory
      puts "You won in #{turn} turn(s)"
    else
      puts "You lose"
    end
  end
end