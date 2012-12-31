module ConnectFour
  module Serialization
    class SqliteSerializer < Serializer
      def initialize(connection_string)
        @connection_string = connection_string
      end

      def names
        #TODO: implement
      end

      private

      def save(name, game_coded)
        #TODO overwrite if the file is existing
      end

      def load(name)
        #TODO return nil if the name doesn't exist
      end
    end
  end
end