
module Display
  def display_game
    puts "Welcome to Hangman!"
    puts display_rules
    puts display_mode_selection
  end

  def display_rules
    <<~HEREDOC
    
    A word between 5-12 characters will be randomly selected. 
    A player may guess one letter on each turn. 

    To win, you must correctly find all letters in the mystery word before using 8 incorrect guesses

    HEREDOC
  end

  def display_mode_selection
    <<~HEREDOC

    Would you like to: 
        [1] - Start a new game
        [2] - Load a previously saved game

    HEREDOC
  end

  def display_guess_letter
    <<~HEREDOC
    You may save your game at any time by typing [save] or quit without saving by typing [exit]

    Please guess a letter [a-z]:

    HEREDOC
 
  end

  def display_guess_error
    <<~HEREDOC





    Please make a valid selection (a-z)

    HEREDOC
  end

  def display_existing_guess_error
    <<~HEREDOC
    
    INVALID GUESS - YOU HAVE ALREADY SELECTED THAT LETTER. PLEASE GUESS AGAIN"

    HEREDOC
  end
end