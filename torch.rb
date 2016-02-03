class Torch
	attr_reader :reference, :name, :description, :timeleft, :identifier, :lit

	def initialize(reference, name, timeleft = 10, description,  identifier)
	  @reference = reference
	  @name = name
	  @timeleft = timeleft
	  @description = description
	  @identifier = identifier
    @lit = false
	end

  def burn
  		self.timeleft -= 1
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
end
