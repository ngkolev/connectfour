module ConnectFour
  module Core
    class GameEngine

      #TODO: expose board structure to be drawn
      #TODO: expose current player, to be serialized

      def initialize(board_size, depth, cells_to_win, first_player, ai_player)
        @board = Board.new(board_size, cells_to_win)
        @depth = depth
        @current_player = first_player
        @ai_player = ai_player
        @human_player  = ai_player == :first ? :second : :first
      end

      def board_full?
        @board.board_full?
      end

      def winner
        @board.winner
      end

      def try_make_move(move)
        is_valid_move = @board.valid_move?(move)
        board.move(move) if is_valid_move
        is_valid_move
      end

      def ai_move
        #TODO: implement
      end
    end
  end
end