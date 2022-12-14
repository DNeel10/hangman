require_relative './display'
require_relative './serialize'
require 'yaml'

class Game
  attr_accessor  :secret_word, :round
  attr_reader :dictionary

  include Display
  include Serialize

  def initialize

    @dictionary = 'dictionary.txt'
    @secret_word = ''
    @guesses_remaining = 8
    @guess = ''
    @correct_letters = []
    @incorrect_letters = []
    @letters = ('a'..'z').to_a
    play
  end

  # play a new game or load a saved game
  def play
    system("clear")

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
    player_turn
    win_screen if game_won?
    lose_screen if game_over?
  end

  def player_turn
    loop do
      play_round
      break if game_won? || game_over?
    end

  end

  def play_round
    system("clear") 
    show_incorrect_guesses if @guesses_remaining < 8
    puts display_guesses_remaining
    create_board
    show_game_saved if @guess == 'save'
    guess_letter
    check_guess
    puts empty_space_four
  end

  # user input for each round and pass back the input if it matches the regex
  def get_user_input
    loop do
      letter = gets.chomp.downcase
      letter.match(/^[a-z]$|^save$|^reset$|^exit$/i) ? (return letter) : (puts display_guess_error)
    end
  end

  # gets user input and ensures it is a valid letter and that an input was given
  def guess_letter
    loop do
      print display_guess_letter
      @guess = get_user_input
      break if @guess.length > 1
      break if @letters.include?(@guess)

      puts display_guess_error
    end
  end

  # allow user input to dictate if they want to start a new game or to load an existing save file
  def game_mode
    mode = gets.chomp
    new_game if mode == '1'
    load_game if mode == '2'
  end

  def check_guess
    if @incorrect_letters.include?(@guess) || @correct_letters.include?(@guess)
      puts display_existing_guess_error
    elsif @secret_word.include?(@guess)
      @correct_letters << @guess
    elsif @guess == 'save'
      save_game
    elsif @guess == 'exit'
      exit
    else
      @incorrect_letters << @guess
      @guesses_remaining -= 1
    end
  end

  def game_won?
    @secret_word.split('').all? { |letter| @correct_letters.include?(letter) }
  end

  def game_over?
    @guesses_remaining == 0
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
    puts empty_space_two
  end

  def show_incorrect_guesses
    print "Incorrect Guesses: "
    @incorrect_letters.each do |letter|
      print "#{letter} "
    end
    puts empty_space_two
  end

  def existing_guess?
    @incorrect_letters.include?(@guess) || @correct_letters.include?(@guess)
  end

  def win_screen
    puts display_win_screen
    replay_game
  end

  def lose_screen
    puts display_lose_screen
    replay_game
  end

  def reset_game
    clear_guesses
    @guesses_remaining = 8
    play
  end

  def show_game_saved
    puts "Your game has been saved. Filename: #{@filename}"
    puts ""
  end

  def replay_game
    replay = get_user_input
    replay == 'y' ? reset_game : exit
  end
end
