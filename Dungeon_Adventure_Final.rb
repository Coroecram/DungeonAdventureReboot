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
	the_darkness
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




end

my_adventure = Adventure.new





my_adventure.intro
#my_adventure.skip_intro
