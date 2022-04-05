require 'terminal-table'

class Display
  @@data = []

  def self.board(guess, clues)
    @@data << [guess.join(', '), clues.join(', ')]
    
    board = Terminal::Table.new :headings => ['Guess', 'Clues'], :rows => @@data
    board.align_column(0, :center)
    board.align_column(1, :center)
    puts "\n\n#{board}\n\n"
  end
end

