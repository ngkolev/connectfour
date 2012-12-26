module ConnectFour
  module Core
    class Board
      attr_accessor :board, :size, :cells_to_win

      def initialize(size, cells_to_win, board = nil)
        @size = size
        @cells_to_win = cells_to_win
        @board = board.nil? ? size.times.map { [nil] * size } : board
      end

      def generate_valid_moves(player)
        @size.times.select { |y| valid_move?(y) }
      end

      def move(move, player)
        found_index = @size.times.find_index do |index|
          index == @size or not @board[index][move].nil?
        end
        x_position = found_index.nil? ? @size - 1 : found_index - 1
        result = clone
        result.board[x_position][move] = player
      end

      def valid_move?(move)
        board[0][move].nil?
      end

      def last_move?
        board_full? or not winner.nil?
      end

      def board_full?
        @board.flatten.all? { |element| not element.nil? }
      end

      def winner
        MatrixVisitors::MatrixVisitor.get_visitors(@board).each do |visitor|
          [:first, :second].each do |player|
            return player if player_winner?(player, visitor)
          end
        end
        nil
      end

      def ==(other)
        @size == other.size and
          @cells_to_win == other.cells_to_win and
          @board = other.board
      end

      private

      def player_winner?(player, visitor)
        visitor.each_line do |line|
          populated = 0
          line.each do |cell|
            if cell == player
              populated += 1
              return true if cells_to_win <= populated
            else
              populated = 0
            end
          end
        end
        false
      end

    end
  end
end