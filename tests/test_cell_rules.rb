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

end