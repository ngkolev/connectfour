module ConnectFour
  module Serialization
    class DummySerializer < Serializer
      attr_accessor :game_coded

      def save(name, game_coded)
        @game_coded = game_coded
      end

      def load(name)
        @game_coded
      end
    end

    describe Serialization do
      let(:game_coded) { '5 3 7 1 0000000100002001222121211' }
      let(:game) do
        matrix =
          [
            [nil, nil, nil, nil, nil],
            [nil, nil, :first, nil, nil],
            [nil, nil, :second, nil, nil],
            [:first, :second, :second, :second, :first],
            [:second, :first, :second, :first, :first],
          ]
        board = Core::Board.new(5, 3, matrix)
        Game.new(board, 7, :first)
      end

      describe "#save" do
        it "encodes the game board correct" do
          DummySerializer.new.serialize('saved_game', game).should eq game_coded
        end
      end

      describe "#load" do
        it "decodes the game board correct" do
          serializer = DummySerializer.new
          serializer.game_coded = game_coded
          loaded_game = serializer.deserialize('saved_name')
          loaded_game.board.should eq game.board
          loaded_game.ai_player.should eq :first
          loaded_game.depth.should eq 7
        end
      end
    end
  end
end