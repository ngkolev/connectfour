module ConnectFour
  module Serialization

    Game = Struct.new(:board, :depth, :ai_player, :cells_to_win)

    class Serializer
      include Core::Util

      def Serializer.create_serializer(type)
        return nil if type == :none
        settings = Configurations.new
        case type
          when :memory then InMemorySerializer.new
          when :file then FileSerializer.new(settings.save_file_path)
          when :sql then SqlSerializer.new(settings.mysql_address,
                                           settings.mysql_name,
                                           settings.mysql_pass,
                                           settings.mysql_db_name)
          when :mongo then MongoSerializer.new(settings.mongo_connection_string,
                                               settings.mongo_port,
                                               settings.mongo_database_name)
        end
      end

      def serialize(name, game)
        board = game.board
        board_coded = board.board.flatten.map{ |cell| player_to_int(cell) }.join
        player_coded = player_to_int(game.ai_player)
        game_coded = "#{board.size} #{board.cells_to_win} #{game.depth} #{player_coded} #{board_coded}"
        save(name, game_coded)
      end

      def deserialize(name)
        loaded_game = load(name)
        if loaded_game
          size, cells_to_win, depth, player_coded, board_coded = loaded_game.split
          board_matrix = decode_board(board_coded, size)
          board = Core::Board.new(size.to_i, cells_to_win.to_i, board_matrix)
          ai_player = int_to_player(player_coded.to_i)
          Game.new(board, depth.to_i, ai_player, cells_to_win)
        end
      end

      private

      def decode_board(board_coded, size)
        board_decoded = board_coded.split('').map do |cell|
          int_to_player(cell.to_i)
        end
        board_decoded.each_slice(size.to_i).to_a
      end
    end
  end
end