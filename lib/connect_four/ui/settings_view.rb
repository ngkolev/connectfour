require_relative 'menu_base'

module ConnectFour
  module UI
    class SettingsView < MenuBase
      def initialize(main_view)
        super(main_view, 'Settings')
        add_option('Test1', lambda {  })
        #TODO
      end

      def close_menu
        @main_view.open_home
      end
    end
  end
end