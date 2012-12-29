module ConnectFour
  module Core
    class GameEngine
      include Util

      attr_reader :board, :current_player, :ai_player, :depth, :human_player

      def initialize(board_size, depth, cells_to_win, ai_player = :second)
        @board = Board.new(board_size, cells_to_win)
        @depth = depth
        @current_player = :first
        @ai_player = ai_player
        @human_player  = other_player(ai_player)
      end

      def GameEngine.from_board(board, depth, ai_player)
        engine = GameEngine.new(0, 0, depth, ai_player)
        engine.board = board
        engine.current_player = board.human_player
        engine
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
          @board.move!(move, @human_player)
          @current_player = @ai_player
        end
        is_valid_move
      end

      def ai_move
        best_move = nil
        alpha = Integer::MIN
        @board.generate_valid_moves(@current_player).each do |move|
          evaluation_board = board.move(move, @current_player)
          score = negamax(evaluation_board, @depth, alpha, Integer::MAX, @current_player)
          if alpha < score
            alpha = score
            best_move = move
          end
        end
        @board.move!(best_move, @current_player)
        @current_player = @human_playerl
      end

      private

      def negamax(board, depth, alpha, beta, player)
        score = ScoreCalculator.new(player, board).score
        return score if board.last_move? or depth == 0
        board.generate_valid_moves(player).each do |move|
          new_board = board.move(move, player)
          other_player = other_player(player)
          score = -negamax(new_board, depth - 1, -beta, - alpha, other_player)
          return score if beta <= score
          alpha = score if alpha <= score
        end
        alpha
      end
    end
  end
end