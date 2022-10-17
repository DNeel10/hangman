class Game
attr_accessor :dictionary, :secret_word

  def initialize

    @dictionary = 'dictionary.txt'
    @secret_word = get_secret_word
  end

  private

  def get_secret_word
    File.open(@dictionary, 'r') do |file| 
      rand_int = rand(file.readlines.length)
      file.rewind
      file.readlines.each_with_index do |word, i|
        return word if i == rand_int
      end
    end
  end
end

puts Game.new.secret_word