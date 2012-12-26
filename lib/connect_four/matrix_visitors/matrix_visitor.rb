module ConnectFour
  module MatrixVisitors
    class MatrixVisitor
      attr_reader :matrix

      def MatrixVisitor.get_visitors(matrix)
        [HorizontalMatrixVisitor.new(matrix),
          VerticalMatrixVisitor.new(matrix),
          FirstDiagonalMatrixVisitor.new(matrix),
          SecondDiagonalMatrixVisitor.new(matrix)]
      end

      def initialize(matrix)
        @matrix = matrix
        @length = matrix.length
      end
    end
  end
end
