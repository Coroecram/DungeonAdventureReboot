class Lamp
  attr_reader :flame
  def initialize
    @flame = false
  end

  def inspect
    flame ? "A black metal lamp hanging on a post about 6 feet tall burning brightly." :
            "A black metal lamp hanging on a post about 6 feet tall in the middle of the room."
  end

  def to_s
    flame ? "a lamp burning brightly" : "a lamp"
  end

end
