require "rubygems"
gem "test-unit"
require "test/unit"
require_relative "../app/game_of_life"
require_relative "../app/cell"

class GameOfListTest < Test::Unit::TestCase

  def test_game_creates_rows
    game = GameOfLife.new(8,10)
    assert_equal 8, game.cells.count
  end

  def test_game_creates_columns
    game = GameOfLife.new(8,10)
    assert_equal 10, game.cells[0].count
  end
  
  def test_game_creates_cells
    game = GameOfLife.new(8,10)
    assert_equal Cell, game.cells[4][1].class
  end
  
  def sum_living(cells)
    living = 0
    cells.each do |row|
      row.each do |cell|
        living += 1 if cell.alive?
      end
    end
    return living
  end
  
  def test_game_seeds_all_dead
    game = GameOfLife.new(8,10,0)
    living = sum_living(game.cells)
    assert_equal 0, living
  end

  def test_game_seeds_all_living
    game = GameOfLife.new(8,10,100)
    living = sum_living(game.cells)
    assert_equal 80, living
  end
  
  def test_game_seeds_given_percentage
    game = GameOfLife.new(8,10,50)
    living = sum_living(game.cells)
    assert  living > 30 && living < 50
  end
end