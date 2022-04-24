require 'terminal-table'

module Display
  @@data = []  # Stock the guess/hints data
  @@dir_path = File.join(File.expand_path('..', __dir__), 'ascii_arts')

  def display_logo
    file_path = File.join(@@dir_path, 'main_logo.txt')
    File.open(file_path).readlines.each do |line|
      puts line
    end
  end


  # To hide the secret_code input if 2 players mode, and for fun
  def display_codebreaker_logo
    file_path = File.join(@@dir_path, 'codebreaker_logo.txt')
    5.times do 
      File.open(file_path).readlines.each do |line|
        puts line
      end
    end
  end

  def display_board(guess, hints)
    @@data << [guess, hints]  #rows
    title = "Mastermind"
    headers = [
      {:value => 'Guess', :alignment => :center},
      {:value => 'Hints', :alignment => :center},
    ]
    table = Terminal::Table.new :title => title, :headings => headers, :rows => @@data
    table.style = {:all_separators => true}
    

    puts table
  end

  def display_victory
    file_path = File.join(@@dir_path, 'victory.txt')
    File.open(file_path).readlines.each do |line|
      puts line
    end
  end

  def display_defeat
    file_path = File.join(@@dir_path, 'defeat.txt')
    File.open(file_path).readlines.each do |line|
      puts line
    end
  end
end