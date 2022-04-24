class Computer
  attr_reader :name, :human
  attr_accessor :score

  def initialize(difficulty)
    @difficulty = difficulty
    @name = get_name(difficulty)
    @score = 0
    @human = false
  end

  def get_name(difficulty)
    case difficulty
    when 'Easy'
      name = "Stupidator"
    when 'Normal'
      name = "Rambozer"
    when 'Hard'
      name = "Godzi"
    else
      p "Error, difficulty Computer Class"
    end
    return name
  end
end