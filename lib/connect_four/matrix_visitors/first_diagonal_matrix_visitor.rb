module ConnectFour
  module MatrixVisitors
    class FirstDiagonalMatrixVisitor < MatrixVisitor
      include Enumerable

      def each_line
        (@length - 1).downto(1) { |x| yield get_first_diagonal_line(x, 0) }
        @length.times { |y| yield get_first_diagonal_line(0, y) }
      end

      alias each each_line

      private

      def get_first_diagonal_line(x, y)
        result = []
        while x < @length and y < @length
          result << @matrix[x][y]
          x += 1
          y += 1
        end
        result
      end
    end
  end
end
