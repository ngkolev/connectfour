require 'mysql'

module ConnectFour
  module Serialization
    class SqlSerializer < Serializer
      def initialize(address, name, pass, db_name)
        @address = address
        @name = name
        @pass = pass
        @db_name = db_name
      end

      def names
        with_connection do |connection|
          query = connection.query('SELECT game_name FROM saves')
          result = []
          query.each_hash do |row|
            result << row["game_name"]
          end
          result
        end
      end

      private

      def save(name, game_coded)
        with_connection do |connection|
          connection.query("DELETE FROM saves WHERE game_name = '#{name}'")
          connection.query("INSERT INTO saves(game_name, game_coded)\
            VALUES('#{name}', '#{game_coded}')")
        end
      end

      def load(name)
        with_connection do |connection|
          query = connection.query("SELECT game_coded FROM saves WHERE game_name = '#{name}'")
          query.fetch_row[0]
        end
      end

      def with_connection
        begin
          connection = Mysql.new(@address, @name, @pass, @db_name)
          yield connection
        ensure
          connection.close if connection
        end
      end
    end
  end
end