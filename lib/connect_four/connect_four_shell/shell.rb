require_relative '../../connect_four'
require_relative 'shell_commands'

module ConnectFour
  module ConnectFourShell
    class Shell
      include ShellCommands

      def initialize
        set_default_values
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
          result = @output
          @output = ""
          result
        end
      end

      def set_default_values
        @ai_player = :second
        @difficulty = 3
        @board_size = 10
        @cells_to_win = 4
        @serializer = Serialization::Serializer.default
        @serializer_type = Serialization::DEFAULT_SERIALIZER_TYPE
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
