require_relative "player"
require_relative "computer"


class Game
  attr_reader :p1, :p2, :difficulty, :codemaker, :nbr_players

  def initialize
    settings = set_settings

    @nbr_players = settings[:nbr_p]
    @p1 = Player.new(settings[:p1])

    if @nbr_players == '1'
      @p2 = Computer.new(settings[:difficulty])
      @difficulty = settings[:difficulty]
    else
      @p2 = Player.new(settings[:p2])
    end

    @codemaker = settings[:codemaker]  #True => player 1, False => player 2
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

    choice_role == 'y' ? (codemaker = true) : (codemaker = false)

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
        difficulty = "easy"
      when '2'
        difficulty = "normal"
      when '3'
        difficulty = "hard"
      else
        p "Error, notify me pretty please :)"
      end

      p2_name = ""

    else
      difficulty = ""
    end

    # Full data
    settings = {
      nbr_p: choice_nbr,
      p1: p1_name,
      p2: p2_name,
      codemaker: codemaker,
      difficulty: difficulty
     }

    return settings
      
  end
end