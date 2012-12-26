require 'spec_helper'

module ConnectFour
  module MatrixVisitors
    describe MatrixVisitor do
        let(:visitors) { MatrixVisitor.get_visitors([[1, 2, 3], [4, 5, 6], [7, 8, 9]] ) }
        describe "#get_visitors" do
          it "contains horizontal matrix visitor" do
            visitors.map(&:class).should include HorizontalMatrixVisitor
          end

          it "contains vertical matrix visitor" do
            visitors.map(&:class).should include VerticalMatrixVisitor
          end

          it "contains first diagonal matrix visitor" do
            visitors.map(&:class).should include FirstDiagonalMatrixVisitor
          end

          it "contains second diagonal matrix visitor" do
            visitors.map(&:class).should include SecondDiagonalMatrixVisitor
          end
        end
    end
  end
end