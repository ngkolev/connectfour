require 'rubygame'

require_relative '../../connect_four'
require_relative 'game_board_view'
require_relative 'home_view'
require_relative 'load_game_view'
require_relative 'pause_view'
require_relative 'save_game_view'
require_relative 'ui_constants'

module ConnectFour
  module UI
    class MainView
      include Rubygame

      attr_accessor :surface, :game, :serializer

      def initialize
        Rubygame.init
        TTF.setup
        resources_dir = File.join(File.dirname(__FILE__), '../../../', 'resources')
        Surface.autoload_dirs = [resources_dir]
        create_ui_objects
        create_game_objects
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
        @view = GameBoardView.new(self)
      end

      def continue_game
        @view = GameBoardView.new(self)
      end

      def open_load_game_menu
        @home = @view
        @view = LoadGameView.new(self)
      end

      def open_home
        @view = @home
      end

      def open_pause
        @view = PauseView.new(self)
      end

      def open_save_game
        @view = SaveGameView.new(self)
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
        @view.update
        @surface.blit(@screen, [0,0])
        @screen.update
      end

      def create_game_objects
        settings = Configurations.new
        @game = Core::GameEngine.new(settings.board_size.to_i, settings.difficulty.to_i,
                                     settings.cells_to_win.to_i, settings.ai_player.to_sym)
        @serializer_type = settings.save_method.to_sym
        @serializer = Serialization::Serializer.create_serializer(@serializer_type)
        @queue = EventQueue.new
        @clock = Clock.new
      end

      def create_ui_objects
        @home = HomeView.new(self)
        @view = @home
        @screen = Screen.new(Screen.get_resolution, 0, [HWSURFACE, DOUBLEBUF, FULLSCREEN])
        @background_color = LIGHT_BACKGROUND
        @screen.show_cursor = false
        @screen.title = 'Connect Four'
        @screen.update
      end
    end
  end
end