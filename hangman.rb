require 'colorize'

# class Game #(player in here?)(everything that doesnt belong in hangman)
#
#
# end

class Hangman
# next step needs to be breaking down board class and word class

 #don't need to initialize since nested class?
 #initialize = set up given attributes(in the from of instance variables), make data manipulation

  def initialize
   @word = "cat"
   @num_wrong = 0
   @guessed_letters = []
   guess_letter
   letter_status
  end

  def display_word
    if @guessed_letters.empty?
      "_" * @word.length
    else
      # .tr = text replace in @word text replace letters that the user hasn't guessed
      @word.tr("^" + @guessed_letters.join, "_")
    end
  end

  def letter_status #shows current letter status (which slots are filled)
    # puts display_word
    puts "Letters guessed: " + @guessed_letters.sort.join(", ")
  end

  def guess_letter #get letter guess from user
    until winning || losing
      puts "What letter do you want to pick?"
      letter = gets.chomp
      if same_guess(letter)
        puts "#{'You\'ve already guessed that letter. Please pick another.'}".cyan
      end
    # if letter
      evaluate_guess(letter)
    # # else
    # #   game_ends
    # end
      picture_status
      letter_status
      guess_letter
      # end
    game_ends
    end
  end

  def evaluate_guess (letter) #evaluate guess by checking if guess is in @word
    @guessed_letters << letter
    if @word.include?(letter) #this may not work b/c letter is instance variable
      correct_status          #does this letter variable pull from guess_letter method?
      puts "#{'Correct!'.green}"
      # puts "-" * 10
    else
      incorrect_status
      puts "#{'Incorrect!'.red}"
      # puts "-" * 100
    end
  end

  def same_guess(letter)
    @guessed_letters.include?(letter)
  end

  #i'm evaluating letters against the @word, but i'm not doing anything with them
  #put them in an array

  def correct_status #shows current status + also need to add putting letters into --- structure!!!!
    # @so_far = @word.chars << @guessed_list
    # @so_far = @word.tr('^' + @guessed_list.join, '-')
    # @so_far = @word.chars.each_with_index do |letter, index|
    #   if guessed_letter == letter
    #     @characters[index] = letter
    #   end
    # end
    @guessed_letters.each do |l|
      if @word.include?(l)
        @word.gsub("-", l)
      end
    end
    puts display_word
  end

  def incorrect_status #shows current status and adds guess to @num_wrong
    # puts @num_wrong
    @num_wrong = 0
    @guessed_letters.each do |l|
      if not @word.include?(l)
        @num_wrong += 1
      end
    end
    puts display_word
    # puts @num_wrong
  end

  def winning
    display_word == @word
  end

  def losing
    @num_wrong == 3
  end

  def picture_status #connects to @num_wrong and draws picture based on number wrong
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
    # game_ends
    # letter_status
  end

  def game_ends #game ends when @word == @so_far
      if display_word == @word
        puts "#{'CONGRATULATIONS! YOU WON!'}".light_magenta.blink
      else
        puts "#{'GAME OVER. YOU ARE A BIG LOSER.'}".red.blink
        puts "The word was #{@word.yellow}!"
      end
  end
end

# def run
  # my_game = Hangman.new
  # while true
    # puts board
    # puts guess
    # puts "What letter would you like to guess?"
    # guess = gets.chomp
    # h.make_guess(guess)
  # end
# end

# put the allication flow/logic here. call this method at end of game.

# my_game = Game.new
# run
my_game = Hangman.new
# evaluate_guess(letter)
# picture_status
# letter_status
# guess_letter
# game_ends
# my_game = Game::Hangman.new
# my_game = Hangman.guess_letter
