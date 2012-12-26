module ConnectFour
  module ShellCommands
    def start_game
      #TODO
    end

    def stop_game
      #TODO
    end

    def saved_games
      #TODO
    end

    def save_game(name)
      #TODO
    end

    def load_game(name)
      #TODO
    end

    def first_player(player = nil)
      if count.nil?
        #TODO
      else
        #TODO
      end
    end

    def ai_player(player = nil)
      if count.nil?
        #TODO
      else
        #TODO
      end
    end

    def difficulty(value = nil)
      if count.nil?
        #TODO
      else
        #TODO
      end
    end

    def save_method(method = nil)
      if count.nil?
        #TODO
      else
        #TODO
      end
    end

    def board_size(size = nil)
      if count.nil?
        #TODO
      else
        #TODO
      end
    end

    def cells_to_win(count = nil)
      if count.nil?
        #TODO
      else
        #TODO
      end
    end

    def exit_shell
      exit
    end

    def help
      puts <<-eos
  start-game - starts new game
  stop-game - stops the current game
  saved-games - show list of all saved games
  save-game [name] - saves the current game
  load-game [name] - loads game
  first-player [X] - sets/shows who is the first player(0 or 1)
  ai-player [X] - sets/shows who is the AI player(0 or 1)
  difficulty [X] - sets/shows the difficulty(from 2 to 10)
  save-method [X] - sets/shows the save method (file, memory, mongo, sql)
  board-size [X] - sets/shows board's size
  cells-to-win [X] - sets/shows how many cells are required for win
  help - shows this help
  exit - closes the application
      eos
    end
  end
end