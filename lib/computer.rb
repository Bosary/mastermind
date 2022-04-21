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
    when 'easy'
      name = "Stupidator"
    when 'normal'
      name = "Rambozer"
    when 'hard'
      name = "Godzi"
    else
      p "Error"
    end
    return name
  end
end