class Torch
	@@identifier = 0
	attr_accessor :timeleft, :lit
	attr_reader :identifier

	def initialize
	  @timeleft = 10
	  @identifier = (@@identifier += 1)
    @lit = false
	end

  def burn
  		self.timeleft > 0 ? self.timeleft -= 1 : self.dead
  		# if self.timeleft == 0
  		# 	torch_identity = self.identifier
  		# 	torch_to_delete = "littorch#{torch_identity}"
  		# 	if @in_hands.any? { |object| object == torch_to_delete }
  		# 		@in_hands.delete_if {|object| object == torch_to_delete}
  		# 		puts "The torch you are holding burnt out."
  		# 	elsif @rooms.each do |room|
  		# 		room_objects = room.objects.flatten
  		# 		room_objects.delete_if{|object| object == torch_to_delete}
  		# 		room.objects = room_objects
  		# 	end
  		# 	end
  		# end
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
