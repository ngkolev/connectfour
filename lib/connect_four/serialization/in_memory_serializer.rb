module ConnectFour
  module Serialization
    class InMemorySerializer < Serializer
      def save(name, game_coded)
        ensure_cache_hash
        @@cache_hash[name] = game_coded
      end

      def load(name)
        ensure_cache_hash
        @@cache_hash[name]
      end

      def names
        ensure_cache_hash
        @@cache_hash.keys
      end

      def ensure_cache_hash
        if not defined? @@cache_hash
          @@cache_hash = Hash.new
        end
      end
    end
  end
end