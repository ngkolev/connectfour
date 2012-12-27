module ConnectFour
  module UI
    class SaveGameView
      include Rubygame

      def initialize(main_view)
        @main_view = main_view
      end

      def update
        #TODO
      end

      def key_down(key)
        case key
          when K_ESCAPE then @main_view.continue_game
        end
      end
    end
  end
end