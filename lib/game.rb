class Game
attr_accessor :dictionary, :secret_word

  def initialize

    @dictionary = 'dictionary.txt'
    @secret_word = get_secret_word
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


  # Get random int and traverse through the whole file until it gets to the int
  # def get_secret_word
  #   File.open(@dictionary, 'r') do |file| 
  #     rand_int = rand(file.readlines.length)
  #     file.rewind
  #     file.readlines.each_with_index do |word, i|
  #       return word if i == rand_int
  #     end
  #   end
  # end
end


puts Game.new.secret_word
