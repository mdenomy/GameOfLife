require "rubygems"
gem "test-unit"
require "test/unit"
require_relative "../app/cell"

class CellRulesTest < Test::Unit::TestCase

  def test_cell_created_dead_by_default
    cell = Cell.new
    assert cell.dead?
  end

  def test_cell_created_alive_is_alive
    cell = Cell.new(:alive)
    assert cell.alive?
  end

  def test_cell_created_dead_is_not_alive
    cell = Cell.new(:dead)
    assert_false cell.alive?
  end

  def test_cell_created_dead_is_dead
    cell = Cell.new(:dead)
    assert cell.dead?
  end

  def test_cell_created_alive_is_not_dead
    cell = Cell.new(:alive)
    assert_false cell.dead?
  end

  def generate_neighborhood(living, dead)
    neighbors = []
    living.times {neighbors.push(Cell.new(:alive))}
    dead.times {neighbors.push(Cell.new(:dead))}
    return neighbors
  end

  def test_live_cell_with_no_live_neighbors_dies
    cell = Cell.new(:alive)
    cell.neighbors = generate_neighborhood(0,8)
    cell.update
    assert_true cell.dead?
  end

  def test_live_cell_with_two_live_neighbors_lives
    cell = Cell.new(:alive)
    cell.neighbors = generate_neighborhood(2,6)
    cell.update
    assert_true cell.alive?
  end

  def test_live_cell_with_three_live_neighbors_lives
    cell = Cell.new(:alive)
    cell.neighbors = generate_neighborhood(3,5)
    cell.update
    assert_true cell.alive?
  end

  def test_live_cell_with_four_live_neighbors_dies
    cell = Cell.new(:alive)
    cell.neighbors = generate_neighborhood(4,4)
    cell.update
    assert_true cell.dead?
  end

  def test_dead_cell_with_three_live_neighbors_lives
    cell = Cell.new(:dead)
    cell.neighbors = generate_neighborhood(3,5)
    cell.update
    assert_true cell.alive?
  end

  def test_dead_cell_with_two_live_neighbors_stay_dead
    cell = Cell.new(:dead)
    cell.neighbors = generate_neighborhood(2,6)
    cell.update
    assert_true cell.dead?
  end
end