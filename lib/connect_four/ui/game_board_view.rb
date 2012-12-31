module ConnectFour
  module UI
    class GameBoardView
      include Rubygame

      NOTIFICATIONS_AVAILABLE_HEIGHT = 170

      def initialize(main_view)
        @main_view = main_view
        @game_engine = main_view.game
        @game_board = main_view.game.board
        @hand_image = Surface['hand.gif']
		    @hand_image.set_colorkey(@hand_image.get_at([0,0]))
        @selected_board_row = 0
        @font_name = "../resources/#{FONT_NAME}"
        @is_game_finished = false
        set_board_parameters
      end

      def update
        draw_board
        draw_hand
        draw_discs
        draw_notifications
      end

      def key_down(key)
        case key
          when K_ESCAPE
            if @game_engine.last_move? then @main_view.open_home
            elsif not @game_engine.ai_turn? then @main_view.open_pause
            end
          when K_LEFT
            @selected_board_row -= 1 unless @selected_board_row == 0
          when K_RIGHT
            @selected_board_row += 1 unless @selected_board_row == @game_board.size - 1
          when K_SPACE, K_RETURN
            make_move
        end
      end

      private

      def draw_board
        surface = @main_view.surface
        (@game_board.size + 1).times do |index|
          y_position = index * @cell_size + @board_start_y
          x_position = index * @cell_size + @board_start_x
          surface.draw_line([@board_start_x, y_position], [@board_end_x, y_position], DARK_BACKGROUND)
          surface.draw_line([x_position, @board_start_y], [x_position, @board_end_y], DARK_BACKGROUND)
        end
      end

      def draw_hand
        unless @game_engine.ai_turn? or @game_engine.last_move?
          rect = @hand_image.make_rect
          rect.x = @selected_board_row * @cell_size + @board_start_x
          @hand_image.blit(@main_view.surface, rect)
        end
      end

      def draw_discs
        @game_board.board.each_with_index do |line, y|
          line.each_with_index do |cell, x|
            if cell
              draw_circle(x, y, cell)
            end
          end
        end
      end

      def draw_notifications
        font = TTF.new(@font_name, TEXT_FONT_SIZE)
        if @game_engine.last_move?
          text_to_display = game_over_text
        else
          text_to_display = @main_view.game.ai_turn? ? "AI's turn" : "Your turn"
        end
        text = font.render(text_to_display, true, TEXT_COLOR, DARK_BACKGROUND)
        text.blit(@main_view.surface, [30, @main_view.surface.height - TEXT_FONT_SIZE - 40])
      end

      def draw_circle(x, y, player)
        half_cell_size = @cell_size / 2.to_f
        center_x = x * @cell_size + @board_start_x + half_cell_size
        center_y = y * @cell_size + @board_start_y + half_cell_size
        radius = (@cell_size / 2.to_f) - 10
        color = player == :first ? FIRST_PLAYER_COLOR : SECOND_PLAYER_COLOR
        @main_view.surface.draw_circle_s([center_x, center_y], radius, color)
      end

      def set_board_parameters
        surface = @main_view.surface
        @board_size = [surface.width, surface.height - NOTIFICATIONS_AVAILABLE_HEIGHT].min
        @cell_size = @board_size / @game_board.size.to_f
        @board_start_x = (surface.width - @board_size) / 2
        @board_end_x = @board_start_x + @board_size
        @board_start_y = (surface.height - @board_size) / 2
        @board_end_y = @board_start_y + @board_size
      end

      def game_over_text
        case @game_engine.winner
          when @game_engine.ai_player then "You lost"
          when @game_engine.human_player then "You won"
          else "Game over. Draw"
        end
      end

      def make_move
        unless @game_engine.ai_turn? or @game_engine.last_move?
          @game_engine.try_make_move(@selected_board_row)
          Thread.new do
            @game_engine.ai_move unless @game_engine.last_move?
          end
        end
      end
    end
  end
end