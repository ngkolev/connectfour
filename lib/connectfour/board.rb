module ConnectFour
  class Board
    attr_accessor :board, :size, :cells_to_win

    def initialize(size, cells_to_win, board = [])
      @size = size
      @cells_to_win = cells_to_win
      @board = board
    end

    def generate_valid_moves(player)
      0.upto(@size - 1).select do |y|
        valid_move?(y)
      end
    end

    def move(move, player)
      0.upto(@size - 1).each do |index|
        index == @size or not @board[index][move].nil?
      end
      x_position = index.nil? ? @size - 1 : index - 1
      result = clone
      result.board[x_position][move] = player
    end

    def valid_move?(move)
      board[0, move].nil?
    end

    def last_move?
      board_full? or not winner.nil?
    end

    def board_full?
      @board.flatten.all? { |element| not element.nil? }
    end

    def winner
      MatrixVisitor::get_visitors(@board).each do |visitor|
        [:first, :second].each do |player|
          return player if player_winner?(player, visitor)
        end
      end
    end

    private

    def player_winner?(player, visitor)
      #TODO: use the visitor to iterate
    end
  end
end