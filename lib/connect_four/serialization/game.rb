module ConnectFour
  module Serialization
    class Game
      attr_accessor :board, :player_on_turn

      def initialize(board, player_on_turn)
        @board = board
        @player_on_turn = player_on_turn
      end
    end
  end
end