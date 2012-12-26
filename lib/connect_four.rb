require 'connect_four/matrix_visitors/matrix_visitor'
require 'connect_four/matrix_visitors/horizontal_matrix_visitor'
require 'connect_four/matrix_visitors/vertical_matrix_visitor'
require 'connect_four/matrix_visitors/first_diagonal_matrix_visitor'
require 'connect_four/matrix_visitors/second_diagonal_matrix_visitor'

require 'connect_four/serialization/game'
require 'connect_four/serialization/serializer'
require 'connect_four/serialization/file_serializer'
require 'connect_four/serialization/in_memory_serializer'
require 'connect_four/serialization/mongo_serializer'
require 'connect_four/serialization/sqlite_serializer'

require 'connect_four/core/board'
require 'connect_four/core/game_engine'
require 'connect_four/core/score_calculator'

require 'connect_four/config'