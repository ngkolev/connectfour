require 'spec_helper'

module ConnectFour
  module MatrixVisitors
    describe FirstDiagonalMatrixVisitor do
      let(:visitor) { FirstDiagonalMatrixVisitor.new [[1, 2, 3], [4, 5, 6], [7, 8, 9]] }
      describe "#visit_lines" do
        it "visits the cells in the correct order" do
          lines = visitor.map { |line| line.to_a }
          lines.to_a.should eq [[7], [4, 8], [1, 5, 9], [2, 6], [3]]
        end
      end
    end
  end
end