module ConnectFour
  module Serialization
    #what about if there is duplication in 'name' -> mongodb, sqlite ??
    class Serializer
      def serialize(name, game)
        board = game.board
        board_coded = board.board.flatten.map(&:serialize_cell).join
        game_coded = "#{board.size} #{board.cells_to_win} #{game.player_on_turn} #{board_coded}"
        save(name, game_coded)
      end

      def deserialize(name)
        game_coded = load(name)
        size, cells_to_win, player_on_turn, board_coded = game_coded.split
        board_matrix = board_coded.each_slice(size).map(&:deserialize_cell)
        board = Board.new(size, cells_to_win, board_matrix)
        Game.new(board, player_on_turn)
      end

      private

      PLAYER_CODES = { nil => 0, :first => 1, :second => 2 }.freeze

      def serialize_cell(player)
        PLAYER_CODES[player]
      end

      def deserialize_cell(player_code)
        PLAYER_CODES.invert[player_code]
      end
    end
  end
end