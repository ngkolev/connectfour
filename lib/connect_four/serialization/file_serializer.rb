module ConnectFour
  module Serialization
    class FileSerializer < Serializer
      SAVE_FORMAT = 'sav'

      def initialize(save_file_path)
        @save_file_path = save_file_path
      end

      def names
        Dir["#{@save_file_path}/*.#{SAVE_FORMAT}"].map do |file_name|
          File.basename(file_name, ".#{SAVE_FORMAT}")
        end
      end

      private

      def save(name, game_coded)
        full_name = get_full_path(name)
        File.open(full_name, 'w') { |file| file.write(game_coded) }
      end

      def load(name)
        full_name = get_full_path(name)
        if File.exists?(full_name)
          File.open(full_name, 'r') { |file| file.readline }
        end
      end

      def get_full_path(name)
        "#{@save_file_path}/#{name}.#{SAVE_FORMAT}"
      end
    end
  end
end