require_relative 'menu_base'

module ConnectFour
  module UI
    class LoadGameView < MenuBase
      def initialize(main_view)
        super(main_view, 'Load game')
        add_option('Test1', lambda {  })
        #TODO
      end

      def close_menu
        @main_view.open_home
      end
    end
  end
end