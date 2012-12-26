module ConnectFour
  module Serialization
    class SqliteSerializer < Serializer
      def initialize(connection_string)
        @connection_string = connection_string
      end

      def save(name, game_coded)
        #TODO
      end

      def load(name)
        #TODO
      end

      def names
        #TODO: implement
      end
    end
  end
end