module ConnectFour
  module UI

    NameActionPair = Struct.new(:name, :action)

    class MenuBase
      include Rubygame

      def initialize(main_view, title)
        @selected_option_background = [42, 117, 169]
        @title_font_size = 90
        @options_font_size = 50
        @text_color = [100, 68, 54]
        @main_view = main_view
        @title = title
        @options = []
        @font_name = "FreeSans.ttf"
        @selected_option = 0
      end

      def update
        TTF.setup
		    draw_title
        draw_options
      end

      def key_down(key)
        case key
          when K_UP then @selected_option -= 1 unless @selected_option == 0
          when K_DOWN then @selected_option += 1 unless @selected_option == @options.length - 1
          when K_RETURN then @options[@selected_option].action.call
          when K_ESCAPE then close_menu
        end
      end

      def add_option(name, action)
        @options <<  NameActionPair.new("  #{name}  ", action)
      end

      private

      def draw_title
        font = TTF.new(@font_name, @title_font_size)
		    text = font.render(@title, true, @text_color)
		    render_text_centered(text, 0)
      end

      def draw_options
        font = TTF.new(@font_name, @options_font_size)
        @options.map(&:name).each_with_index do |option, index|
          text = index == @selected_option ?
            font.render(option, true, @text_color, @selected_option_background) :
            font.render(option, true, @text_color)

          offset = 2 * index * @options_font_size + @title_font_size * 2
          render_text_centered(text, offset)
        end
      end

      def render_text_centered(text_object, offset)
        text_position = text_object.make_rect()
		    text_position.centerx = @main_view.surface.width / 2
        text_position.centery += offset
		    text_object.blit(@main_view.surface, text_position)
      end
    end
  end
end