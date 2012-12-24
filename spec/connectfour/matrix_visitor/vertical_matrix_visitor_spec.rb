require 'spec_helper'

module ConnectFour
  module MatrixVisitor
    describe VerticalMatrixVisitor do
      let(:visitor) { VerticalMatrixVisitor.new [[1, 2, 3], [4, 5, 6], [7, 8, 9]] }

      describe "#each" do
        it "visits the cells in the correct order" do
          lines = visitor.map { |line| line.to_a }
          lines.to_a.should eq [[1, 4, 8], [2, 5, 8], [3, 6, 9]]
        end
        end
    end
  end
end