module ConnectFour
  module Core
    class Board
      attr_accessor :board, :size, :cells_to_win

      def initialize(size, cells_to_win, board = nil)
        @size = size
        @cells_to_win = cells_to_win
        @board = board ? board : size.times.map { [nil] * size }
      end

      def ==(other)
        @size == other.size and
          @cells_to_win == other.cells_to_win and
          @board = other.board
      end

      def clone
        board_clone = @board.map { |line| line.clone }
        Board.new(@size, @cells_to_win, board_clone)
      end

      def generate_valid_moves(player)
        @size.times.select { |y| valid_move?(y) }
      end

      def move!(move, player)
        @board = move(move, player).board
      end

      def move(move, player)
        found_index = @size.times.find_index do |index|
          index == @size or not @board[index][move].nil?
        end
        x_position = found_index ? found_index - 1 : @size - 1
        result = clone
        result.board[x_position][move] = player
        result
      end

      def valid_move?(move)
        0 <= move and move < @size and board[0][move].nil?
      end

      def last_move?
        board_full? or winner
      end

      def board_full?
        @board.flatten.all?
      end

      def winner
        MatrixVisitors::MatrixVisitor.get_visitors(@board).each do |visitor|
          [:first, :second].each do |player|
            return player if player_winner?(player, visitor)
          end
        end
        nil
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