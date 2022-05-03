module Settings

  def set_settings
    # Numbers of players + names
    puts "First, let's check the number of players:
    -Press 1 for a 1 player experience
    -Press 2 if you have a friend willing to play with you.\n"
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
      difficulty = "Human"
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
      p2_name = ""
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
        difficulty = "Normal"  #Hard not implemented yet
      else
        p "Error, Settings::set_settings"
      end
    end

    # Last prompt
    puts "\nAll done! Let's play!!\n\n"

    # Full data
    settings = {
      p1: p1_name,
      p2: p2_name,
      p1_codemaker: p1_codemaker,
      difficulty: difficulty
     }

    return settings
      
  end


end