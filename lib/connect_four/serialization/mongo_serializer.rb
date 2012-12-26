require 'mongo'

module ConnectFour
  module Serialization
    class MongoSerializer < Serializer
      def initialize(connection_string, port, database_name)
        client = Mongo::MongoClient.new(connection_string, port)
        database = client[database_name]
        @collection = database['game_saves']
      end

      def save(name, game_coded)
        @collection.insert("_id" => name, "game" => game_coded)
      end

      def load(name)
        result = @collection.find_one("_id" => name)
        result.nil? ? nil : result["game"]
      end

      def names
        @collection.find.map { |item| item["_id"] }
      end
    end
  end
end