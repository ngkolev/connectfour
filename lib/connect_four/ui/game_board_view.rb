module ConnectFour
  module UI
    class GameBoardView
      include Rubygame

      def initialize(main_view, game)
        @main_view = main_view
        @game = game
        @hand_image = Surface['hand.gif']
		    @hand_image.set_colorkey(@hand_image.get_at([0,0]))
        @selected_board_row = 0
      end

      def update
        draw_board
        draw_hand
        draw_discs
        draw_turn_text
      end

      def key_down(key)
        case key
          when K_ESCAPE
            @main_view.open_home
          when K_LEFT
            @selected_board_row -= 1 unless @selected_board_row == 0
          when K_RIGHT
            @selected_board_row += 1 unless @selected_board_row == @game.board.size - 1
          when K_DOWN then nil #TODO
        end
      end

      private

      def draw_board
        Draw#line(@main_view.surface, [0, 0], [100, 100], [0, 0, 0])
      end

      def draw_hand
        #TODO only if it's human's turn
        rect = @hand_image.make_rect
        rect.centerx = @selected_board_row * 50
        @hand_image.blit(@main_view.surface, rect)
      end

      def draw_discs
        #TODO
      end

      def draw_turn_text
        font = TTF.new(@font_name, @options_font_size)
      end
    end
  end
end