class Cell
  @state

  def initialize( state = :dead )
    @state = state
  end

  def alive?
    return @state == :alive
  end

  def dead?
    return !alive?
  end
end