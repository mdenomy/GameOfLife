class GameOfLife
  attr_accessor :cells
  
  def initialize(rows, columns, live_seed_percent = 50)
    @cells = Array.new(rows) do
        Array.new(columns) do
            if Random.rand(100) < live_seed_percent
                Cell.new(:alive)
            else
                Cell.new(:dead)
            end
        end
    end
    link_neighbors(rows,columns)
  end

  def next_generation
    @cells.each do |row| 
      row.each do |col|
        col.determine_next_state
      end
    end
    
    @cells.each do |row|
      row.each do |col|
        col.update_to_next_state
      end
    end
  end

  private

  def link_neighbors(rows, columns)
    for row in 0...rows
      for col in 0...columns
        left = col - 1
        right = col + 1
        above = row - 1
        below = row + 1
        neighbors = @cells[row][col].neighbors
        neighbors.push(@cells[above][left]) if above >= 0  && left >= 0
        neighbors.push(@cells[above][col]) if above >= 0
        neighbors.push(@cells[above][right]) if above >= 0  && right < columns
        neighbors.push(@cells[row][left]) if left >= 0
        neighbors.push(@cells[row][right]) if right < columns
        neighbors.push(@cells[below][left]) if below < rows  && left >= 0
        neighbors.push(@cells[below][col]) if below < rows
        neighbors.push(@cells[below][right]) if below < rows  && right < columns
      end
    end

  end

end