class Ghost
  attr_reader :spooky

  def initialize
    @spooky = true
  end

  def inspect
    "A terrifying ghost moaning and staring right at you!"
  end

  def to_s
    spooky  ? "a spooky ghost" : "a ghost"
  end
end
