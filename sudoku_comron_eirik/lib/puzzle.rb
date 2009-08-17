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
  
  def possible_values_for_cell(row, col)
    pencil_in_values!
    @penciled_in[row][col]
  end
  
  def zone_from_row_and_column( row, col )
    (row / 3) * 3 + (col / 3)  
  end
  
  def row_column_from_zone_and_offset( zone, offset )
    base_column = (zone % 3 )*3
    base_row = (zone / 3) * 3
    
    return [base_row + offset / 3, base_column + offset % 3]
  end
  
  def solve_cell(row, col)
    options = possible_values_for_cell(row, col)
    if options.size == 1 and @matrix[row][col].nil?
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
  
  def to_s
    str = ""
    
    @matrix.each_with_index do |row, idx|
      str << "+-----+-----+-----+\n" if idx % 3 == 0
      str << "|#{nums(row[0..2])}|"
      str << "#{nums(row[3..5])}|"
      str << "#{nums(row[6..8])}|\n"

    end
    
    str << "+-----+-----+-----+\n\n"
  end
  
  def nums(a)
    a.map { |i| i.nil? ? "_" : i.to_s }.join(" ")
  end
  
  private
  def pencil_in_values!
    @penciled_in = [Array.new(9), Array.new(9), Array.new(9), Array.new(9), Array.new(9), Array.new(9), Array.new(9), Array.new(9), Array.new(9)]
    (0..8).each do |row|
      (0..8).each do |col|
        if self[row][col].nil?
          @penciled_in[row][col] = COMPLETE_PIECE - row(row) - column(col) - zone(zone_from_row_and_column(row, col))
        else
          @penciled_in[row][col] = [self[row][col]]
        end
      end
    end
    
    (0..8).each do |z|
      COMPLETE_PIECE.each do |option|
        next if zone(z).include?(option)
    
        empty_slots = []
        zone(z).each_with_index do |value, idx|
          empty_slots << idx if value.nil?
        end
        
        valid_slots = empty_slots.select do |empty_idx|
          empty_row, empty_col = row_column_from_zone_and_offset(z, empty_idx)
          @penciled_in[empty_row][empty_col].include?(option)
        end
        
        if valid_slots.size == 1
          empty_row, empty_col = row_column_from_zone_and_offset(z, valid_slots.first)          
          @penciled_in[empty_row][empty_col] = [option]
        end
      end
    end
  end  
end