require 'spec_helper'

module ConnectFour
  module MatrixVisitors
    describe SecondDiagonalMatrixVisitor do
      let(:visitor) { SecondDiagonalMatrixVisitor.new [[1, 2, 3], [4, 5, 6], [7, 8, 9]] }
      describe "#each" do
        it "visits the cells in the correct order" do
          lines = visitor.map { |line| line.to_a }
          lines.to_a.should eq [[1], [2, 4], [3, 5, 7], [6, 8], [9]]
        end
      end
    end
  end
end