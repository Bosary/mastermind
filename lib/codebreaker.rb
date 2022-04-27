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
    when "Easy", "Normal"
      # Easy and Normal AI use similar logic, the only difference is in the hints interpretation
      return normal_guess(codebreaker, last_guess, hints)
    #when "Hard"
    #  guess = hard_guess(codebreaker)
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
    reduced_pool = COLORS.difference(@@absent_color.concat(@@sure_colors))
    4.times { guess << reduced_pool.sample }
    return guess
  end

  def precise_guess 
    # Will add a precise guess later.
    # For now, shuffle will do
    return @@sure_colors.shuffle
  end

  def normal_guess(codebreaker, last_guess, hints)
    # Easy and Normal AI logic
    puts "#{codebreaker.name} is trying to break the code"
    check_hints(codebreaker.difficulty, last_guess, hints) unless last_guess.nil?

    # Got the 4 colors of the secret code
    if @@sure_colors.length == 4
      return precise_guess
    end

    # No saved possible colors
    if @@possible_colors.empty?
      return random_guess
    end

    # @@possible_colors not empty, try 1 color 4 times
    guess = []
    4.times { guess << @@possible_colors[0] }
    @@possible_colors.shift
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
      condition = !hints.empty? # Meaning hints include "Good" or "Perfect"
    end

    if condition
      # 1 or more Perfect with 4 times same color
      if last_guess.uniq.length == 1
        hints.count("Perfect").times { @@sure_colors << last_guess[0] }
        # This part is use when AI test the possible colors
        @@needed_tries -= 1 if @@needed_tries > 0
        @@possible_colors.clear if @@needed_tries == 0

      else # 1 or more Perfect with at least 2 different colors
        last_guess.uniq.each { |color| @@possible_colors << color }
        @@needed_tries = hints.length
      end
    end
  end


end