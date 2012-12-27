require 'rubygame'
require_relative 'home_view'

module ConnectFour
  module UI
    class MainView
      include Rubygame

      attr_accessor :surface

      def initialize
        super
        @screen = Screen.new(Screen.get_resolution, 0, [HWSURFACE, DOUBLEBUF, FULLSCREEN])
        @background_color = [126, 181, 214]
        @screen.show_cursor = false
        @screen.title = 'Connect Four'
        @screen.update
        @queue = EventQueue.new
        @clock = Clock.new
        @view = HomeView.new(self)
      end

      def start
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
        #TODO
      end

      def open_load_game
        #TODO
      end

      def open_settings
        #TODO
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