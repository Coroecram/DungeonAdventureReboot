def add_room(reference, description, doors, *objects)
	@rooms << Room.new(reference, description, doors, objects)
end

def add_object(reference, name, description, optional = 0)
	@objects << Object.new(reference, name, description, optional)
end

 def find_object(reference)
    @objects.detect { |object| object.reference == reference }
 end

def find_room(reference)
    @rooms.detect { |room| room.reference == reference }
end

 def find_torch(identifier)
	if identifier == nil
	else
		@lit_torches.detect { |torch| torch.identifier == identifier }
	end
end

  def find_bag(reference)
    @in_bag.detect { |object| object.reference == reference }
 end

def find_hands(reference)
   @in_hands.detect { |object| object.reference == reference }
end
