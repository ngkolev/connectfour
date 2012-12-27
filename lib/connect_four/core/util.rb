module ConnectFour
  module Core
    module Util
      PLAYER_CODES = { nil => 0, :first => 1, :second => 2 }.freeze

      def other_player(player)
        player == :first ? :second : :first
      end

      def player_to_int(player)
        PLAYER_CODES[player]
      end

      def int_to_player(player_code)
        PLAYER_CODES.invert[player_code]
      end

      class Integer
        n_bytes = [42].pack('i').size
        n_bits = n_bytes * 8
        MAX = 2 ** (n_bits - 2) - 1
        MIN = -MAX - 1
      end

    end
  end
end