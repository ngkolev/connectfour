require_relative 'menu_base'

module ConnectFour
  module UI
    class PauseView < MenuBase
      def initialize(main_view)
        super(main_view, 'Pause')
        add_option('Test1', lambda {  })
        #TODO
      end

      def close_menu
        @main_view.continue_game
      end
    end
  end
end