require 'spec_helper'

module ConnectFour
  module Core
    describe GameEngine do
      describe "#initialize" do
        it "creates an empty board if the given size and attributes set" do
          #TODO
        end
      end

      describe "#last_move?" do
        it "is false on empty board" do
          #TODO
        end

        it "is true when the board is full" do
          #TODO
        end

        it "is true when there is a winner" do
          #TODO
        end
      end

      describe "#winner" do
        it "is nil on empty board" do
          #TODO
        end

        it "is shows the correct winner if there is one" do
          #TODO
        end
      end

      describe "#try_make_move" do
        it "makes valid move, changes the board and returns true" do
          #TODO
        end

        it "return false if the valid is invalid and returns the same board" do
          #TODO
        end
      end

      describe "ai_move" do
        it "makes killer moves(only one move to win the game" do
          #TODO
        end

        it "makes move when it is the only avaiable to not lose the game" do
          #TODO
        end
      end
    end
  end
end