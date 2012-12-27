module ConnectFour
  module Core
    class ScoreCalculator
      include ConnectFour::Core::Util
      include ConnectFour::MatrixVisitors

      def initialize(player, board)
        @player = player
        @board = board
      end

      def score
        @total_score = 0
        other_player = other_player(@player)
        MatrixVisitor::get_visitors(@board.board).each do |visitor|
          add_to_score(@player, visitor, 1)
          add_to_score(other_player, visitor, -1)
        end
        @total_score
      end

      private

      def add_to_score(player, visitor, sign)
        visitor.each_line do |line|
          populated, empty = 0, 0
          line.each do |cell|
            if cell == player then populated += 1
            elsif cell.nil? then empty += 1
            elsif(@board.cells_to_win <= populated + empty)
              @total_score += sign * calculate_score(populated, empty)
              populated, empty = 0, 0
            end
          end
          @total_score += sign * calculate_score(populated, empty)
        end
      end

      def calculate_score(captured_cells, empty_cells)
        captured_cells * 1000 + empty_cells * 100
      end
    end
  end
end