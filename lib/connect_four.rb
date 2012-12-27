require_relative 'connect_four/matrix_visitors/matrix_visitor'
require_relative 'connect_four/matrix_visitors/horizontal_matrix_visitor'
require_relative 'connect_four/matrix_visitors/vertical_matrix_visitor'
require_relative 'connect_four/matrix_visitors/first_diagonal_matrix_visitor'
require_relative 'connect_four/matrix_visitors/second_diagonal_matrix_visitor' 
                         
require_relative 'connect_four/core/util'
require_relative 'connect_four/core/board'
require_relative 'connect_four/core/game_engine'
require_relative 'connect_four/core/score_calculator'

require_relative 'connect_four/serialization/game'
require_relative 'connect_four/serialization/serializer'
require_relative 'connect_four/serialization/file_serializer'
require_relative 'connect_four/serialization/in_memory_serializer'
require_relative 'connect_four/serialization/mongo_serializer'
require_relative 'connect_four/serialization/sqlite_serializer'

require_relative 'connect_four/configurations'
