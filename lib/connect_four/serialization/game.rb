module ConnectFour
  module Serialization
    class Game
      attr_accessor :board, :depth, :ai_player

      def initialize(board, depth, ai_player)
        @board = board
        @depth = depth
        @ai_player = ai_player
      end
    end
  end
end