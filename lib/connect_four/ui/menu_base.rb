module ConnectFour
  module UI

    NameActionPair = Struct.new(:name, :action)

    class MenuBase
      include Rubygame

      def initialize(main_view, title)
        @font_name = "../resources/#{FONT_NAME}"
        @main_view = main_view
        @title = title
        @options = []
        @selected_option = 0
      end

      def update
		    draw_title
        draw_options
      end

      def key_down(key)
        case key
          when K_UP then
            @selected_option = @selected_option == 0 ? @options.length - 1 : @selected_option - 1
          when K_DOWN then
            @selected_option = (@selected_option + 1) % @options.length unless @options.empty?
          when K_RETURN then @options[@selected_option].action.call
          when K_ESCAPE then close_menu
        end
      end

      def add_option(name, action)
        @options <<  NameActionPair.new("  #{name}  ", action)
      end

      private

      def draw_title
        font = TTF.new(@font_name, TITLE_FONT_SIZE)
		    text = font.render(@title, true, TEXT_COLOR)
		    render_text_centered(text, 0)
      end

      def draw_options
        font = TTF.new(@font_name, TEXT_FONT_SIZE)
        @options.map(&:name).each_with_index do |option, index|
          text = index == @selected_option ?
            font.render(option, true, TEXT_COLOR, DARK_BACKGROUND) :
            font.render(option, true, TEXT_COLOR)

          offset = 2 * index * TEXT_FONT_SIZE + TITLE_FONT_SIZE * 2
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