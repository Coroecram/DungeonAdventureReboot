class Flammable
  attr_reader :flammable
  
  def initialize
    @flammable = true
  end

  def light
    self.lit = true
  end
end
