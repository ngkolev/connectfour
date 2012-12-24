module ConnectFour
  class ScoreCalculator
   def initialize(player, board)
     @player = player
     @board = board
   end

  def score
    @score = 0
    other_player = @player == :first ? :second : :first
    MatrixVisitor::get_visitors(@board).each do |visitor|
      add_to_score(player, visitor, 1)
      add_to_score(player, visitor, -1)
    end
    @score
  end

   private

   def add_to_score(player, visitor, sign)
     #TODO: implement
   end

   def calculate_score(captured_cells, empty_cells)
     captured_cells * 1000 + empty * 100
   end
  end
end