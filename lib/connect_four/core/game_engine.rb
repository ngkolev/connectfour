module ConnectFour
  module Core
    class GameEngine
      include Util

      attr_reader :board, :current_player, :ai_player, :depth, :human_player

      def initialize(board_size, depth, cells_to_win, first_player, ai_player)
        @board = Board.new(board_size, cells_to_win)
        @depth = depth
        @current_player = first_player
        @ai_player = ai_player
        @human_player  = other_player(ai_player)
      end

      def last_move?
        @board.last_move?
      end

      def winner
        @board.winner
      end

      def try_make_move(move)
        is_valid_move = @board.valid_move?(move)
        if is_valid_move
          board.move(move)
          @current_player = other_player(@current_player)
        end
        is_valid_move
      end

      def ai_move
        #TODO:
        negamax(@board, @depth, Integer::MIN, Integer::MAX, @current_player)
        @current_player = other_player(@current_player)
      end

      private

      def negamax(board, depth, alpha, beta, player)
        score = ScoreCalculator.new(player, board).score
        return score if board.last_move? or depth == 0
        board.generate_valid_moves(player).each do |move|
          new_board = board.move(move, player)
          other_player =other_player(player)
          score = -negamax(new_board, depth - 1, -beta, - alpha, other_player)
          return score if beta <= score
          alpha = score if alphe <= score
        end
        alpha
      end
    end
  end
end