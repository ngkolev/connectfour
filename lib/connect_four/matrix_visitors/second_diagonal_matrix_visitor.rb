module ConnectFour
  module MatrixVisitors
    class SecondDiagonalMatrixVisitor < MatrixVisitor
      include Enumerable

      def each_line
        (@length - 1).times { |y| yield get_second_diagonal_line(0, y) }
        @length.times { |x| yield get_second_diagonal_line(x, @length - 1) }
      end

      alias each each_line

      private

      def get_second_diagonal_line(x, y)
        result = []
        while x < @length and 0 <= y
          result << @matrix[x][y]
          x += 1
          y -= 1
        end
        result
      end
    end
  end
end