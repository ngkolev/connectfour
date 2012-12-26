require_relative '../connect_four'

module ConnectFour
  class Shell
    include ShellCommands

    def initialize
      set_default_values
      register_commands
    end

    def start
      loop do
        print '> '
        input = gets.chomp.strip
        command_name, *params = input.split(/\s/)
        operation = @commands[command_name]
        unless operation.nil?
          invoke_operation(operation, params)
        else
          puts 'Command is not recognized'
        end
      end
    end

    private

    def invoke_operation(operation, params)
      min_params = operation.arity
      max_params = operation.parameters.length
      if params.length < min_params
        puts "Too few command parameters"
      elsif max_params < params.length
        puts "Too many command parameters"
      else
        operation.call(*params)
      end
    end

    def set_default_values
      @first_player = :first
      @ai_player = :second
      @difficulty = 7
      @board_size = 10
      @cells_to_win = 4
      @serializer = Serialization::Serializer.default
    end

    def register_commands
      @commands = Hash.new
      @commands["start-game"] = method(:start_game)
      @commands["stop-game"] = method(:stop_game)
      @commands["saved-games"] = method(:saved_games)
      @commands["save-game"] = method(:save_game)
      @commands["load-game"] = method(:load_game)
      @commands["first-player"] = method(:first_player)
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
