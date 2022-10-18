require_relative './display'

class Game
  attr_accessor  :secret_word, :round
  attr_reader :dictionary

  include Display

  def initialize

    @dictionary = 'dictionary.txt'
    @secret_word = ''
    @guesses_remaining = 6
    @guess = ''
    @correct_letters = []
    @incorrect_letters = []
    @letters = ('a'..'z').to_a
  end

  # play a new game or load a saved game
  def play
    display_game
    game_mode
  end

  private

  # store file to memory and get random word that is between 5 and 12 characters through array methods
  def get_secret_word
    File.open(@dictionary, 'r') do |file| 
      dict = File.readlines(@dictionary, chomp: true)
      word = dict[rand(dict.length)]
      return word if (word.length >= 5 && word.length <= 12)
      get_secret_word
    end
  end

  # start a new game with a newly generated random word
  def new_game
    @secret_word = get_secret_word
    clear_guesses
    create_board
    loop do
      guess_letter
      check_guess
      create_board
      puts "#{@correct_letters}"
      puts "#{@incorrect_letters}"
      puts @secret_word

      puts "Guesses left: #{@guesses_remaining}"
    end
  end

  # user input for each round and pass back the input if it matches the regex
  def get_user_input
    loop do
      letter = gets.chomp
      letter.match(/^[a-z]$|^save$|^reset$/) ? (return letter) : (puts display_guess_error)
    end
  end

  # gets user input and ensures it is a valid letter and that an input was given
  def guess_letter
    loop do
      puts display_guess_letter
      @guess = get_user_input
      break if @guess.length >= 1
      break if @letters.include?(@guess.downcase)

      puts display_guess_error
    end
  end

  # allow user input to dictate if they want to start a new game or to load an existing save file
  def game_mode
    mode = gets.chomp
    new_game if mode == '1'
    puts "load_game" if mode == '2'
  end

  def check_guess
    if @secret_word.include?(@guess)
      @correct_letters << @guess
    elsif @guess == 'save'
      save_game
    elsif @guess == 'reset'
      puts display_rules
      new_game
    else
      @incorrect_letters << @guess
      @guesses_remaining -= 1
    end
  end

  def save_game
    puts "Save game"
  end

  def clear_guesses
    @correct_letters = []
    @incorrect_letters = []
  end

  def create_board
    board = @secret_word.split('')
    board.each_with_index do |letter, i|
      if @correct_letters.include?(letter) 
        print "#{board[i]} "
      else
        print "_ "
      end
    end
    print "\n"
  end
end
