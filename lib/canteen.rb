class Canteen
  attr_accessor :swigs

  def initialize
    @swigs = 3
  end

  def inspect
    "A half-full reusable water canteen."
  end

  def to_s
    "a canteen"
  end
end
