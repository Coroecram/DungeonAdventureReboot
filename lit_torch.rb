class Lit_torch
	attr_accessor :reference, :name, :description, :timeleft, :identifier
	def initialize(reference, name, timeleft = 10, description,  identifier)
	  @reference = reference
	  @name = name
	  @timeleft = timeleft
	  @description = description
	  @identifier = identifier
	end

  def burn
  	@lit_torches.each do |torch|
  		torch.timeleft -= 1
  		if torch.timeleft == 0
  			torch_identity = torch.identifier
  			torch_to_delete = "littorch#{torch_identity}"
  			if @in_hands.any? { |object| object == torch_to_delete }
  				@in_hands.delete_if {|object| object == torch_to_delete}
  				puts "The torch you are holding burnt out."
  			elsif @rooms.each do |room|
  				room_objects = room.objects.flatten
  				room_objects.delete_if{|object| object == torch_to_delete}
  				room.objects = room_objects
  			end
  			end
  		end
  	end
  @lit_torches.delete_if {|torch| torch.timeleft == 0 }
  end
end
