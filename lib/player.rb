class Player

  attr_reader :name, :difficulty
  attr_accessor :score
  def initialize(name, difficulty = "Human")

    @difficulty = difficulty
    case difficulty
    when 'Easy'
      @name = "Stupidator"
    when 'Normal'
      @name = "Rambozer"
    when 'Hard'
      @name = "Godzi"
    else
      @name = name  # Human player
    end 
    @score = 0
  end
    
end