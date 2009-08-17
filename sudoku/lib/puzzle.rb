class Puzzle
  
  COMPLETE_PIECE = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  attr_reader :matrix
  
  def initialize(matrix)
    @matrix = matrix.dup
  end
  
  def row(num)
    @matrix[num]
  end
  
  def column(num)
    @matrix.map{|r| r[num]}
  end
  
  def [](index)
    row(index)
  end
  
  def zone(index)
    zone_row, zone_col = index.divmod(3)
    first_row = zone_row * 3
    first_col = zone_col * 3
    rows = @matrix[first_row, 3]
    rows.map { |row| row[first_col, 3] }.flatten
  end
  
  def self.piece_solved?(piece)
    (COMPLETE_PIECE & piece) == COMPLETE_PIECE
  end

  def solved?
    (0..8).each do |i|
      return false unless Puzzle::piece_solved?(zone(i))
      return false unless Puzzle::piece_solved?(row(i))
      return false unless Puzzle::piece_solved?(column(i))
    end
    true
  end
  
  def possible_values_for_cell(row_idx, col_idx)
    COMPLETE_PIECE - row(row_idx) - column(col_idx) - zone(zone_from_row_and_column(row_idx, col_idx))
  end
  
  def zone_from_row_and_column( row, col )
    (row / 3) * 3 + (col / 3)  
  end
  
  def solve_cell(row, col)
    options = possible_values_for_cell(row, col)
    if options.size == 1
      @matrix[row][col] = options.first
      return true
    end
    return false
  end
  
  def solve!    
    while true
      made_change = false
      (0..8).each do |row|
        (0..8).each do |col|
          if self[row][col].nil?
            made_change ||= solve_cell(row,col)
          end
        end
      end

      return if solved? || !made_change
    end
  end
  
end