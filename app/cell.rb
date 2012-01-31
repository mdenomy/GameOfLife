class Cell
  @next_state
  @state
  attr_accessor :neighbors

  def initialize( state = :dead )
    @state = state
    @neighbors = []
  end

  def alive?
    return @state == :alive
  end

  def dead?
    return !alive?
  end

  def determine_next_state
    count = 0
    neighbors.each {|n| count += 1 if n.alive?}
    apply_rules(count)
  end

  def update_to_next_state
    @state = @next_state
  end
  private

  def apply_rules(count)
    if count == 3
      @next_state = :alive
    elsif count == 2 && @state == :alive
      @next_state = :alive
    else
      @next_state = :dead
    end
  end
end