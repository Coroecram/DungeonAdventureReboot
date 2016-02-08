class Room
  	attr_accessor :description, :doors, :objects

    def initialize(description, doors, contents)
  	  @description = description
  	  @doors       = doors
  	  @contents    = objects
    end

  def inspect
  	 "There is nothing in the room."
  	# else
  	# 	things = []
  	# 	inspect_room_doors
  	# 	@in_room.each {|object| things << find_object((object[/\D+/]).to_sym).name}
  	# 	stuff_total = "There is " + things.join(" and ") + " in the room."
  	# 	puts stuff_total.scan(/.{1,80}\W/).map(&:strip)
  	# end
  end

  def take_keyboard_first
  	if @in_room.any?{ |word| word == "keyboard"}
  		@chest_opener == 2
  		@in_room.delete("keyboard")
  		@in_hands.push("keyboard")
  		puts "You take the keyboard from the chest."
  		find_object(:chest).description = "The chest is open and there is nothing but dust inside."
  	else
  		puts "That item is not around."
  	end
  end

  def inspect_room_doors
  	doorways = []
  	current_room = find_room(@room_place)
  	doors_in_room = current_room.doors
  	orientationer = @orientation
  	doors_orient = doors_in_room.rotate(orientationer)
  	doorways << "straight" if doors_orient[0] == 1
  	doorways << "to the left" if doors_orient[3] == 1
  	doorways << "to the right" if doors_orient[1] == 1
  	doorways << "back behind you" if doors_orient[2] == 1
  	if doorways.length == 1
  		puts "It is a large cave chamber with a passage #{doorways[0]}."
  	else
  		doorways_total = doorways.join(", and ").to_s
  		doorway_output = "It is a large cave chamber with passages #{doorways_total}."
  		puts doorway_output.scan(/.{1,80}\W/).map(&:strip)
  	end
  end

  def cat_room_check
  	if @room_place == 4 && @in_room.any? { |object| object == "cat" }
  		sleep(2)
  		puts "The cat starts to creep over to the hole in the wall."
  		sleep(3)
  		puts "The cat puts its head into the hole..."
  		sleep(3)
  		puts "Suddenly a mouse runs out and the cat chases it out of the room!"
  		@mouse_in_hole == 0
  		@in_room.delete("cat")
  		room_hole = find_object(:hole)
  		room_hole.description = "There is a small cord coming out of the hole where the mouse ran out."
  		@in_room.push("cord")
  	end
  end

  def put_final_room(object)
  	if object == :mouse
  		puts "You walk over to the computer and plug in the #{object.to_s}."
  		@cant_take.push(object)
  		@in_room.insert(1, object.to_s)
  		@in_hands.delete(object.to_s)
  		@mouse_connected = 1
  	elsif object == :keyboard
  		puts "You walk over to the computer and plug in the #{object.to_s}."
  		@cant_take.push(object)
  		@in_room.insert(1, object.to_s)
  		@in_hands.delete(object.to_s)
  		@keyboard_connected = 1
  	elsif object == :disk
  		puts "You walk over to the computer and insert the disk."
  		@in_hands.delete("disk")
  		@disk_inserted = 1
  		find_object(:computer).description = "An old computer with a floppy disk in it. It is still running"
  	elsif object == :fragment
  		puts "You walk over to the platform and put in the fragment."
  		@in_hands.delete("fragment")
  		@platform_fixed = 1
  	end
  end

  def ghost_check
  	if @room_place == 15 && @in_room.any? { |thing| thing == "ghost"}
  		puts "There is a super spooky ghost in this room!"
  		puts "It is a green-glowing full-bodied apparition, and IT'S COMING RIGHT AT YOU!!"
  		begin
  			input = ""
  			input = Timeout::timeout(10){ gets.chomp }
  			rescue Timeout::Error
  				puts "You have stood courageously!"

  		end
  				if input == "move back" || input == "go back"
  					inputs(input)
  				elsif input != ""
  					puts "You are too frightened to do anything but run away!"
  					inputs("move back")
  				else
  					sleep(2)
  					puts "The ghost slowly fades away with a moan..."
  					@in_room.replace(["litlamp", "disk"])
  					@in_room.delete("ghost")
  					sleep(2)
  					puts "The lamp goes aflame as if by magic!"
  					puts "There is the sound of something plastic hitting the ground."
  				end
  	end
  end
end
