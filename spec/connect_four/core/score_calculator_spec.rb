require 'spec_helper'

module ConnectFour
  module Core
    describe ScoreCalculator do

      let(:board) { Board.new(5, 4) }

      describe "#score" do
        it "is equal to 0 on empty board for both players" do
          board.board = 5.times.map { [nil] * 5 }
          ScoreCalculator.new(:first, board).score.should eq 0
          ScoreCalculator.new(:second, board).score.should eq 0
        end
      end
    end
  end
end