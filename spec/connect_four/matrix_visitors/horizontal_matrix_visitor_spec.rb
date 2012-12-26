require 'spec_helper'

module ConnectFour
  module MatrixVisitors
    describe HorizontalMatrixVisitor do
      let(:visitor) { HorizontalMatrixVisitor.new [[1, 2, 3], [4, 5, 6], [7, 8, 9]] }
      describe "#each" do
        it "visits the cells in the correct order" do
          lines = visitor.map { |line| line.to_a }
          lines.to_a.should eq [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
        end
      end
    end
  end
end