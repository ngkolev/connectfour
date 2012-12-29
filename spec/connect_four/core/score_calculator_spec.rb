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

        it "is equal to 14 000 when only four in a horizontal row for the player and -14 000 for the other player" do
          board.board =
          [
            [nil, nil, nil, nil, nil],
            [nil, nil, nil, :second, nil],
            [nil, nil, nil, :second, nil],
            [nil, nil, nil, :second, nil],
            [nil, nil, nil, :second, nil],
          ]
          ScoreCalculator.new(:second, board).score.should eq 14000
          ScoreCalculator.new(:first, board).score.should eq -14000
        end
      end
    end
  end
end