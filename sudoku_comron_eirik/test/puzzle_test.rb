require "test/unit"

require "../lib/puzzle"

class TestPuzzle < Test::Unit::TestCase  
  def setup
    @raw = [
      [nil, 6  , nil, 1  , nil, 4  , nil, 5  , nil],
      [nil, nil, 8  , 3  , nil, 5  , 6  , nil, nil],    
      [2  , nil, nil, nil, nil, nil, nil, nil, 1  ],
      [8  , nil, nil, 4  , nil, 7  , nil, nil, 6  ],    
      [nil, nil, 6  , nil, nil, nil, 3  , nil, nil],
      [7  , nil, nil, 9  , nil, 1  , nil, nil, 4  ],    
      [5  , nil, nil, nil, nil, nil, nil, nil, 2  ],
      [nil, nil, 7  , 2  , nil, 6  , 9  , nil, nil],    
      [nil, 4  , nil, 5  , nil, 8  , nil, 7  , nil]
    ]
   @puzzle = Puzzle.new(@raw)  
  end

  def test_row
    assert_equal @raw[1], @puzzle.row(1)
  end

  def test_column
    col = [6, nil, nil, nil, nil, nil, nil, nil, 4]
    assert_equal col, @puzzle.column(1)
  end
  
  def test_cell
    assert_equal 6, @puzzle[0][1]
  end
  
  def test_zone
    result = [4, nil, 7, nil, nil, nil, 9, nil, 1]
    assert_equal result, @puzzle.zone(4)
  end
  
  def test_zone_from_row_and_column
    assert_equal 5, @puzzle.zone_from_row_and_column(3, 6)    
    assert_equal 0, @puzzle.zone_from_row_and_column(0, 0)    
    assert_equal 8, @puzzle.zone_from_row_and_column(8, 8)
  end
  
  def test_row_column_from_zone_and_offset
    assert_equal [3,6], @puzzle.row_column_from_zone_and_offset(5, 0)
    assert_equal [6,3], @puzzle.row_column_from_zone_and_offset(7, 0)
    assert_equal [6,5], @puzzle.row_column_from_zone_and_offset(7, 2)
    assert_equal [8,4], @puzzle.row_column_from_zone_and_offset(7, 7)    
    assert_equal [0,0], @puzzle.row_column_from_zone_and_offset(0, 0)
    assert_equal [8,8], @puzzle.row_column_from_zone_and_offset(8, 8)
  end

  def test_piece_solved?
    assert ! Puzzle.piece_solved?([4, nil, 7, nil, nil, nil, 9, nil, 1])
    assert ! Puzzle.piece_solved?([1, 2, 3, 4, 5, 6, 7, 8, 1])
    assert ! Puzzle.piece_solved?([0, 1, 2, 3, 4, 5, 6, 7, 8, 1])
    assert ! Puzzle.piece_solved?([1, 2, 3, 4, 5, 6, 7, 8, 10])

    assert Puzzle.piece_solved?([1, 2, 3, 4, 5, 6, 7, 8, 9])
    assert Puzzle.piece_solved?([9, 2, 3, 4, 5, 6, 7, 8, 1])
  end
  
  def test_puzzle_solved
    solved_puzzle = [
      [9, 6  , 3 , 1  , 7, 4  , 2, 5  , 8],
      [1, 7, 8  , 3  , 2, 5  , 6  , 4, 9],    
      [2  , 5, 4, 6, 8, 9, 7, 3, 1  ],
      [8  , 2, 1, 4 , 3  , 7, 5, 9, 6  ],    
      [4, 9, 6  , 8, 5, 2, 3  , 1, 7],
      [7  , 3, 5, 9  , 6, 1  , 8, 2, 4  ],    
      [5  , 8, 9, 7, 1, 3, 4, 6, 2  ],
      [3, 1, 7  , 2  , 4, 6  , 9  , 8, 5],    
      [6, 4  , 2, 5  , 9, 8  , 1, 7  , 3]
    ]
    
    puzzle = Puzzle.new(solved_puzzle)
    assert puzzle.solved?

  end
  
  def test_puzzle_not_solved
    assert ! @puzzle.solved?
    
    not_solved_puzzle = [
      [9, 6  , 3 , 1  , 7, 4  , 2, 5  , 8],
      [1, nil, 8  , 3  , 2, 5  , 6  , 4, 9],    
      [2  , 5, 4, 6, 8, 9, 7, 3, 1  ],
      [8  , 2, 1, 4 , 3  , 7, 5, 9, 6  ],    
      [4, 9, 6  , 8, 5, 2, 3  , 1, 7],
      [7  , 3, 5, 9  , 6, 1  , 8, 2, 4  ],    
      [5  , 8, 9, 7, 1, 3, 4, 6, 2  ],
      [3, 1, 7  , 2  , 4, 6  , 9  , 8, 5],    
      [6, 4  , 2, 5  , 9, 8  , 1, 7  , 3]
    ]
    
    puzzle = Puzzle.new(not_solved_puzzle)
    assert ! puzzle.solved?
  end

  def test_possible_values_in_cell
    assert_equal [3,9], @puzzle.possible_values_for_cell( 0, 0 )
    assert_equal [2,5,8], @puzzle.possible_values_for_cell( 4, 4 )
  end
  
  def test_set_cell
    @puzzle[3][4] = 7 
    assert_equal 7, @puzzle[3][4]
  end

  def test_solve_cell
    assert @puzzle.solve_cell(8,6)
    assert_equal 1, @puzzle[8][6]

    assert @puzzle.solve_cell(8,8)
    assert_equal 3, @puzzle[8][8]

    assert !@puzzle.solve_cell(0,0)
    assert_equal nil, @puzzle[0][0]

    assert !@puzzle.solve_cell(0,1)
    assert_equal 6, @puzzle[0][1]        
  end
  
  def test_solve
    @puzzle.solve!
    assert @puzzle.solved?

    solved_puzzle = [
      [9, 6  , 3 , 1  , 7, 4  , 2, 5  , 8],
      [1, 7, 8  , 3  , 2, 5  , 6  , 4, 9],    
      [2  , 5, 4, 6, 8, 9, 7, 3, 1  ],
      [8  , 2, 1, 4 , 3  , 7, 5, 9, 6  ],    
      [4, 9, 6  , 8, 5, 2, 3  , 1, 7],
      [7  , 3, 5, 9  , 6, 1  , 8, 2, 4  ],    
      [5  , 8, 9, 7, 1, 3, 4, 6, 2  ],
      [3, 1, 7  , 2  , 4, 6  , 9  , 8, 5],    
      [6, 4  , 2, 5  , 9, 8  , 1, 7  , 3]
    ]
    
    puzzle = Puzzle.new(solved_puzzle)    
    assert @puzzle.to_s, puzzle.to_s

    puts "\n"
    puts @puzzle
    puts puzzle
  end
end