require 'spec_helper'

module ConnectFour
  module Core
    describe Board do

      let(:board) { Board.new(5, 4) }

      describe "#generate_valid_moves" do
        it "has all moves available if the board is empty" do
          board.generate_valid_moves(:first).to_a.should eq (0..4).to_a
        end

        it "has no moves available if the board is full" do
          board.board = 5.times.map { [:first] * 5 }
          board.generate_valid_moves(:first).should be_empty
        end

        it "has moves in columns that are not full" do
          board.board = 5.times.map { [:first] + [nil] * 4 }
          board.generate_valid_moves(:first).to_a.should eq (1..4).to_a
        end
      end

      describe "#move" do
        it "places player's discs not correct location'" do
          board.move!(3, :first)
          board.board.should eq\
          [
            [nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil],
            [nil, nil, nil, :first, nil],
          ]

          board.move!(3, :second)
          board.board.should eq\
          [
            [nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil],
            [nil, nil, nil, :second, nil],
            [nil, nil, nil, :first, nil],
          ]

          board.move!(4, :first)
          board.board.should eq\
          [
            [nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil],
            [nil, nil, nil, :second, nil],
            [nil, nil, nil, :first, :first],
          ]
        end
      end

      describe "#valid_move?" do
        it "allows to move on not full column" do
          board.board =
          [
            [nil, nil, nil, nil, nil],
            [nil, nil, nil, :second, nil],
            [nil, nil, nil, :first, nil],
            [nil, nil, nil, :second, nil],
            [nil, nil, nil, :first, nil],
          ]
          board.valid_move?(3).should be_true
          board.valid_move?(4).should be_true
        end

        it "disallows to move on full column" do
          board.board =
          [
            [nil, nil, nil, :first, nil],
            [nil, nil, nil, :second, nil],
            [nil, nil, nil, :first, nil],
            [nil, nil, nil, :second, nil],
            [nil, nil, nil, :first, nil],
          ]
          board.valid_move?(3).should be_false
        end
      end

      describe "board_full?" do
        it "returns false when the board is partially full" do
          board.board =
          [
            [nil, nil, nil, :first, nil],
            [nil, nil, nil, :second, nil],
            [nil, nil, nil, :first, nil],
            [nil, nil, nil, :second, nil],
            [nil, nil, nil, :first, nil],
          ]
          board.board_full?.should be_false
        end
        it "returns true when the board is full" do
          board.board =
          [
            [:first, :second, :first, :first, :second],
            [:first, :second, :first, :second, :first],
            [:first, :first, :first, :first, :second],
            [:second, :second, :second, :second, :first],
            [:first, :second, :first, :first, :second],
          ]
          board.board_full?.should be_true
        end
      end

      describe "#winner" do
        it "finds the winner when he exists" do
          board.board =
          [
            [nil, nil, nil, nil, nil],
            [nil, nil, nil, :first, nil],
            [nil, :second, nil, :first, nil],
            [nil, nil, :second, :first, nil],
            [nil, nil, nil, :first, nil],
          ]
          board.winner.should eq :first

          board.board =
          [
            [nil, nil, nil, nil, nil],
            [:second, :second, :second, :second, nil],
            [nil, nil, nil, :nil, nil],
            [:first, :first, nil, :first, nil],
            [nil, nil, nil, :first, nil],
          ]
          board.winner.should eq :second

          board.board =
          [
            [nil, nil, nil, nil, nil],
            [:first, nil, nil, nil, nil],
            [nil, :first, nil, :first, nil],
            [nil, nil, :first, :first, nil],
            [nil, nil, nil, :first, nil],
          ]
          board.winner.should eq :first

          board.board =
          [
            [nil, nil, nil, nil, :second],
            [nil, nil, nil, :second, nil],
            [nil, nil, :second, :first, nil],
            [nil, :second, nil, :first, nil],
            [nil, nil, nil, :first, nil],
          ]
          board.winner.should eq :second
        end

        it "finds no winner on empty board" do
          board.board =
          [
            [nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil],
          ]
          board.winner.should eq nil
        end

        it "finds no winner when there is no winner" do
          board.board =
          [
            [:first, :first, :first, :second, nil],
            [:second, nil, nil, :second, nil],
            [nil, :second, :first, :second, nil],
            [nil, :first, :second, nil, nil],
            [:first, nil, nil, nil, nil],
          ]
          board.winner.should eq nil
        end
      end
    end
  end
end