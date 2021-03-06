require 'flammable'

class Torch < Flammable
	attr_accessor :timeleft

	def initialize
	  @timeleft = 10
		super
	end

  def burn!
  	if self.timeleft > 0
			self.timeleft -= 1
			return true
		else
			self.dead
		end
  end

	def dead
		!self.lit ||= false
		return nil if self.timeleft == 0
	end

  def inspect
    lit ?  "By the looks of it, the torch will burn for (x more movements)" :
           "A piece of wood with flammable resin inside.\nIt can be lit to provide a bright flame."
  end

  def to_s
    lit ? "a bright flaming torch" : "a torch"
  end
end
