
module Display
  def display_game
    puts display_rules
    puts display_mode_selection
  end

  def display_rules
    <<~HEREDOC
    
    A word between 5-12 characters will be randomly selected. 
    A player may guess one letter on each turn. 

    To win, you must correctly find all letters in the mystery word before using 6 incorrect guesses

    HEREDOC
  end

  def display_mode_selection
    <<~HEREDOC

    Would you like to: 
        [1] - Start a new game
        [2] - Load a previously saved game

    HEREDOC
  end
end