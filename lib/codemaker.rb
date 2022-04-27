module CodeMaker
  COLORS = ["Blue", "Green", "Red", "Yellow", "Black", "White", "Purple"]

  def create_secret_code(codemaker)
    if codemaker.difficulty == "Human"
      return human_secret(codemaker)
    else 
      return computer_secret(codemaker)
    end
  end

  def human_secret(codemaker)
    puts "#{codemaker.name}, use this colors to make up the secret code please: #{COLORS}"

    code = []
    4.times do |i|
      puts "Enter color #{i + 1}:"
      choice_color = gets.chomp.downcase.capitalize 

      # Input check
      until COLORS.include?(choice_color)
        puts "Oops, did a typo ? Please pick a color from this list: #{COLORS}"
        choice_color = gets.chomp.downcase.capitalize
      end

      code << choice_color
    end

    return code
  end

  def computer_secret(codemaker)
    puts "#{codemaker.name} is choosing the secret code"
    code = []
    4.times do 
      code << COLORS.sample
    end
    
    return code
  end
end