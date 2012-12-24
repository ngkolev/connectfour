module ConnectFour
  module MatrixVisitor
    class FirstDiagonalMatrixVisitor
      def initialize(matrix)
        @matrix = matrix
        @length = matrix.length
      end

      def each
        (@length - 1).downto(0).each { |x| yield get_first_diagonal_line(x, 0) }
        (0).upto(@length - 1).each { |y| yield get_first_diagonal_line(0, y) }
      end

      private

      def get_first_diagonal_line(x, y)
        while x < @length and y < @length
          yield @matrix[x][y]
          x += 1
          y += 1
        end
      end
    end
  end
end


arr = [[1,2,3],[4,5,6],[7,8,9]]
a = ConnectFour::MatrixVisitor::FirstDiagonalMatrixVisitor.new(arr)
p a.each   { |line| line.each { |item| item } }
