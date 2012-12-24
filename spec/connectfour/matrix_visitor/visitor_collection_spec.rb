require 'spec_helper'

module ConnectFour
  describe MatrixVisitor do
      let(:matrix) { [[1, 2, 3], [4, 5, 6], [7, 8, 9]] }

      describe "::get_visitors" do
        it "contains all defined visitors" do
          visitors = get_visitors(matrix)
          visitors.should include [HorizontalMatrixVisitor, VerticalMatrixVisitor,
                                  FirstDiagonalMatrixVisitor, SecondDiagonalMatrixVisitor]
        end
        end
  end
end