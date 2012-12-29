require 'rubygame'

require_relative '../../connect_four'
require_relative 'game_board_view'
require_relative 'home_view'
require_relative 'load_game_view'
require_relative 'pause_view'
require_relative 'save_game_view'
require_relative 'settings_view'
require_relative 'ui_constants'

module ConnectFour
  module UI
    class MainView
      include Rubygame

      attr_accessor :surface

      def initialize
        Rubygame.init
        resources_dir = File.join(File.dirname(__FILE__), '../../../', 'resources')
        Surface.autoload_dirs = [resources_dir]
        @screen = Screen.new(Screen.get_resolution, 0, [HWSURFACE, DOUBLEBUF, FULLSCREEN])
        @background_color = LIGHT_BACKGROUND
        @screen.show_cursor = false
        @screen.title = 'Connect Four'
        @screen.update
        @queue = EventQueue.new
        @clock = Clock.new
        @home= HomeView.new(self)
        @view = @home
        @game = Core::GameEngine.new(10, 3, 4, :second) #TODO board_size, depth, cells_to_win, ai_player
      end

      def init
        begin
          loop do
            @clock.tick
            handle_events
            draw
          end
        ensure
          Rubygame.quit
        end
      end

      def start_new_game
        @home = @view
        @view = GameBoardView.new(self, @game)
      end

      def continue_game
        @view = GameBoardView.new(self, @game)
      end

      def open_load_game_menu
        @home = @view
        @view = LoadGameView.new(self)
      end

      def open_settings
        @home = @view
        @view = SettingsView.new(self)
      end

      def open_home
        @view = @home
      end

      private

      def handle_events
        @queue.each do |event|
          case event
            when QuitEvent then exit
            when KeyDownEvent then @view.key_down(event.key)
          end
        end
      end

      def draw
        @surface = Surface.new(@screen.size)
        @surface.fill(@background_color)
        @view.update()
        @surface.blit(@screen, [0,0])
        @screen.update()
      end
    end
  end
end