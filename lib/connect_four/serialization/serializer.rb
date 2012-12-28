module ConnectFour
  module Serialization
    #what about if there is duplication in 'name' -> mongodb, sqlite ??

    Game = Struct.new(:board, :depth, :ai_player)

    class Serializer
      include Core::Util

      def Serializer.create_serializer(type)
        case type
          when InMemorySerializer then InMemorySerializer.new
          when FileSerializer then FileSerializer.new(@save_file_path)
          when MongoSerializer then MongoSerializer.new(@mongo_connection_string, @mongo_port, @mongo_database_name)
          when SqliteSerializer then SqliteSerializer.new(@sql_connection_string)
        end
      end

      def Serializer.default
        InMemorySerializer.new
      end

      def serialize(name, game)
        board = game.board
        board_coded = board.board.flatten.map{ |cell| player_to_int(cell) }.join
        player_coded = player_to_int(game.ai_player)
        game_coded = "#{board.size} #{board.cells_to_win} #{game.depth} #{player_coded} #{board_coded}"
        save(name, game_coded)
      end

      def deserialize(name)
        size, cells_to_win, depth, player_coded, board_coded = load(name).split
        board_decoded = board_coded.split('').map { |cell| int_to_player(cell.to_i) }
        board_matrix = board_decoded.each_slice(size.to_i)
        board = Core::Board.new(size.to_i, cells_to_win.to_i, board_matrix)
        ai_player = int_to_player(player_coded.to_i)
        Game.new(board, depth.to_i, ai_player)
      end
    end
  end
end