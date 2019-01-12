# Very basic hangman game

require "json"
class Hangman

  def initialize
    @secret_word = select_word
    @display_content = "_" * @secret_word.length
    @failed_attempts = 0
  end

  def main_menu
    option = "3"
    until option == "1" || option == "2"
      puts "(1) New game : -- )"
      puts "(2) Load game : -- O"
      print "Play new game or load saved game? : -- )"
      option = gets.chomp[0]
      if option == "2"
        if File.exist?("saved_state.json")
          load_state
        else
          puts "You don't have a saved game! >: -- ("
          option = "3"
        end
      end
    end
    start_game
  end

  private

  def start_game
    player_won = false
    while @failed_attempts != 10
      puts @display_content
      puts "#{10 - @failed_attempts.to_i} turns left"
      print "Enter a letter or attempt the full word : -- )"
      letters = gets.chomp
      update_display(letters) if letters
      player_won = player_won?
      break if player_won
    end
  puts "Game over! The word was the secret word was: #{@secret_word}" if @failed_attempts == 10
end

def select_word
  words = File.readlines("5desk.txt").select { |word| word.length.between?(5, 12) }
  words[rand(words.length)].strip
end

def update_display(letters)
  letters.downcase!

  current_state = @display_content.clone
    if letters.length == 1
      @display_content.length.times do |index|
        @display_content[index] = letters if @secret_word[index].downcase == letters
      end
    else
      @display_content = letters if letters == @secret_word.downcase
    end


    current_state == @display_content ? print_toon(1) : print_toon(0)
end

def player_won?
  unless @display_content.include?("_")
    puts "You got it! : -- )"
    true
  end
end

def print_toon(increment)
  @failed_attempts = @failed_attempts + increment

    case @failed_attempts
    when 0
      puts "░░ ░░░░▄░░░░░░░░░ ▄"
    when 1
      puts "░░ ░░░░▄░░░░░░░░░ ▄"
      puts "░░░░░░░░▌▒█░░░░░░░░░░░▄▀▒▌"
    when 2
      puts "░░ ░░░░▄░░░░░░░░░ ▄"
      puts "░░░░░░░░▌▒█░░░░░░░░░░░▄▀▒▌"
      puts "░░░░░░░░▌▒▒█░░░░░░░░▄▀▒▒▒▐"
    when 3
      puts "░░ ░░░░▄░░░░░░░░░ ▄"
      puts "░░░░░░░░▌▒█░░░░░░░░░░░▄▀▒▌"
      puts "░░░░░░░░▌▒▒█░░░░░░░░▄▀▒▒▒▐"
      puts "░░░░░░░▐▄▀▒▒▀▀▀▀▄▄▄▀▒▒▒▒▒▐ "
      puts "░░░░░▄▄▀▒░▒▒▒▒▒▒▒▒▒█▒▒▄█▒▐ "
    when 4
      puts "░░ ░░░░▄░░░░░░░░░ ▄"
      puts "░░░░░░░░▌▒█░░░░░░░░░░░▄▀▒▌"
      puts "░░░░░░░░▌▒▒█░░░░░░░░▄▀▒▒▒▐"
      puts "░░░░░░░▐▄▀▒▒▀▀▀▀▄▄▄▀▒▒▒▒▒▐ "
      puts "░░░░░▄▄▀▒░▒▒▒▒▒▒▒▒▒█▒▒▄█▒▐ "
      puts "░░░▄▀▒▒▒░░░▒▒▒░░░▒▒▒▀██▀▒▌ "
    when 5
      puts "░░ ░░░░▄░░░░░░░░░ ▄"
      puts "░░░░░░░░▌▒█░░░░░░░░░░░▄▀▒▌"
      puts "░░░░░░░░▌▒▒█░░░░░░░░▄▀▒▒▒▐"
      puts "░░░░░░░▐▄▀▒▒▀▀▀▀▄▄▄▀▒▒▒▒▒▐ "
      puts "░░░░░▄▄▀▒░▒▒▒▒▒▒▒▒▒█▒▒▄█▒▐ "
      puts "░░░▄▀▒▒▒░░░▒▒▒░░░▒▒▒▀██▀▒▌ "
      puts "░░▐▒▒▒▄▄▒▒▒▒░░░▒▒▒▒▒▒▒▀▄▒▒▌ "
      puts "░░▌░░▌█▀▒▒▒▒▒▄▀█▄▒▒▒▒▒▒▒█▒▐"
      puts "░▐░░░▒▒▒▒▒▒▒▒▌██▀▒▒░░░▒▒▒▀▄▌"
    when 6
      puts "░░ ░░░░▄░░░░░░░░░ ▄"
      puts "░░░░░░░░▌▒█░░░░░░░░░░░▄▀▒▌"
      puts "░░░░░░░░▌▒▒█░░░░░░░░▄▀▒▒▒▐"
      puts "░░░░░░░▐▄▀▒▒▀▀▀▀▄▄▄▀▒▒▒▒▒▐ "
      puts "░░░░░▄▄▀▒░▒▒▒▒▒▒▒▒▒█▒▒▄█▒▐ "
      puts "░░░▄▀▒▒▒░░░▒▒▒░░░▒▒▒▀██▀▒▌ "
      puts "░░▐▒▒▒▄▄▒▒▒▒░░░▒▒▒▒▒▒▒▀▄▒▒▌ "
      puts "░░▌░░▌█▀▒▒▒▒▒▄▀█▄▒▒▒▒▒▒▒█▒▐"
      puts "░▐░░░▒▒▒▒▒▒▒▒▌██▀▒▒░░░▒▒▒▀▄▌"
      puts "░▌░▒▄██▄▒▒▒▒▒▒▒▒▒░░░░░░▒▒▒▒▌ "
    when 7
      puts "░░ ░░░░▄░░░░░░░░░ ▄"
      puts "░░░░░░░░▌▒█░░░░░░░░░░░▄▀▒▌"
      puts "░░░░░░░░▌▒▒█░░░░░░░░▄▀▒▒▒▐"
      puts "░░░░░░░▐▄▀▒▒▀▀▀▀▄▄▄▀▒▒▒▒▒▐ "
      puts "░░░░░▄▄▀▒░▒▒▒▒▒▒▒▒▒█▒▒▄█▒▐ "
      puts "░░░▄▀▒▒▒░░░▒▒▒░░░▒▒▒▀██▀▒▌ "
      puts "░░▐▒▒▒▄▄▒▒▒▒░░░▒▒▒▒▒▒▒▀▄▒▒▌ "
      puts "░░▌░░▌█▀▒▒▒▒▒▄▀█▄▒▒▒▒▒▒▒█▒▐"
      puts "░▐░░░▒▒▒▒▒▒▒▒▌██▀▒▒░░░▒▒▒▀▄▌"
      puts "░▌░▒▄██▄▒▒▒▒▒▒▒▒▒░░░░░░▒▒▒▒▌ "
      puts "▌▒▀▐▄█▄█▌▄░▀▒▒░░░░░░░░░░▒▒▒▐"
      puts "▐▒▒▐▀▐▀▒░▄▄▒▄▒▒▒▒▒▒░▒░▒░▒▒▒▒▌"
    when 8
      puts "░░ ░░░░▄░░░░░░░░░ ▄"
      puts "░░░░░░░░▌▒█░░░░░░░░░░░▄▀▒▌"
      puts "░░░░░░░░▌▒▒█░░░░░░░░▄▀▒▒▒▐"
      puts "░░░░░░░▐▄▀▒▒▀▀▀▀▄▄▄▀▒▒▒▒▒▐ "
      puts "░░░░░▄▄▀▒░▒▒▒▒▒▒▒▒▒█▒▒▄█▒▐ "
      puts "░░░▄▀▒▒▒░░░▒▒▒░░░▒▒▒▀██▀▒▌ "
      puts "░░▐▒▒▒▄▄▒▒▒▒░░░▒▒▒▒▒▒▒▀▄▒▒▌ "
      puts "░░▌░░▌█▀▒▒▒▒▒▄▀█▄▒▒▒▒▒▒▒█▒▐"
      puts "░▐░░░▒▒▒▒▒▒▒▒▌██▀▒▒░░░▒▒▒▀▄▌"
      puts "░▌░▒▄██▄▒▒▒▒▒▒▒▒▒░░░░░░▒▒▒▒▌ "
      puts "▌▒▀▐▄█▄█▌▄░▀▒▒░░░░░░░░░░▒▒▒▐"
      puts "▐▒▒▐▀▐▀▒░▄▄▒▄▒▒▒▒▒▒░▒░▒░▒▒▒▒▌"
      puts "▐▒▒▒▀▀▄▄▒▒▒▄▒▒▒▒▒▒▒▒░▒░▒░▒▒▐"
    when 9
      puts "░░ ░░░░▄░░░░░░░░░ ▄"
      puts "░░░░░░░░▌▒█░░░░░░░░░░░▄▀▒▌"
      puts "░░░░░░░░▌▒▒█░░░░░░░░▄▀▒▒▒▐"
      puts "░░░░░░░▐▄▀▒▒▀▀▀▀▄▄▄▀▒▒▒▒▒▐ "
      puts "░░░░░▄▄▀▒░▒▒▒▒▒▒▒▒▒█▒▒▄█▒▐ "
      puts "░░░▄▀▒▒▒░░░▒▒▒░░░▒▒▒▀██▀▒▌ "
      puts "░░▐▒▒▒▄▄▒▒▒▒░░░▒▒▒▒▒▒▒▀▄▒▒▌ "
      puts "░░▌░░▌█▀▒▒▒▒▒▄▀█▄▒▒▒▒▒▒▒█▒▐"
      puts "░▐░░░▒▒▒▒▒▒▒▒▌██▀▒▒░░░▒▒▒▀▄▌"
      puts "░▌░▒▄██▄▒▒▒▒▒▒▒▒▒░░░░░░▒▒▒▒▌ "
      puts "▌▒▀▐▄█▄█▌▄░▀▒▒░░░░░░░░░░▒▒▒▐"
      puts "▐▒▒▐▀▐▀▒░▄▄▒▄▒▒▒▒▒▒░▒░▒░▒▒▒▒▌"
      puts "▐▒▒▒▀▀▄▄▒▒▒▄▒▒▒▒▒▒▒▒░▒░▒░▒▒▐"
      puts "░▌▒▒▒▒▒▒▀▀▀▒▒▒▒▒▒░▒░▒░▒░▒▒▒▌"
      puts "░▐▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░▒░▒▒▄▒▒▐ "
    when 10
      puts "░░ ░░░░▄░░░░░░░░░ ▄"
      puts "░░░░░░░░▌▒█░░░░░░░░░░░▄▀▒▌"
      puts "░░░░░░░░▌▒▒█░░░░░░░░▄▀▒▒▒▐"
      puts "░░░░░░░▐▄▀▒▒▀▀▀▀▄▄▄▀▒▒▒▒▒▐ "
      puts "░░░░░▄▄▀▒░▒▒▒▒▒▒▒▒▒█▒▒▄█▒▐ "
      puts "░░░▄▀▒▒▒░░░▒▒▒░░░▒▒▒▀██▀▒▌ "
      puts "░░▐▒▒▒▄▄▒▒▒▒░░░▒▒▒▒▒▒▒▀▄▒▒▌ "
      puts "░░▌░░▌█▀▒▒▒▒▒▄▀█▄▒▒▒▒▒▒▒█▒▐"
      puts "░▐░░░▒▒▒▒▒▒▒▒▌██▀▒▒░░░▒▒▒▀▄▌"
      puts "░▌░▒▄██▄▒▒▒▒▒▒▒▒▒░░░░░░▒▒▒▒▌ "
      puts "▌▒▀▐▄█▄█▌▄░▀▒▒░░░░░░░░░░▒▒▒▐"
      puts "▐▒▒▐▀▐▀▒░▄▄▒▄▒▒▒▒▒▒░▒░▒░▒▒▒▒▌"
      puts "▐▒▒▒▀▀▄▄▒▒▒▄▒▒▒▒▒▒▒▒░▒░▒░▒▒▐"
      puts "░▌▒▒▒▒▒▒▀▀▀▒▒▒▒▒▒░▒░▒░▒░▒▒▒▌"
      puts "░▐▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░▒░▒▒▄▒▒▐ "
      puts "░░▀▄▒▒▒▒▒▒▒▒▒▒▒░▒░▒░▒▄▒▒▒▒▌ "
      puts "░░░░▀▄▒▒▒▒▒▒▒▒▒▒▄▄▄▀▒▒▒▒▄▀ "
      puts "░░░░░░▀▄▄▄▄▄▄▀▀▀▒▒▒▒▒▄▄—"
      puts "        TRY AGAIN"
    end
    puts " AW, MAN! "
  end
end

my_game = Hangman.new
my_game.main_menu
