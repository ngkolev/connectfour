module ConnectFour
  module UI
    class MenuBase
      include Rubygame

      def initialize(main_view, title)
        @main_view = main_view
        @title = title
        @options = Hash.new
        @text_color = [10, 10, 10]
        @font_name = "FreeSans.ttf"
        @font_size = 25
      end

      def update
        TTF.setup
		    font = TTF.new(@font_name, @font_size)
		    text = font.render(@title, true, @text_color)
		    text_position = text.make_rect()
		    text_position.centerx = @main_view.surface.width / 2
		    text.blit(@main_view.surface, text_position)
      end

      def key_down(key)
        #TODO
      end

      def mouse_moved(x, y)
        #TODO
      end

      def left_key_down(x, y)
        #TODO
      end
    end
  end
end