class Player

  attr_reader :name, :human
  attr_accessor :score

  def initialize(name)
    @name = name
    @human = true
    @score = 0
  end
end