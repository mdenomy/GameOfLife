class Cell
  @state
  attr_accessor :neighbors

  def initialize( state = :dead )
    @state = state
  end

  def alive?
    return @state == :alive
  end

  def dead?
    return !alive?
  end

  def update
    count = 0
    neighbors.each {|n| count += 1 if n.alive?}
    apply_rules(count)
  end

  private

  def apply_rules(count)
    if count == 3
      @state = :alive
    elsif count == 2 && @state == :alive
      @state = :alive
    else
      @state = :dead
    end
  end
end