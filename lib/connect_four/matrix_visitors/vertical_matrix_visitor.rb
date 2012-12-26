module ConnectFour
  module MatrixVisitors
    class VerticalMatrixVisitor < MatrixVisitor
      include Enumerable

      def each_line
        @matrix.transpose.each { |item| yield item }
      end

      alias each each_line
    end
  end
end