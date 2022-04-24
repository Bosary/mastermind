require_relative "player"
require_relative "computer"
require_relative "code"
require_relative "display"


class Game
  include Code, Display

  def initialize

    @turns = 0
    settings = set_settings

    @difficulty = settings[:difficulty] #Use for creating secret/guess code
    @nbr_players = settings[:nbr_p]
    @p1 = Player.new(settings[:p1])

    if @nbr_players == '1'
      @p2 = Computer.new(@difficulty)
    else
      @p2 = Player.new(settings[:p2])
    end

    @p1_codemaker = settings[:p1_codemaker]
    if @p1_codemaker
      @codemaker = @p1.name
      @codebreaker = @p2.name
    else
      @codemaker = @p2.name
      @codebreaker = @p1.name
    end
    
  end

  def set_settings
    # Numbers of players + names
    puts "First, let's check the number of players:
    -Press 1 for a 1 player experience
    -Press 2 to lose a friend\n"

    choice_nbr = gets.chomp
    until (choice_nbr == '1' || choice_nbr == '2')
      puts "Wrong input. Pick 1 or 2 please.\n"
      choice_nbr = gets.chomp
    end

    if choice_nbr == '1'
      puts "\nYou picked 1 player mode."
      puts "\nHow should I call you?"
      p1_name = gets.chomp
      puts "Pleasure to meet you #{p1_name}."
    else
      puts "\nYou picked 2 players mode."
      puts "\nEnter a name for player 1 please: "
      p1_name = gets.chomp
      puts "\nNow for player 2 please: "
      p2_name = gets.chomp
      puts "Welcome aboard #{p1_name} and #{p2_name}"
    end

    # Picking the role
    puts "\n#{p1_name}, would you like to be the codemaker? (y/n)"
    choice_role = gets.chomp.downcase
    until (choice_role == 'y' || choice_role == 'n')
      puts "\nSorry, seems like you missed the letter. Enter 'y' or 'n' please"
      choice_role = gets.chomp.downcase
    end

    choice_role == 'y' ? (p1_codemaker = true) : (p1_codemaker = false)

    # Pick difficulty
    if choice_nbr == '1'
      puts "\nLast one. Please pick a difficulty:
      -Press 1 to face Stupidator
      -Press 2 for Rambozer
      -Press 3 for Mega_Godzilla_Master_Of_The_World (or 'Godzi' for short)"
      choice_diff = gets.chomp
      until (choice_diff == '1' || choice_diff == '2' || choice_diff == '3')
        puts "\nWrong input. Enter 1 (easy), 2( normal), or 3 (hard) please"
        choice_diff = gets.chomp
      end

      case choice_diff
      when '1'
        difficulty = "Easy"
      when '2'
        difficulty = "Normal"
      when '3'
        difficulty = "Hard"
      else
        p "Error, notify me pretty please :)"
      end

      p2_name = ""

    else
      difficulty = "Human"
    end

    # Last prompt
    puts "\nAll done! Let's play!!\n\n"

    # Full data
    settings = {
      nbr_p: choice_nbr,
      p1: p1_name,
      p2: p2_name,
      p1_codemaker: p1_codemaker,
      difficulty: difficulty
     }

    return settings
      
  end

  def play_match
    @secret_code = create_secret_code(@p1_codemaker, @codemaker, @difficulty)
    display_codebreaker_logo if @nbr_players == '2'

    @victory = false
    until @victory || @turns == 10
    @turns += 1
    puts "\nTurn #{@turns}"

    guess = guess_code(@p1_codemaker, @codebreaker, @difficulty)
    hints = get_feedback(@secret_code, guess)
    display_board(guess, hints)

    # if normal/hard send guess/hints to AI

    @victory = victory?(guess, @secret_code)
    sleep(1.5) if (@nbr_players == '1' && @p1_codemaker) # Only when Computer try to break the code
    end

    end_game
  end

  def end_game

    # For 2 players, victory/defeat is from the view of the codebreaker
    if @nbr_players == '2'
      if @victory
        display_victory
        puts "\n\nAll hail the mighty #{@codebreaker} for cracking the code in #{@turns} turns !!"
        puts "Better luck next time #{@codemaker}"
      else
        display_defeat
        puts "\n\n#{@codemaker} is the true mastermind! Kneel in front of his power"
        puts "I can give you some training #{@codebreaker} for only $999.99"
        puts "\nThe secret code was #{@secret_code}"
      end

    # 1 player mode, victory is from the view of the player
    else 
      if (!@p1_codemaker && @victory) || (@p1_codemaker && !@victory) # Player broke the code OR Computer failed
        display_victory
        puts "\n\nCongratulations #{@codemaker}! You're awesome!"
      else
        display_defeat
        puts "\n\nMachines are already in charge! Surrender #{@codemaker}"
        puts "\nThe secret code was #{@secret_code}"
      end
    end

  end

end