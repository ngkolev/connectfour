require_relative 'menu_base'

module ConnectFour
  module UI
    class PauseView < MenuBase
      def initialize(main_view)
        super(main_view, 'Pause')
        add_option('Continue', lambda { @main_view.continue_game })
        add_option('Save', lambda { @main_view.open_save_game })
        add_option('Main menu', lambda { @main_view.open_home })
        add_option('Exit game', lambda { exit })
      end

      def close_menu
        @main_view.continue_game
      end
    end
  end
end