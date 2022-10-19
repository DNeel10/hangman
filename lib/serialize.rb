# Frozen_string_literal: true

# Contains methods to save and load games
module Serialize
  def save_game
    Dir.mkdir 'saved_files' unless Dir.exist? 'saved_files'
    @filename = "#{saved_name}.yaml"
    File.open("saved_files/#{@filename}", 'w') { |file| file.write(save_to_yaml) }
  end

  def save_to_yaml
    YAML.dump(
      'dictionary' => @dictionary,
      'secret_word' => @secret_word,
      'guesses_remaining' => @guesses_remaining,
      'guess' => @guess,
      'correct_letters' => @correct_letters,
      'incorrect_letters' => @incorrect_letters,
      'letters' => @letters
    )
  end

  def saved_name
    nouns = %w[monkey bird girl camera man person computer lamp bottle desk]
    adj = %w[big smelly tall nice mean itchy beautiful ugly angry wet]
    "#{adj[rand(10)]}_#{nouns[rand(10)]}_#{rand(100)}"
  end

  def load_game_file
    data = YAML.safe_load(File.read('saved_files/angry_bird_0.yaml'))
    @dictionary = data['dictionary']
    @secret_word = data['secret_word']
    @guesses_remaining = data['guesses_remaining']
    @guess = data['guess']
    @correct_letters = data['correct_letters']
    @incorrect_letters = data['incorrect_letters']
    @letters = data['letters']
  end

  def load_game
    load_game_file
    player_turn
    win_screen if game_won?
    lose_screen if game_over?
  end
end
