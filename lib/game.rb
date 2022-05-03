require_relative "player"
require_relative "codemaker"
require_relative "codebreaker"
require_relative "display"
require_relative "settings"


class Game
  include CodeMaker, CodeBreaker, Display, Settings

  
  def initialize
    # Put the settings as it's own Module for clarity
    settings = set_settings  #{p1: p1_name, p2: p2_name, p1_codemaker: p1_codemaker, difficulty: difficulty}

    if settings[:p1_codemaker]
      @codemaker = Players.new(settings[:p1])
      @codebreaker = Players.new(settings[:p2], settings[:difficulty])
    else
      @codemaker = Players.new(settings[:p2], settings[:difficulty])
      @codebreaker = Players.new(settings[:p1])
    end
    
    play_match
  end

  def play_match
    secret = create_secret_code(@codemaker)
    # If 2 humans, call display to hide the secret code input
    display_codebreaker_logo if ( @codemaker.difficulty == @codebreaker.difficulty )

    #Main loop
    victory = false
    turns = 0
    hints = [] # Needed for CodeBreaker::guess_code 1st call
    until victory || turns == 12
    turns += 1
    puts "\nTurn #{turns}"

    guess = guess_code(@codebreaker, guess, hints) # Random guess on turn 1 for easy/normal AI
    hints = get_hints(secret, guess)
    display_board(guess, hints)

    victory = victory?(guess, secret)
    sleep(1) unless (@codebreaker.difficulty == "Human") # Only when Computer try to break the code
    end

    end_game(victory, turns, secret)
  end

  def get_hints(secret, guess) 
    puts "Explanation: 'Perfect' = perfect match color/position. 'Good' = Color match but wrong position"
    hints = []
    # Need to clone secret_code to modify the array 
    clone_secret = secret.map(&:clone)
    clone_guess = guess.map(&:clone)

    # Check for perfect match first, remove the matches from clones
    guess.each_with_index do |color, index|
      if guess[index] == secret[index]
        hints << "Perfect"
        clone_secret.delete_at(clone_secret.index(color))
        clone_guess.delete_at(clone_guess.index(color))
      end
    end

    # Check for partial match using clone array
    clone_guess.each do |color|
      if clone_secret.include?(color)
        hints << "Good"
        clone_secret.delete_at(clone_secret.index(color))
      end
    end
    
    return hints
  end

  def victory?(guess, secret)
    guess == secret ? (return true) : (return false)
  end

  def end_game(victory, turns, secret)

    # For 2 players, victory/defeat is from the view of the codebreaker
    if @codemaker.difficulty == @codebreaker.difficulty
      if victory
        display_victory
        puts "\n\nAll hail the mighty #{@codebreaker.name} for cracking the code in #{turns} turns !!"
        puts "Better luck next time #{@codemaker.name}"
      else
        display_defeat
        puts "\n\n#{@codemaker.name} is the true mastermind! Kneel in front of his power"
        puts "I can give you some training #{@codebreaker.name} for only $999.99"
        puts "\nThe secret code was #{secret}"
      end
    else # 1 player mode, victory is from the view of the player
      if (@codemaker.difficulty == "Human" && !victory) || (@codebreaker.difficulty == "Human" && victory)
        display_victory
        puts "\n\nCongratulations #{@codemaker.name}! You're awesome!"
      else
        display_defeat
        puts "\n\nMachines are already in charge! Surrender #{@codemaker.name}"
        puts "\nThe secret code was #{secret}"
      end
    end
  end
end