module ConnectFour
  module ConnectFourShell
    module ShellCommands
      include Core::Util
      include Serialization

      def start_game
        unless @game
          @game = Core::GameEngine.new(@board_size, @difficulty, @cells_to_win, @ai_player)
          @output << "Game is started. "
          if @ai_player == :first then make_ai_move
          else @output << "Your turn."
          end
        else
          @output << 'The game is already started'
        end
      end

      def stop_game
        if @game
          @game = nil
          @output << 'Game is stopped'
        else
          @output << 'Game is already stopped'
        end
      end

      def make_move(move_string)
        if @game
          move = move_string.to_i
          if move
            if @game.try_make_move(move - 1)
              print_board
              check_for_last_move
              make_ai_move if @game
            else
              @output << "You have made an invalid move"
            end
          end
        else
          @output << "To make move you must at first start the game"
        end
      end

      def saved_games
        @output << "SAVED GAMES:\n"
        @output << @serializer.names.map{ |name| "\t#{name}" }.join("\n")
      end

      def save_game(name)
        if @game
          game_object = Game.new(@game.board, @game.depth, @game.ai_player)
          @serializer.serialize(game_object)
          @output << "Your game is saved"
        else
          @output << "You are not playing a game. There is nothing to be saved"
        end
      end

      def load_game(name)
        game_object = @serializer.deserialize(name)
        if game_object
          game = @serializer.load(name)
          if game
            @game = GameEngine.from_board(game.board, game.depth, game.ai_player)
            @output << "Game loaded"
          else
            @output << "Game with that name doesn't exist"
          end
        else
          @output << "Game with that name was not found"
        end
      end

      def ai_player(player_code = nil)
       if player_code
          player = int_to_player(player_code.to_i)
          if player
            @ai_player = player
          else
            @output << 'Incorrect player number. Use 1 or 2'
          end
        end
        @output << "AI player is the #{@ai_player.to_s }"
      end

      def difficulty(value = nil)
        @difficulty = value.to_i if value
        @output << "Difficulty: #{@difficulty}"
      end

      def save_method(method = nil)
        if method
          serializer = Serializer.create_serializer(method.to_sym)
          if serializer
            @serializer = serializer
            @serializer_type = method.to_sym
          else
            @output << "Incorrect serialization method\n"
          end
        end
        @output << "Current serialization method is #{@serializer_type.to_s}"
      end

      def board_size(size = nil)
        @board_size = size.to_i if size
        @output << "Board size: #{@board_size}"
      end

      def cells_to_win(count = nil)
        @cells_to_win = count.to_i if count
        @output << "Cells to win: #{@cells_to_win}"
      end

      def exit_shell
        @on_exit_handler.call if @on_exit_handler
      end

      def help
        @output << <<-eos
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
              when :first then ' X'
              when :second then ' O'
              when nil then ' .'
            end
          end.join
        end.join("\n")
        @output << "#{matrix_string}\n"
        @output << 1.upto(@board_size).map do |index|
          index < 10 ? " #{index}" : index.to_s
        end.join
        @output << "\n"
      end

      def make_ai_move
        @output << "AI is playing\n"
        @game.ai_move
        print_board
        check_for_last_move
      end

      def check_for_last_move
        if @game.board.last_move?
          human_player = other_player(@ai_player)
          @output << case @game.winner
            when @ai_player then "You lost"
            when human_player then "You won"
            else "Game over. Draw"
          end
          @game = nil
        end
      end
    end
  end
end