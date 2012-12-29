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
        MatrixVisitor::get_visitors(@board.board).each do |visitor|
          add_to_score(@player, visitor, 1)
          add_to_score(other_player(@player), visitor, -1)
        end
        @total_score
      end

      private

      def add_to_score(player, visitor, sign)
        visitor.each_line do |line|
          populated, empty = 0, 0
          line.each do |cell|
            case cell
              when player then populated += 1
              when other_player(@player) do
                add_to_score_if_required(populated, empty, sign)
                populated, empty = 0, 0
              end
              when nil then empty += 1
            end
          end
          add_to_score_if_required(populated, empty, sign)
        end
      end

      def add_to_score_if_required(captured, empty, sign)
        if(@board.cells_to_win <= captured + empty)
          @total_score += sign * (captured * 1000 + empty * 100)
        end
      end
    end
  end
end