# I decided to keep the logic for human and the 3 AI in the same module to avoid duplicate function issue
# This is the "heaviest" module of the project

module CodeBreaker 
  COLORS = ["Blue", "Green", "Red", "Yellow", "Black", "White", "Purple"]
  # Use for AI solving logic
  @@possible_colors = []  # <= May be in the secret code
  @@absent_color = []     # <= Is definitely not in the secret code
  @@sure_colors = []      # <= Is definitely in the secret code
  @@needed_tries = []     # <= Tries based on hints feedback to turn a possible_color into a sure_color

  def guess_code(codebreaker, last_guess = [], hints = [])
    # AI reuse the last turn guess/hints to determine the next move
    case codebreaker.difficulty
    when "Human"
      return human_guess(codebreaker)
    when "Easy", "Normal" # Easy and Normal AI use similar logic, the only difference is in the hints interpretation
      puts "#{codebreaker.name} is trying to break the code"
      return normal_guess(codebreaker, last_guess, hints)
    when "Hard"
      puts "#{codebreaker.name} will break the code (seriously, you can't win)"
      guess = hard_guess(codebreaker, last_guess, hints)
    else
      puts "Error CodeBreaker::guess_code"
    end
  end

  def human_guess(codebreaker)
    puts "Time to try and break the code #{codebreaker.name}! Pick colors from this list: #{COLORS}"
    
    guess = []
    4.times do |i|
      puts "Enter color #{i + 1}:"
      choice_color = gets.chomp.downcase.capitalize

      # Input Check
      until COLORS.include?(choice_color)
        puts "Oops, did a typo ? Please pick a color from this list: #{COLORS}"
        puts "Enter color #{i + 1}"
        choice_color = gets.chomp.downcase.capitalize
      end
      guess << choice_color
    end

    return guess
  end

  def random_guess
    # Use only by easy/normal AI on first turn or when no possible colors
    # Use a reduced pool of colors as AI eliminate colors
    guess = []
    reduced_pool = COLORS.difference(@@absent_color + @@sure_colors)
    4.times { guess << reduced_pool.sample }
    return guess
  end

  def precise_guess 
    # Will add a precise guess later. Keeping track of position will take a lot of work.
    # For now, shuffle will do
    return @@sure_colors.shuffle
  end

  def normal_guess(codebreaker, last_guess, hints) # Easy and Normal AI logic
    check_hints(codebreaker.difficulty, last_guess, hints) unless last_guess.nil?

    # Got the 4 colors of the secret code
    if @@sure_colors.length == 4
      return precise_guess
    end

    # No saved possible colors
    if @@possible_colors.empty?
      return random_guess
    end

    # @@possible_colors not empty, try 1 color 4 times then remove it from the list
    guess = []
    color_test = @@possible_colors.sample
    4.times { guess << color_test }
    @@possible_colors.delete(color_test)
    return guess

  end

  def check_hints(difficulty, last_guess, hints)
    # No hints at all, remove colors
    if hints.empty?
      last_guess.uniq.each { |color| @@absent_color << color }
      return
    end

    # EasyAI need a "Perfect" to start the solving logic, it ignores "Good"
    if difficulty == "Easy"
      condition = hints.include?("Perfect")
    else
      condition = hints.include?("Perfect") || hints.include?("Good") # NormalAI and HardAI start with a "Good" or "Perfect"
    end
    if condition
      if last_guess.uniq.length == 1  # 4 times same color
        hints.count("Perfect").times { @@sure_colors << last_guess[0] }
        # This part is use when AI test the possible colors
        @@needed_tries -= 1 if @@needed_tries > 0
        @@possible_colors.clear if @@needed_tries == 0

      else # At least 2 different colors
        last_guess.uniq.each { |color| @@possible_colors << color }
        @@needed_tries = hints.length # Based on the number of hints (good or perfect)
      end
    end
  end

  def hard_guess(codebreaker, last_guess, hints)
    # HardAI solve the game methodically
    # Use 2*2 colors until getting the 4 sure colors, 
    # check for matches, if any reuse 1 of the 2 previous colors with a new pair
    # Keep going until finding the 4 colors
    check_hints(codebreaker.difficulty, last_guess, hints) unless last_guess.nil?

    # Got the 4 colors of the secret code
    if @@sure_colors.length == 4
      return precise_guess
    end

    # No saved possible colors
    if @@possible_colors.empty?
      return methodic_guess
    end
  end

  def methodic_guess
    # Only use by hard AI on first turn or when no possible colors
    # Use a reduced pool of colors as AI eliminate colors
    guess = []
    reduced_pool = COLORS.difference(@@absent_color + @@sure_colors)
    color1 = reduced_pool.sample
    until color2 != color1
      color2 = reduced_pool.sample
    end
    guess.push(color1, color1, color2, color2)
    return guess
  end

  def check_hints_hard(last_guess, hints)
    # No hints at all, remove colors
    if hints.empty?
      last_guess.uniq.each { |color| @@absent_color << color }
      return
    else
      case hints.length
      when 4
        last_guess.each { |color| @@sure_colors << color }
      when 3
        last.guess.uniq.each { |color| @@sure_colors << color }
      when 1, 2
        last_guess.uniq.each { |color| @@possible_colors << color }
      else
        puts "Error CodeBreaker::check_hints_hard"
      end


    


  end

end