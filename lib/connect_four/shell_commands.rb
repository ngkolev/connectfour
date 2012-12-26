module ConnectFour
  module ShellCommands
    def start_game
      if @game.nil?
        @game = GameEngine.new(@board_size, @difficulty, @cells_to_win, @first_player, @ai_player)
      else
        puts 'The game is already started'
      end
    end

    def stop_game
      #TODO
    end

    def make_move
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
      unless player.nil?
        if player == '1'
          @first_player = :first
        elsif player == '2'
          @first_player = :second
        end
      end
      puts "First player is the #{@first_player.to_s} one"
    end

    def ai_player(player = nil)
      unless player.nil?
        if player == "1"
          @ai_player = :first
        elsif player == "2"
          @ai_player = :second
        end
      end
      puts "AI player is the #{@ai_player.to_s} one"
    end

    def difficulty(value = nil)
      @difficulty = value.to_i unless value.nil?
      puts "Difficulty: #{@difficulty}"
    end

    def save_method(method = nil)
      #TODO
    end

    def board_size(size = nil)
      @board_size = size.to_i unless size.nil?
      puts "Board size: #{@board_size}"
    end

    def cells_to_win(count = nil)
      @cells_to_win = count.to_i unless count.nil?
      puts "Cells to win: #{@cells_to_win}"
    end

    def exit_shell
      exit
    end

    def help
      puts <<-eos
  start-game - starts new game
  stop-game - stops the current game
  move [X] - make a move
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