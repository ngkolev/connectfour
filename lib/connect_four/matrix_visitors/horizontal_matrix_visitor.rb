module ConnectFour
  module MatrixVisitors
    class HorizontalMatrixVisitor < MatrixVisitor
      include Enumerable

      def each_line
        @matrix.each { |item| yield item }
      end

      alias each each_line
    end
  end
end