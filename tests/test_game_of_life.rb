require "rubygems"
gem "test-unit"
require "test/unit"
require_relative "../app/game_of_life"
require_relative "../app/cell"

class MockCell
  attr_accessor :calls
  
  def initialize
   @calls = ""
  end
  
  def determine_next_state
    calls << "determine_next_state;";
  end
  
  def update_to_next_state
    calls << "update_to_next_state;";
  end
end

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
    assert  living > 25 && living < 55
  end
  
  # NB - I am getting at a point where I really want to use a "mock" in the tests, especially
  # where the following tests are testing behavior, i.e. was a method called or were the correct
  # methods called in the right order
  # In the .NET world I would use a mocking framework, but in a dynamic language like Ruby
  # I "assume" that you can just plug in something that responds to the same commands and 
  # inject behavior that way.  For now I will struggle along with a manual test approach
  # and investigate how to address this in a more "Ruby Way" later
  
  def test_game_signals_cells_to_regenerate
    game = GameOfLife.new(1,1)
    mockCell = MockCell.new
    game.cells[0][0] = mockCell
    game.next_generation
    assert_equal "determine_next_state;update_to_next_state;", mockCell.calls
  end

  def test_game_sets_up_center_neighbors
    game = GameOfLife.new(3,3)
    expected = [ game.cells[0][0], game.cells[0][1], game.cells[0][2],
                 game.cells[1][0],                   game.cells[1][2],
                 game.cells[2][0], game.cells[2][1], game.cells[2][2] ]
    center = game.cells[1][1]
    assert_equal expected.count, center.neighbors.count
    expected.each do |cell|
        assert center.neighbors.include?(cell)
    end
  end

  def test_game_sets_up_upper_left_neighbors
    game = GameOfLife.new(3,3)
    expected = [                   game.cells[0][1],
                 game.cells[1][0], game.cells[1][1] ]
    test_cell = game.cells[0][0]
    assert_equal expected.count, test_cell.neighbors.count
    expected.each do |cell|
        assert test_cell.neighbors.include?(cell)
    end
  end

end