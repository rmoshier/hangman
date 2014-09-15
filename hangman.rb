# In this cleaned up version, I deleted most of my notes. The ones I kept explain
# (1) what each method does, in order to better understand the single responsibility
# principle, and (2) explain what I am currently calling "level 2 logic" (more advanced
# logic).
require 'colorize'

class Hangman

  def initialize
   @word = "cat"
   @num_wrong = 0
   @guessed_letters = []
   guess_letter
   letter_status
  end

  def display_word # makes and maintains 'letter slots'
    if @guessed_letters.empty?
      "_" * @word.length
    else
      # .tr = text replace in @word text replace letters that the user hasn't guessed
      @word.tr("^" + @guessed_letters.join, "_")
    end
  end

  def letter_status # displays guessed letters
    puts "Letters guessed: " + @guessed_letters.sort.join(", ")
  end

  def winning # defines winning
    display_word == @word
  end

  def losing # defines losing
    @num_wrong == 3
  end

  def guess_letter# retrieves letter guess from user
                  # and runs a bunch of shit that should be elsewhere
                  # will try to edit this down after next commit
    until winning || losing
      puts "What letter do you want to pick?"
      letter = gets.chomp
      if same_guess(letter)
        puts "#{'You\'ve already guessed that letter. Please pick another.'}".cyan
      end
      evaluate_guess(letter)
      picture_status
      letter_status
      guess_letter
      game_ends
    end
  end

  def same_guess(letter) # evaluates whether or not letter is in word
    @guessed_letters.include?(letter)
  end

  def evaluate_guess (letter) # evaluate guess by checking if guessed
                              # letter is in @word
    @guessed_letters << letter
    if @word.include?(letter)
      correct_status
      puts "#{'Correct!'.green}"
    else
      incorrect_status
      puts "#{'Incorrect!'.red}"
    end
  end

  def correct_status # subs "_" with correct letter guesses
    @guessed_letters.each do |l|
      if @word.include?(l)
        @word.gsub("-", l)
      end
    end
    puts display_word
  end

  def incorrect_status # increases @num_wrong for each incorrect guess
    @num_wrong = 0
    @guessed_letters.each do |l|
      if not @word.include?(l)
        @num_wrong += 1
      end
    end
    puts display_word
  end

  def picture_status # draws picture based on @num_wrong
    if @num_wrong == 0
      puts "|     _________"
      puts "|     |/      |"
      puts "|     |      "
      puts "|     |      "
      puts "|     |      "
      puts "|     |      "
      puts "|     |      "
      puts "| ____|___   "
    end
    if @num_wrong == 1
      puts "|     _________"
      puts "|     |/      |"
      puts "|     |      (xx)"
      puts "|     |      "
      puts "|     |      "
      puts "|     |      "
      puts "|     |      "
      puts "| ____|___   "
    end
    if @num_wrong == 2
      puts "|     _________"
      puts "|     |/      |"
      puts "|     |      (xx)"
      puts "|     |      \\|/"
      puts "|     |      "
      puts "|     |      "
      puts "|     |      "
      puts "| ____|___   "
    end
    if @num_wrong == 3
      puts "|     _________"
      puts "|     |/      |"
      puts "|     |      (xx)"
      puts "|     |      \\|/"
      puts "|     |       |"
      puts "|     |      / \\"
      puts "|     |      "
      puts "| ____|___   "
    end
  end

  def game_ends # defines end of game
      if display_word == @word
        puts "#{'CONGRATULATIONS! YOU WON!'}".light_magenta.blink
      else
        puts "#{'GAME OVER. YOU ARE A BIG LOSER.'}".red.blink
        puts "The word was #{@word.yellow}!"
      end
  end
end

my_game = Hangman.new
