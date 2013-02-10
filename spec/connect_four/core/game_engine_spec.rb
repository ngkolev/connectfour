require 'spec_helper'

module ConnectFour
  module Core
    describe GameEngine do

      let(:engine) { GameEngine.new(3, 2, 3) }
      let(:first_won_board) do
        [
          [:first, nil, nil],
          [:second, :first, nil],
          [:second, :second, :first]
        ]
      end
      let(:one_move_to_win_board) do
      [
        [nil, nil, nil],
        [nil, :first, :first],
        [:first, :second, :second]
      ]
      end

      describe "#initialize" do
        it "creates an empty board if the given size and attributes set" do
          engine.board.board.should eq 3.times.map { [nil] * 3 }.to_a
          engine.current_player.should eq :first
          engine.depth.should eq 2
          engine.board.cells_to_win.should eq 3
        end
      end

      describe "#last_move?" do
        it "is false on empty board" do
          engine.last_move?.should be_false
        end

        it "is true when the board is full" do
          engine.board.board = 3.times.map { [:first] * 3 }
          engine.last_move?.should be_true
        end

        it "is true when there is a winner" do
          engine.board.board = first_won_board
          engine.last_move?.should be_true
        end
      end

      describe "#winner" do
        it "is nil on empty board" do
          engine.winner.should be_nil
        end

        it "is shows the correct winner if there is one" do
          engine.board.board = first_won_board
          engine.winner.should eq :first
        end
      end

      describe "#try_make_move" do
        it "makes valid move, changes the board and returns true" do
          engine.board.board = one_move_to_win_board
          engine.try_make_move(0).should be_true
          engine.board.board.should eq\
            [
              [nil, nil, nil],
              [:first, :first, :first],
              [:first, :second, :second]
            ]
          end

        it "return false if the move is invalid and returns the same board" do
          engine.board.board = first_won_board
          engine.try_make_move(3).should be_false
          engine.board.board.should eq first_won_board
          engine.try_make_move(-1).should be_false
          engine.board.board.should eq first_won_board
          engine.try_make_move(0).should be_false
          engine.board.board.should eq first_won_board
        end
      end

      describe "ai_move" do
        it "makes killer moves(only one move to win the game" do
          engine.board.board = one_move_to_win_board
          engine.ai_move
          engine.winner.should eq :first
        end

        it "makes move when it is the only available to not lose the game" do
          engine.board.board = one_move_to_win_board
          engine.instance_variable_set :@current_player , :second
          engine.ai_move
          engine.winner.should be_nil
          engine.board.board.should eq\
          [
            [nil, nil, nil],
            [:second, :first, :first],
            [:first, :second, :second]
          ]
        end
      end
    end
  end
end