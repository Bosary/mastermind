module Code
  COLORS = ["Blue", "Green", "Red", "Yellow", "Black", "White", "Purple"]

  def create_secret_code(p1_codemaker, codemaker, difficulty)

    secret_code = []
    # Human
    if p1_codemaker || difficulty == "Human"
      puts "#{codemaker}, use this colors to make up the secret code please: #{COLORS}"

      4.times do |i|
        puts "Enter color #{i + 1}:"
        choice_color = gets.chomp.downcase.capitalize  # Case unsensitive

        until COLORS.include?(choice_color)
          puts "Oops, did a typo ? Please pick a color from this list: #{COLORS}"
          choice_color = gets.chomp.downcase.capitalize
        end

        secret_code << choice_color
      end

      return secret_code
    end

    #Computer
    unless difficulty == "Human" 
      puts "#{codemaker} is choosing the secret code"
      4.times do 
        secret_code << COLORS.sample
      end

      return secret_code
    end
  end

  def guess_code(p1_codemaker, codebreaker, difficulty)

    guess = []
    # Human
    if !p1_codemaker || difficulty == "Human"
      puts "Time to try and break the code #{codebreaker}! Pick colors from this list: #{COLORS}"
      4.times do |i|
        puts "Enter color #{i + 1}:"
        choice_color = gets.chomp.downcase.capitalize  # Case unsensitive
        until COLORS.include?(choice_color)
          puts "Oops, did a typo ? Please pick a color from this list: #{COLORS}"
          puts "Enter color #{i + 1}"
          choice_color = gets.chomp.downcase.capitalize
        end
        guess << choice_color
      end

      return guess
    end

    # Computer
    # Will add difficulty level later
    unless difficulty == "Human"
      puts "#{codebreaker} is trying to break the code"
      4.times do 
        guess << COLORS.sample
      end

      return guess
    end
  end

  def get_feedback(secret_code, guess)

    hints = []
    # Need to clone secret_code to modify the array 
    clone_secret = secret_code.map(&:clone)
    clone_guess = guess.map(&:clone)

    # Check for perfect match first, remove the matches from clones
    guess.each_with_index do |color, index|
      if guess[index] == secret_code[index]
        hints << "Perfect"
        clone_secret.delete(color)
        clone_guess.delete(color)
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

  def victory?(guess, secret_code)

    guess == secret_code ? (return true) : (return false)

  end

end