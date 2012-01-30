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
  end
end