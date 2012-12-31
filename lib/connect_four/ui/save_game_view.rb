module ConnectFour
  module UI
    class SaveGameView
      include Rubygame

      MAX_LENGTH = 25
      MIN_LENGTH = 3
      INVALID_CHARACTERS = ['\\', '/', ':', '*', '?', '"', '<', '>', '|']

      def initialize(main_view)
        @main_view = main_view
        @game = main_view.game
        @font_name = "../resources/#{FONT_NAME}"
        @text = ''
      end

      def update
        font = TTF.new(@font_name, TEXT_FONT_SIZE)
        text = font.render("Save name: #{@text}", true, TEXT_COLOR)
		    text.blit(@main_view.surface, [0, 0])
      end

      def key_down(key)
        case key
          when K_ESCAPE then @main_view.continue_game
          when K_RETURN then save_game if MIN_LENGTH <= @text.length
          when K_BACKSPACE then @text.chop! if 0 < @text.length
          else
            if @text.length <= MAX_LENGTH
              input = Rubygame::key2str(key, [])
              @text << input unless INVALID_CHARACTERS.include?(input)
            end
        end
      end

      def save_game
        game = Serialization::Game.new(@game.board, @game.depth, @game.ai_player)
        @main_view.serializer.serialize(@text, game)
        @main_view.continue_game
      end
    end
  end
end