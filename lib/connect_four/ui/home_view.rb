require_relative 'menu_base'

module ConnectFour
  module UI
    class HomeView < MenuBase
      def initialize(main_view)
        super(main_view, 'Connect Four')
        add_option('New game', lambda { @main_view.start_new_game })
        add_option('Load game', lambda { @main_view.open_load_game_menu })
        add_option('Settings', lambda { @main_view.open_settings } )
        add_option('Exit', lambda { exit })
      end

      def close_menu
        exit
      end
    end
  end
end