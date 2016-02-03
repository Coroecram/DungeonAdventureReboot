class Adventure

def initialize()

	require 'abbrev'
	require 'pp'
	require 'timeout'
	@objects = []
	@rooms = []
	@traveler = ""
	@orientation = 0
	@room_place = 'forest'
	@in_bag = ["canteen", "matchbox"]
	@in_hands = []
	@in_room = []
	@scope_bag = 0
	@scope_hands = 0
	@scope_room = 1
	@fail_count = 0
	@torch_identifier = 0
	@lit_torches = []
	@darkness_tries = 1
	@in_darkness = 0
	@canteen_count = 3
	@valid_move = Abbrev.abbrev(["left", "right", "forward", "backwards", "straight"])
	@commands = Abbrev.abbrev(["take", "go", "grab", "put", "inspect", "place", "drop", "clean", "wipe", "move",  "light"]); @commands["p"] = "put"
	@object_list = Abbrev.abbrev(["bag", "room", "hands", "book", "lamp", "litlamp", "torch", "tree", "branch", "cat", "hole", "keyboard", "chest", "disk", "fragment", "keypad", "platform", "computer", "monitor", "mouse", "canteen", "matchbox", "ghost", "cord", "littorch"]); @object_list["h"]= "hands"; @object_list["fl"] = "disk"; @object_list["flo"] = "disk"; @object_list["flop"] = "disk"; @object_list["flopp"] = "disk"; @object_list["floppy"] = "disk"
	@mouse_in_hole = 1
	@chest_opener = 0
	@platform_fixed = 0
	@clean_monitor = 0
	@keyboard_connected = 0
	@mouse_connected = 0
	@disk_inserted = 0
	@error_count = 0
	@cant_take = [:lamp, :litlamp, :computer, :monitor, :platform, :tree]

#add objects
	add_object(:book, "a magical book", "A black leather-bound book with a certain feel. There are no markings on it.\nYou open to the first page.")
	add_object(:lamp, "a lamp", "A black metal lamp hanging on a post about 6 feet tall in the middle of the room.")
	add_object(:litlamp, "a lamp burning brightly", "A black metal lamp hanging on a post about 6 feet tall burning brightly.")
	add_object(:torch, "a torch", "A piece of wood with flammable resin inside.\nIt can be lit to provide a bright flame.")
	add_object(:tree, "a large dead tree", "There is a large dead tree with many branches that look like they can burn.\nWho knows how it got here?")
	add_object(:branch, "a tree branch", "A branch; it looks like it could be taken and used as a torch.")
	add_object(:cat, "a cat", "It's a Siamese cat in the corner, looks friendly enough.")
	add_object(:hole, "a small hole in the wall", "There is a small hole in the wall. You can hear scurrying inside.", 1)
	add_object(:keyboard, "a computer keyboard", "A standard QWERTY keyboard.")
	add_object(:chest, "a large wooden treasure chest", "A large locked wooden chest with a keypad on it.")
	add_object(:disk, "a floppy disk", "An old-time floppy disk")
	add_object(:fragment, "a stone fragment", "A stone fragment with carving on it.")
	add_object(:platform, "a stone platform", "a stone platform with a fragment missing and a computer on top.")
	add_object(:computer, "a computer", "It's an old computer, still running, on top of the platform.")
	add_object(:monitor, "a monitor", "A computer monitor on top of the computer. It is too dusty to read")
	add_object(:mouse, "a mouse (computer)", "A plain-old 2-button computer mouse.")
	add_object(:canteen, "a canteen", "A half-full reusable water canteen.")
	add_object(:matchbox, "a matchbox", "A strike-on-box with so many matches you can't run out.")
	add_object(:ghost, "a spooky ghost", "A terrifying ghost moaning and staring right at you!")
	add_object(:cord, "a cord coming out of the hole", "A cord is sticking out of the mouse hole.")
	add_object(:littorch, "a bright flaming torch", "By the looks of it, the torch will burn for (x more movements)", 10)

#add rooms
	add_room('forest', "a clearing in the forest before a stone hill", [1,0,0,0], "book")
	add_room(0, "a dark room with a door to the", [0,1,0,0], "fragment")
	add_room(1, "a dark room with a door to the", [1,0,0,1], nil)
	add_room(2, "a dark room with a door to the", [1,0,1,0], "lamp", "torch")
	add_room(3, "a dark room with a door to the", [1,1,0,0], nil)
	add_room(4, "a dark room with a door to the", [0,0,0,1], "hole")
	add_room(5, "a dark room with a door to the", [1,1,0,0], "lamp")
	add_room(6, "a dark room with a door to the", [1,0,1,1], nil)
	add_room(7, "a dark room with a door to the", [1,1,1,1], "tree")
	add_room(8, "a dark room with a door to the", [0,0,1,1], nil)
	add_room(9, "a dark room with a door to the", [1,0,0,0], "chest")
	add_room(10, "a dark room with a door to the", [0,1,1,0], "cat")
	add_room(11, "a dark room with a door to the", [0,1,0,1], nil)
	add_room(12, "a dark room with a door to the", [1,1,1,1], nil)
	add_room(13, "a dark room with a door to the", [1,1,0,1], nil)
	add_room(14, "a dark room with a door to the", [0,0,1,1], nil)
	add_room(15, "a dark room with a door to the", [0,1,0,0], "ghost", "lamp")
	add_room(16, "a dark room with a door to the", [0,1,0,1], nil)
	add_room(17, "a dark room with a door to the", [0,0,1,1], nil)
	add_room(18, "a dark room with a door to the", [0,1,1,0], nil)
	add_room(19, "a dark room with a door to the", [0,0,0,1], "computer", "monitor", "lamp", "platform")
end


def orienteering
	if @orientation == 0
		@room_place = @room_place + 5
	elsif @orientation == 1
		@room_place = @room_place + 1
	elsif @orientation == 2
		@room_place = @room_place - 5
	elsif @orientation == 3
		@room_place = @room_place - 1
	end
end

def turn_phase
	torch_burn
	room_items
	the_Darkness
	ghost_check
end

def torch_burn
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

def room_items
	@in_room = []
	current_room = find_room(@room_place)
	current_room.objects.each { |object| @in_room << object}
	@in_room = @in_room.flatten
	if @in_room == [nil]
		@in_room = []
	end
end

def items_room
	current_room = find_room(@room_place)
	current_room.objects = []
	item_hold = []
	@in_room.each { |object| item_hold << object}
	current_room.objects = item_hold.flatten
end

def in_bag
	@scope_bag = 1; @scope_hands = 0; @scope_room = 0
	if @in_bag.length == 0
		puts "There is nothing in your bag."
	else
		things = []
		@in_bag.each {|object| things << find_object((object[/\D+/]).to_sym).name}
		stuff_total = "You open the bag. There is " + things.join(" and ") + " in your bag."
		puts stuff_total.scan(/.{1,80}\W/).map(&:strip)
	end
end

def in_hand
	@scope_hands = 1; @scope_bag = 0; @scope_room = 0
	if @in_hands.length == 0
		puts "There is nothing in your hands."
	else
		things = []
		@in_hands.each {|object| things << find_object((object[/\D+/]).to_sym).name}
		if things.length == 1
			puts "There is " + things[0] + " in your hand."
		else
			puts "There is " + things.join(" and ") + " in your hands."
		end
	end
end

def in_room
	@scope_room = 1;  @scope_bag = 0; @scope_hands = 0
	if @in_room == []
		inspect_room_doors
		puts "There is nothing in the room."
	else
		things = []
		inspect_room_doors
		@in_room.each {|object| things << find_object((object[/\D+/]).to_sym).name}
		stuff_total = "There is " + things.join(" and ") + " in the room."
		puts stuff_total.scan(/.{1,80}\W/).map(&:strip)
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

def inspect_book
	puts "___________________________________________________________________________".center(80)
	puts "Hello #{@traveler}, looking for some help?\n".center(80)
	puts "Here's a list of some handy commands and a short description of what they do!\n".center(80)
	puts "Type [command] [item or direction] and press ENTER".center(80)
	puts "Command \t Description"
	puts "move/go   Move your character in [direction].\n"
	puts "inspect   Inspect an [object].\n\t  Inspect your bag, hands, or the room to manipulate the items in them.\n"
	puts "take/grab Pick up an [item]."
	puts "put/place Put down an [item] in your hands."
	puts "light \t  Light  the [object] on fire (be careful!)."
	puts "clean \t  Some [items] are dirty.\n\n"
	puts "____________________________________________________________________________".center(80)
	puts "Press <ENTER> to look at the facing page."
	gets
	puts "____________________________________________________________________________".center(80)
	puts "Here are some helpful tips #{@traveler}!".center(80)
	puts "Don't forget torches burn out, it is not safe to be lost in the dark!".center(80)
	puts "You will always drop and pickup the most burnt torch first.".center(80)
	puts "Branches can be taken as torches.".center(80)
	puts "Do not use descriptors except for a 'lit' torch or lamp.".center(80)
	puts "Unique abbreviations are acceptable.".center(80)
	puts "Again, don't forget torches burn out, it is not safe to be lost in the dark!".center(80)
	puts "Check how long your lit torches will last frequently!".center(80)
	puts "____________________________________________________________________________".center(80)
	puts "Afraid to read on, you close the book."
end

def inspect_tree(object)
	puts "#{find_object(object).description}"
end

def inspect_keypad
	puts "The keypad on the chest has the following buttons on it:"
	puts "W  L  D  T  M"
	puts " O  R  H  Y  "
	puts "B  Q  E  S  U"
	puts "Enter the password:"
	password = gets.chomp
	if password == "QWERTY"
		puts "The keypad lights up green and an audible *click* is heard."
		sleep(2)
		puts "The keypad flips and disappears as the chest slowly opens automatically."
		@chest_opener = 1
		find_object(:chest).description = "The chest is open and there is a keyboard inside."
		@in_room.push("keyboard")
	else
		puts "The keypad flashes red."
	end
end

def inspect_platform
	traveler = @traveler.upcase
	spaces = " " * ("#{@traveler} YOU HAVE COME A LO").length
	if @platform_fixed == 0
		puts "There is a platform carved out of a rock big enough to put the computer on."
		puts "Something is carved into its base, but a whole section is missing."
		puts "Press <ENTER> to read it."
		gets
		puts"What is left says:"
		puts "WELCO #{spaces}NG WAY".center(80)
		puts "IF YO                          F THIS DUNGEON,".center(80)
		puts "YOU MIG                              HAHAHA!".center(80)
		puts "THE PASSWORD         ".center(45)
		puts "T                     SCURRIES INSIDE.".center(80)
		puts "GHOSTS                         VELY!".center(80)
	else
		puts "There is a platform carved out of a rock big enough to put the computer on."
		puts "Something is carved into it's base and it says:"
		puts "Press <ENTER> to read it."
		gets
		puts "WELCOME #{traveler} YOU HAVE COME A LONG WAY".center(80)
		puts "IF YOU CAN SOLVE THE PUZZLES OF THIS DUNGEON,".center(80)
		puts "YOU MIGHT JUST ESCAPE... OR NOT. MUAHAHAHAHA!".center(80)
		puts "THE PASSWORD IS 'QWERTY'!".center(80)
		puts "THE CAT WILL FIND WHAT SCURRIES INSIDE.".center(80)
		puts "GHOSTS FEAR THOSE WHO STAND BRAVELY!".center(80)
	end
end

def inspect_fragment
	traveler = @traveler.upcase
	puts "It is an irregularly shaped stone fragment with carvings that read:"
	puts "     ME #{traveler} YOU HAVE COME A LO"
	puts "     U CAN SOLVE THE PUZZLES O"
	puts "      HT JUST ESCAPE... OR NOT. MUAHA"
	puts "           IS 'QWERTY'!"
	puts " HE CAT WILL FIND WHAT "
	puts "       FEAR THOSE WHO STAND BRA"
end

def inspect_monitor
	if @clean_monitor == 0
		puts "#{find_object(:monitor).description}"
	else
		puts "You read what is on the screen:"
		puts
		while true
		puts "Would you like to reboot? (Y/N)"
		if @keyboard_connected == 1
			input = gets.chomp.downcase
			if input == "y"
				puts "Rebooting................................................................"
				sleep(3)
				puts "Motherboard configuring.................................................."
				sleep(5)
				puts "Checking system configuration............................................"
				sleep(6)
				puts "Loading.................................................................."
				sleep(4)
				puts "Booting disk drive......................................................."
				sleep(2)
				if @disk_inserted == 1
					puts "Click the mouse to run program."
					if @mouse_connected == 1
						sleep(5)
						while true
						puts "What are you waiting for? Click the mouse. (the old-fashioned way)"
						input = gets.chomp.downcase
							if input == "click mouse"
								new_adventure = Adventure.new
								new_adventure.intro
							elsif input == "no"
								puts "But you were so close..."
								puts "You step away from the monitor."
								break
							end
						end
					else
						sleep(3)
						puts "You don't have a mouse to click."
						puts "You step away from the monitor."
						break
					end
				else
					sleep(5)
					puts "There is no disk in the drive."
					puts "You step away from the monitor."
					break
				end
			elsif input == "n"
				puts "You step away from the monitor."
				break
			else
				inspect monitor
			end
		else
			sleep(3)
			puts "You don't have anything to input with."
			puts "You step away from the monitor."
			break
		end
		end
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

def abbrev_check(input)
	if input != nil
		if input.split.length == 2
			input1 = input.split[0]
			input2 = input.split[1]
		else
			input1 = "garbage"
			input2 = "garbage"
		end
		if @commands.any?  {|k, v| k == input1}
			input1 = @commands[input1]
		else
			input1 == "garbage"
		end
		if (input1 == "go" || input1 == "move") && @valid_move.any? {|k, v| k == input2}
			input2 = @valid_move[input2]
		elsif @object_list.any?  {|k, v| k == input2}
			input2 = @object_list[input2]
		else
			input2 = "garbage"
		end
	return input1 + " " + input2
	end
end


def the_Darkness
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

class Object
    attr_accessor :reference, :name, :description, :optional
    def initialize(reference, name, description, optional = 0)
      @name = name
	  @reference = reference
	  @description = description
	  @optional = optional
    end

end

class Lit_torch
	attr_accessor :reference, :name, :description, :timeleft, :identifier
	def initialize(reference, name, timeleft = 10, description,  identifier)
	  @reference = reference
	  @name = name
	  @timeleft = timeleft
	  @description = description
	  @identifier = identifier
	end
end

class Room
	attr_accessor :reference, :description, :doors, :objects

    def initialize(reference, description, doors, *objects)
	  @reference = reference
	  @description = description
	  @doors = doors
	  @objects = objects
    end
end

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


end

my_adventure = Adventure.new





my_adventure.intro
#my_adventure.skip_intro
