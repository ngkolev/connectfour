require 'rubygame'
require_relative 'menu_base'

module ConnectFour
  module UI
    class MainView
      include Rubygame

      attr_accessor :surface

      def initialize
        super
        @screen = Screen.new([468, 468])
        @background_color = [250, 250, 250]
        @screen.title = 'Connect Four'
        @screen.update
        @queue = EventQueue.new
        @clock = Clock.new
        @view = MenuBase.new(self, "MENU")
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

      private

      def handle_events
      @queue.each do |event|
        case event
          when QuitEvent then exit
          when KeyDownEvent then @view.key_down(event.key)
          when MouseMotionEvent then @view.mouse_moved(*event.pos)
          when MouseDownEvent
            @view.left_key_down(*event.pos) if event.button == MOUSE_LEFT
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