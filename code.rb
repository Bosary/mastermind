class Code
  COLORS = ['Blank', 'White', 'Black', 'Blue', 'Red', 'Green', 'Yellow']

  def self.create_secret
    @secret = []
    4.times do 
      @secret << COLORS.sample
    end
    puts @secret
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

  def self.check(guess)
    clues = []
    temp_guess = guess.map(&:clone)
    temp_secret = @secret.map(&:clone)

    temp_guess.each_index do |i|
      if temp_guess[i] == temp_secret[i]
        clues << "Bullseye"
        temp_guess[i] = "*"
        temp_secret[i] = "-"
      end
    end

    temp_guess.each_with_index do |color, i|
      if temp_secret.include?(temp_guess[i])
        clues << "Almost"
        temp_guess[i] = "*"
        temp_secret[temp_secret.index(color)] = "-"
      end
    end
  
    clues.shuffle
  end

  def self.victory?(guess)
    @secret == guess ? true : false
  end
end