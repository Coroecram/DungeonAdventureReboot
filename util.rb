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

def the_darkness
	if @in_hands.any? { |object| object =~ /lit.*/ } || @in_room.any? { |object| object =~ /lit.*/ }
		@darkness_tries = 1
	else
		puts "\e[H\e[2J"
		puts "All of your light is gone and you are lost in the Darkness!"
		puts "Needless to say, this is not good..."
		while true
			input = gets
			@input = input.chomp.downcase
			@input = abbrev_check(@input)
			if @darkness_tries == 20
				puts "Admit it, you are lost in the dark."
				sleep(3)
				puts "You feel a ghostly chill as you drop to your knees in exhaustion."
				exit
			elsif @input == "inspect bag"
				@scope_bag = 1; @scope_hands = 0; @scope_room = 0
					if @in_bag.length == 0
						puts "You feel nothing in your bag."
					else
						things = []
						@in_bag.each {|object| things << find_object((object[/\D+/]).to_sym).name}
						stuff_total = "You open the bag. You can feel a " + things.join(" and ") + " in your bag."
						puts stuff_total.scan(/.{1,80}\W/).map(&:strip)
					end
			elsif @scope_bag == 1 && @input =~ /take.*/
				puts "You feel around inside the bag..."
				inputs(@input)
			elsif @input == "light match" && @in_hands.any? { |object| object == "matchbox" }
				inputs(@input)
				@darkness_tries += 1
			elsif @input == "light torch" && @in_hands.any? { |object| object == "matchbox" }
				if rand < 0.5
					puts "You fumble, but manage to find a match in the dark..."
					inputs(@input)
					if @in_hands.any? { |object| object =~ /lit.*/ } || @in_room.any? { |object| object =~ /lit.*/ }
						puts  "You have found light!"
						break
					end
				else
					puts "You try to get a match but drop it in the dark."
				end
			elsif @valid_move.any? { |direction| @input == "move #{direction[1]}"} || @valid_move.any? { |direction| @input == "go #{direction[1]}"}
				@darkness_tries += 1
				if rand < 0.5
					inputs(@input)
					if @in_hands.any? { |object| object =~ /lit.*/ } || @in_room.any? { |object| object =~ /lit.*/ }
						puts  "You have found light!"
						break
					end
				else
					puts "You could not find your way in the dark."
				end
			elsif @input.match("garbage")
				puts "Please enter a valid command."
			else
				@darkness_tries += 1
				puts "It is too dark to see your hand in front of your face."
			end
		end
	end
end

def orienteering
	if @orientation == 0
		@room_place += 5
	elsif @orientation == 1
		@room_place += 1
	elsif @orientation == 2
		@room_place -= 5
	elsif @orientation == 3
		@room_place -= 1
	end
end
