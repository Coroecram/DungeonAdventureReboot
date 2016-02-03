class Hole
  attr_reader :occupied

  def initialize
    @occupied = true
  end

  def inspect
    "There is a small hole in the wall. You can hear scurrying inside."
  end

  def to_s
    "a small hole in the wall"
  end
end
