class Chest
  attr_accessor :locked

  def initialize
    @locked = true
  end

  def unlock
    self.locked = false
  end

  def inspect
    return self.locked ? "A large locked wooden chest with a keypad on it." : "huh"
  end

  def to_s
    return self.locked ? "a large wooden treasure chest" : "not true"
  end
end
