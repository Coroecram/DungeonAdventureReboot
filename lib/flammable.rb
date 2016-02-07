class Flammable
  attr_reader :flammable
  attr_accessor :lit

  def initialize
    @lit = false
    @flammable = true
  end

  def light
    self.lit = true
  end
end
