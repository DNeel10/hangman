require_relative './display'

class Game
  attr_accessor  :secret_word, :round
  attr_reader :dictionary
  include Display

  def initialize

    @dictionary = 'dictionary.txt'
    @secret_word = ''
    @guesses = 6
    @correct_letters = []
    @incorrect_letters = []
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

  def new_game    
    @secret_word = get_secret_word
    while @guesses != 0 do
      # guess_letter function goes here
      puts "Guess a letter: "
      puts @secret_word
      @guesses -= 1
      puts "Guesses left: #{@guesses}"
    end
  end

  def guess_letter
  end

  def game_mode
    mode = gets.chomp
    new_game if mode == '1'
    puts "load_game"
  end
end

