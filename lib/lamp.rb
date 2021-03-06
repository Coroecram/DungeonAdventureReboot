require 'flammable'

class Lamp < Flammable

  def initialize
    super
  end

  def inspect
    lit ? "A black metal lamp hanging on a post about 6 feet tall burning brightly." :
            "A black metal lamp hanging on a post about 6 feet tall in the middle of the room."
  end

  def to_s
    lit ? "a lamp burning brightly" : "a lamp"
  end

end
