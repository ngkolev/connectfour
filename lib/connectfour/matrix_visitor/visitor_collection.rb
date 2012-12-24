module ConnectFour
  module MatrixVisitor
    def get_visitors(matrix)
      yield HorizontalMatrixVisitor.new(matrix)
      yield VerticalMatrixVisitor.new(matrix)
      yield FirstDiagonalMatrixVisitor.new(matrix)
      yield SecondDiagonalMatrixVisitor.new(matrix)
    end
  end
end