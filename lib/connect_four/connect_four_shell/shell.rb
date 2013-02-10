require_relative '../../connect_four'
require_relative 'shell_commands'

module ConnectFour
  module ConnectFourShell
    class Shell
      include ShellCommands
      include Serialization

      def initialize(settings)
        set_default_values(settings)
        register_commands
        @game = nil
        @output = ""
      end

      def invoke(command_line)
        command_name, *params = command_line.split(/\s/)
        operation = @commands[command_name]
        if operation
          invoke_operation(operation, params)
        else
           'Command is not recognized'
        end
      end

      def on_exit(&on_exit_handler)
        @on_exit_handler = on_exit_handler
      end

      private

      def invoke_operation(operation, params)
        min_params = operation.arity
        max_params = operation.parameters.length
        if params.length < min_params
          'Too few command parameters'
        elsif max_params < params.length
          'Too many command parameters'
        else
          operation.call(*params)
          result = @output    t
          @output = ''
          result
        end
      end

      def set_default_values(settings)
        @difficulty = settings.difficulty.to_i
        @board_size = settings.board_size.to_i
        @cells_to_win = settings.cells_to_win.to_i
        @ai_player = settings.ai_player.to_sym
        @serializer_type = settings.save_method.to_sym
        @serializer = Serializer.create_serializer(@serializer_type)
      end

      def register_commands
        @commands = Hash.new
        @commands["start-game"] = method(:start_game)
        @commands["stop-game"] = method(:stop_game)
        @commands["move"] = method(:make_move)
        @commands["saved-games"] = method(:saved_games)
        @commands["save-game"] = method(:save_game)
        @commands["load-game"] = method(:load_game)
        @commands["ai-player"] = method(:ai_player)
        @commands["difficulty"] = method(:difficulty)
        @commands["save-method"] = method(:save_method)
        @commands["board-size"] = method(:board_size)
        @commands["cells-to-win"] = method(:cells_to_win)
        @commands["exit"] = method(:exit_shell)
        @commands["help"] = method(:help)
      end
    end
  end
end
