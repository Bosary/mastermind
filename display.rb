require 'terminal-table'

class Display
  @@data = []

  def self.board(guess, clues)
    @@data << :separator unless @@data.empty?

    # ASCII table config
    @@data << [guess.join(', '), clues.join(', ')]
    board = Terminal::Table.new :rows => @@data
    board.align_column(0, :center)
    board.align_column(1, :center)
    headings = [
      {:value => "Guess", :alignment => :center},
      {:value => "Clues", :alignment => :center}
    ]
    board.headings = headings
    puts "\n\n#{board}\n\n"
  end
end

