class Chest
  attr_accessor :locked

  def initialize
    @locked = true
  end

  def inspect
    locked ? "A large locked wooden chest with a keypad on it." : ""
  end

  def to_s
    locked ? "a large wooden treasure chest" : ""
  end
end
