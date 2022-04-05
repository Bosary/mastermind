class Code
  COLORS = ['Blank', 'White', 'Black', 'Blue', 'Red', 'Green', 'Yellow']

  def self.create_secret
    secret_code = []
    4.times do 
      secret_code << COLORS.sample
    end

    secret_code
  end

  def self.guess
    guess_code = []
    puts "Pick a color: #{COLORS.join(', ')}"
    4.times do
      input = gets.chomp
      guess_code << input
    end
    guess_code
  end

  def self.check(secret, guess)
    clues = []
    
    if guess == secret
      return "victory"
    end

    # Add clues
    guess.each do |color|
      if secret.include?(color)
        if secret.index(color) == guess.index(color)
          clues << "Bullseye"
        else
          clues << "Good"
        end
      else
        clues << "Miss"
      end
    end

    clues
  end



end