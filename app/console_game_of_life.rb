require_relative "game_of_life"
require_relative "cell"

class ConsoleGameOfLife

  @rows
  @columns
  @game
  
  def initialize(rows, columns, seed_percent)
    @rows = rows
    @columns = columns
    @game = GameOfLife.new(rows, columns, seed_percent)
  end
  
  def play
    begin
      draw 
      @game.next_generation
      sleep(0.5)
    end while true
  end
  
  def draw_top
    print "+"
    (1..@columns).each { print "-" }
    print "+\n"
  end

  def draw_bottom
    draw_top
  end

  def start_line
    print "|"
  end

  def draw_cell(cell)
    if cell.alive?
      print '*'
    else
      print ' '
    end
  end

  def end_line
    print "|\n"
  end

  def draw
    draw_top
    @game.cells.each do |row|
      start_line
      row.each do |cell|
        draw_cell(cell)
      end
      end_line
    end
    draw_bottom
  end
end


if ARGV.count == 3 
  rows = ARGV[0].to_i
  columns = ARGV[1].to_i
  seed_percent = ARGV[2].to_i
else
  rows = 10
  columns = 10
  seed_percent = 40
end

game = ConsoleGameOfLife.new(rows,columns,seed_percent)
game.play




