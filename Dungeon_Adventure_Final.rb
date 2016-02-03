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



def clean_command(object)
	if object == :bag
		puts "You dust off your bag."
	elsif object == :hands
		@scope_bag = 0; @scope_hands = 1; @scope_room = 0
		if @in_hands.any?{ |word| word == "canteen"} && @in_hands.length == 1 && @canteen_count > 0
			puts "You wash off your hands with the water from the canteen."
			@canteen_count -= 1
				if @canteen_count == 0
					find_object(:canteen).description = "An empty reusable water canteen."
				end
		elsif @in_hands.any?{ |word| word == "canteen"} && @in_hands.length == 1 && @canteen_count == 0
			puts "There is no more water to clean your hands."
		elsif @in_hands.length == 2
			puts "Your hands are full."
		else
			puts "There is nothing to clean your hands with."
		end
	elsif object == :room
		@scope_bag = 0; @scope_hands = 0; @scope_room = 1
		puts "You try to clean the room but it is still dirty."
	elsif @scope_bag == 1
		if object == :littorch
			puts "You can't clean it, you'll burn yourself!"
		elsif @in_bag.any?{ |word| (word[/\D+/]).to_sym == object}
			puts "You clean off the #{object}."
		elsif @in_hands.any?{ |word| (word[/\D+/]).to_sym == object}
			puts "You clean off the #{object}."
		else
			puts "That item is not in your bag or hands to clean."
		end
	elsif @scope_hands == 1
		if object == :littorch
			puts "You can't clean it, you'll burn yourself!"
		elsif @in_hands.any?{ |word| (word[/\D+/]).to_sym == object}
			puts "You clean off the #{object}."
		else
			puts "That item is not in your hands to clean."
		end
	elsif @scope_room == 1
		if object == :littorch
			puts "You can't clean it, you'll burn yourself!"
		elsif @in_room.any?{ |word| (word[/\D+/]).to_sym == object }
			if object == :litlamp
				puts "You clean the lamp and it shines a little brighter."
			elsif  object == :monitor
				puts "You clean off the screen."
				@clean_monitor = 1
			else
				puts "You clean off the #{object}."
			end
		elsif object == :lamp
			clean_command(:litlamp)
		elsif @in_hands.any?{ |word| (word[/\D+/]).to_sym == object}
			puts "You clean off the #{object}."
		else
			puts "That item is not around to clean."
		end
	end
end

def take_command(object)
	if @in_hands.length == 2
		puts "Your hands are full."
	elsif @room_place == 7 && object == :branch
		puts "You take a branch off the tree and it is now a torch."
		@in_hands.push("torch")
	elsif @scope_bag == 1
		if @in_bag.any?{ |word| word.to_sym == object}
			puts "You take the " + object.to_s + " from the bag."
			@in_hands.push(object.to_s)
			@in_bag.delete(object.to_s)
		else
			puts "You don't have that in your bag to take."
		end
	elsif @scope_room == 1
		if @in_room.any?{ |word| word.to_sym == object}
			if @cant_take.any? { |word| word == object}
				puts "You can't take that object."
			elsif object == :cord
				puts "You pull on the cord and it gives. At the end you find a computer mouse."
				puts "You take the computer mouse."
				@in_room.delete("cord")
				@in_hands.push("mouse")
			elsif object == :keyboard && @chest_opener == 1
				take_keyboard_first
			else
				puts "You take the #{object} from the room."
				@in_room.delete(object.to_s)
				@in_hands.push(object.to_s)
			end
		elsif object == :torch
				lit_torch_grab
		else
			puts "It isn't in the room to take."
		end
	else
		puts "It isn't there to take. Maybe you should inspect the bag or room for it first."
	end
end

def inspect_command(object)
	if object == :bag
		in_bag
	elsif object == :hands
		in_hand
	elsif object == :room
		in_room
	elsif object == :book && (@in_bag.any?{ |word| (word[/\D+/]).to_sym == object} || @in_hands.any?{ |word| (word[/\D+/]).to_sym == object})
		puts "#{find_object(object).description}"
		inspect_book
	elsif (object == :tree || object == :branch) && @room_place == 7
		inspect_tree(object)
	elsif object == :fragment && (@in_hands.any?{ |word| (word[/\D+/]).to_sym == object})
		inspect_fragment
	elsif @scope_bag == 1
		if @in_bag.any?{ |word| (word[/\D+/]).to_sym == object}
			puts "#{find_object(object).description}"
		elsif @in_hands.any?{ |word| (word[/\D+/]).to_sym == object}
			puts "#{find_object(object).description}"
		elsif object == :torch
			lit_torch_inspect
		else
			puts "That item is not in your bag or hands."
		end
	elsif @scope_hands == 1
		if @in_hands.any?{ |word| (word[/\D+/]).to_sym == object}
			puts "#{find_object(object).description}"
		elsif object == :torch
			lit_torch_inspect
		else
			puts "That item is not in your hands."
		end
	elsif @scope_room == 1
		if @in_room.any?{ |word| (word[/\D+/]).to_sym == object }
			if object == :platform
				inspect_platform
			elsif object == :monitor
				inspect_monitor
			else
				puts "#{find_object(object).description}"
			end
		elsif @in_hands.any?{ |word| (word[/\D+/]).to_sym == object}
			puts "#{find_object(object).description}"
		elsif object == :torch
			lit_torch_inspect
		elsif object == :lamp
			inspect_command(:litlamp)
		elsif object == :keypad && @room_place == 9 && @chest_opener == 0
			inspect_keypad
		else
			puts "That item is not around."
		end
	end
end

def put_command(object)
	if @scope_bag == 1
		if object == :torch && @in_bag.any?{ |word| word == "torch" }
			puts "You don't have room for another torch in your bag."
		elsif @in_hands.any?{ |word| word.to_sym == object}
			puts "You put the " + object.to_s + " in the bag."
			@in_hands.delete(object.to_s)
			@in_bag.push(object.to_s)
		elsif object == :torch
			lit_torch_puts
		else
			puts "You don't have that to put."
		end
	else
		if @room_place == 19 && (object == :keyboard || object == :disk || object == :mouse || object == :fragment )
			put_final_room(object)
		elsif @in_hands.any?{ |word| word.to_sym == object}
			puts "You drop the #{object} in the room."
			@in_hands.delete(object.to_s)
			@in_room.push(object.to_s)
			if object == :cat
				cat_room_check
			end
		elsif object == :torch
			lit_torch_puts
		else
			puts "You don't have that to put."
		end
	end
end

def light_command(object)
	if object == :torch || object == :lamp
		if object == :torch
			if @in_hands.any?{ |word| word == "torch"}
				if @in_hands.any?{ |word| word == "matchbox"}
					light_torch
					puts "You strike a match and light the torch with the flame."
				elsif @in_hands.any?{ |word| word =~ /littorch.*/}
					light_torch
					puts "You light the torch with the flame of the lit one."
				elsif @in_room.any?{ |word| word == "litlamp"}
					light_torch
					puts "You light the torch with the flame from the lamp."
				else
					puts "You have nothing to light the torch with!"
				end
			else
				puts "You have no torch to light!"
			end
		elsif object == :lamp
			if @in_hands.any?{ |word| word =~ /littorch\d+/}
				@in_room.each { |word| word.sub!("lamp", "litlamp")}
				puts "You put your torch to the lamp and it burns brightly."
			elsif @in_hands.any?{ |word| word == "matchbox"}
					@in_room.each { |word| word.sub!("lamp", "litlamp")}
					puts "You strike a match and light the lamp with the flame."
			elsif @in_room.any?{ |word| word == "litlamp"}
					puts "The lamp is already lit."
			else
				puts "You have nothing to light the lamp with!"
			end
		end
	elsif object == :littorch || object == :litlamp
		puts "It's already lit."
	elsif object == :cat
		puts "You're a monster!"
	else
		puts "You can't light that on fire!"
	end
end

def light_torch
	replacer = "littorch#{@torch_identifier}"
	index = @in_hands.index("torch") and @in_hands[index] = replacer
	@lit_torches << Lit_torch.new(:littorch, "a flaming wooden torch", 10, "By the looks of it, the torch", @torch_identifier)
	@torch_identifier += 1
end

def torch_parse(inquiry)
	if inquiry == "take" || inquiry == "grab" || inquiry == "pickup"
		lit_torch_grab
	elsif inquiry == "inspect"
		lit_torch_inspect
	elsif inquiry == "put" || inquiry == "place" || inquiry == "drop"
		lit_torch_puts
	elsif inquiry == "clean" || inquiry == "wipe" || inquiry == "dust"
			puts "You can't clean that, you'll burn yourself!"
	else
		puts "That is not something you can do with a lit torch."
	end
end

def lit_torch_inspect
	if @scope_hands == 1 || @scope_bag == 1 && @in_hands.any?{ |word| word =~ /littorch/}
		@in_hands.each do |word|
		identity = word[/\d+/]
			if identity == nil
			else
				found_torch = find_torch(identity.to_i)
				puts "#{found_torch.description} in your hand will burn for #{found_torch.timeleft} moves."
				identity = nil
				found_torch = nil
			end
		end
	elsif @scope_room == 1 && @in_room.any?{ |word| word =~ /littorch/}
		@in_room.each do |word|
		identity = word[/\d+/]
			if identity == nil
			else
				found_torch = find_torch(identity.to_i)
				puts "#{found_torch.description} in the room will burn for #{found_torch.timeleft} moves."
				identity = nil
				found_torch = nil
			end
		end
	else
		puts "There is no torch to inspect."
	end
end

def lit_torch_grab
torch_to_grab = []
burntime = 11
	if @in_hands.length == 2
		puts "Your hands are full."
	elsif @in_room.any? { |object| object =~ /littorch\d*/}
		@in_room.each do |object|
			if object =~ /littorch\d+/
				identifier = (object[/\d+/]).to_i
				if find_torch(identifier).timeleft < burntime
					burntime = find_torch(identifier).timeleft
					torch_to_grab = object
					puts "You grab the burning torch from the ground."
				end
			end
		end
		@in_room.delete(torch_to_grab)
		@in_hands.push(torch_to_grab)
	else
		puts "There is no torch here to take."
	end
end

def lit_torch_puts
torch_to_put = []
burntime = 11
	if @in_hands.any? { |object| object =~ /littorch\d*/}
		@in_hands.each do |object|
			if object =~ /littorch\d+/
				identifier = (object[/\d+/]).to_i
				if @scope_bag == 1
					puts "You cannot put a lit torch in your bag."
				elsif find_torch(identifier).timeleft < burntime
					burntime = find_torch(identifier).timeleft
					torch_to_put = object
				end
			end
		end
		@in_hands.delete(torch_to_put)
		@in_room.push(torch_to_put)
		puts "You drop the oldest burning torch on the ground."
	else
		puts "You have no torch to put down."
	end
end

def move_command(direction)
		current_room = find_room(@room_place)
		doors_in_room = current_room.doors
		orientationer = @orientation
		doors_orient = doors_in_room.rotate(orientationer)
	if @valid_move.any?  {|k, v| k == direction}
		direction = @valid_move[direction]
		@error_count = 0
		items_room
		if direction == "straight" || direction == "forward"
			if doors_orient[0] == 1
				puts "You move straight, into the next room."
				orienteering
			else
				puts "There is no way to go in that direction."
			end
		elsif direction == "right" || direction == "r"
			if doors_orient[1] == 1
				puts "You move right, into the next room."
				@orientation = (1 + @orientation) % 4
				orienteering
			else
				puts "There is no way to go in that direction."
			end
		elsif direction == "backwards"
			if doors_orient[2] == 1
				puts "You move back, into the last room."
				@orientation = (2 + @orientation) % 4
				orienteering
			else
				puts "There is no way to go in that direction."
			end
		elsif direction == "left" || direction == "l"
			if doors_orient[3] == 1
				puts "You move left, into the next room."
				@orientation = (3 + @orientation) % 4
				orienteering
			else
				puts "There is no way to go in that direction."
			end
		end
	else
		if @error_count < 1
			puts "Please enter a valid direction."
			@error_count += 1
			direction = gets.downcase.chomp
			move_command(direction)
		else
			puts "Please enter a valid command."
			@error_count = 0
		end
	end
	turn_phase
end

def pet_cat
	if @scope_bag == 1
		if @in_bag.any?{ |word| (word == "cat")}
			puts "You pet the cat."
			sleep 2
			puts "It purrs happily at your touch!"
		elsif @in_hands.any?{ |word| (word == "cat")}
			puts "You pet the cat."
			sleep 2
			puts "It purrs happily at your touch!"
		else
			puts "Please enter a valid command."
		end
	elsif @scope_hands == 1
		if @in_hands.any?{ |word| (word == "cat")}
			puts "You pet the cat."
			sleep 2
			puts "It purrs happily at your touch!"
		else
			puts "Please enter a valid command."
		end
	elsif @scope_room == 1
		if @in_room.any?{ |word| (word == "cat")}
			puts "You pet the cat."
			sleep 2
			puts "It purrs happily at your touch!"
		elsif @in_hands.any?{ |word| (word == "cat")}
			puts "You pet the cat."
			sleep 2
			puts "It purrs happily at your touch!"
		else
			puts "Please enter a valid command."
		end
	end
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
