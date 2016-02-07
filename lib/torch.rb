require 'flammable'

class Torch < Flammable
	attr_accessor :timeleft, :lit

	def initialize
	  @timeleft = 10
    @lit = false
		super
	end

  def burn
  		self.timeleft > 0 ? self.timeleft -= 1 : self.dead
  end

	def dead
		!self.lit ||= false
		return self.timeleft == 0
	end

  def inspect
    lit ?  "By the looks of it, the torch will burn for (x more movements)" :
          "A piece of wood with flammable resin inside.\nIt can be lit to provide a bright flame."
  end

  def to_s
    lit ? "a bright flaming torch" : "a torch"
  end
end
