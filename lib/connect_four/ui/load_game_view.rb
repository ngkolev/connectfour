require_relative 'menu_base'

module ConnectFour
  module UI
    class LoadGameView < MenuBase
      def initialize(main_view)
        super(main_view, 'Load game')
        @main_view.serializer.names.each do |name|
          add_option(name, lambda { @main_view.load_game(name) })
        end
      end

      def close_menu
        @main_view.open_home
      end

      private


    end
  end
end