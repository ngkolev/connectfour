module ConnectFour
  module ConnectFourShell
    module ShellCommands
      include Core::Util

      def start_game
        if @game.nil?
          @game = Core::GameEngine.new(@board_size, @difficulty, @cells_to_win, @ai_player)
          print "Game is started."
          if @ai_player == :first
            make_ai_move
          else
            puts "Your turn."
          end
        else
          puts 'The game is already started'
        end
      end

      def stop_game
        if @game.nil?
          puts 'Game is already stopped'
        else
          @game = nil
          puts 'Game is stopped'
        end
      end

      def make_move(move_string)
        if @game.nil?
          puts "To make move you must at first start the game"
        else
          if @game.try_make_move(move_string.to_i)
            print_board
            check_for_last_move
            make_ai_move unless @game.nil?
          else
            puts "You have made an invalid move"
          end
        end
      end

      def saved_games
        puts "SAVED GAMES:\n"
        puts @serializer.names.map{ |name| "\t#{name}" }.join("\n")
      end

      def save_game(name)
        if @game.nil?
          puts "You are not playing a game. There is nothing to be saved"
        else
          #TODO: game_object = Game.new
          @serializer.serialize(game_object)
          puts "Your game is saved"
        end
      end

      def load_game(name)
        game_object = @serializer.deserialize(name)
        if game_object.nil?
          puts "Game with that name was not found"
        else
          #TODO
          puts "Game loaded"
        end
      end

      def ai_player(player_code = nil)
       unless player_code.nil?
          player = int_to_player(player_code.to_i)
          if player.nil?
            puts 'Incorrect player number. Use 1 or 2'
          else
            @ai_player = player
          end
        end
        puts "AI player is the #{@ai_player.to_s }"
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
    ai-player [X] - sets/shows who is the AI player(0 or 1)
    difficulty [X] - sets/shows the difficulty(from 2 to 10)
    save-method [X] - sets/shows the save method (file, memory, mongo, sql)
    board-size [X] - sets/shows board's size
    cells-to-win [X] - sets/shows how many cells are required for win
    help - shows this help
    exit - closes the application
        eos
      end

      private

      def print_board
        matrix = @game.board.board
        matrix_string = matrix.map do |line|
          line.map do |cell|
            case cell
              when :first then 'X'
              when :second then 'O'
              when nil then '.'
            end
          end.join
        end.join("\n")
        puts matrix_string
        puts
      end

      def make_ai_move
        puts "AI is playing"
        @game.ai_move
        print_board
        check_for_last_move
      end

      def check_for_last_move
        if @game.board.last_move?
          human_player = other_player(@ai_player)
          case @game.winner
            when @ai_player then puts "You lost"
            when human_player then puts"You won"
            else puts "Game over. Draw"
          end
          @game = nil
        end
      end
    end
  end
end