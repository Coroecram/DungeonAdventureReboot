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
	# add_object(:book, "a magical book", "A black leather-bound book with a certain feel. There are no markings on it.\nYou open to the first page.")
	# add_object(:lamp, "a lamp", "A black metal lamp hanging on a post about 6 feet tall in the middle of the room.")
	# add_object(:litlamp, "a lamp burning brightly", "A black metal lamp hanging on a post about 6 feet tall burning brightly.")
	# add_object(:littorch, "a bright flaming torch", "By the looks of it, the torch will burn for (x more movements)", 10)
	# add_object(:torch, "a torch", "A piece of wood with flammable resin inside.\nIt can be lit to provide a bright flame.")
	# add_object(:tree, "a large dead tree", "There is a large dead tree with many branches that look like they can burn.\nWho knows how it got here?")
	# add_object(:branch, "a tree branch", "A branch; it looks like it could be taken and used as a torch.")
	# add_object(:cat, "a cat", "It's a Siamese cat in the corner, looks friendly enough.")
	# add_object(:hole, "a small hole in the wall", "There is a small hole in the wall. You can hear scurrying inside.", 1)
	# add_object(:keyboard, "a computer keyboard", "A standard QWERTY keyboard.")
	# add_object(:chest, "a large wooden treasure chest", "A large locked wooden chest with a keypad on it.")
	# add_object(:disk, "a floppy disk", "An old-time floppy disk")
	add_object(:fragment, "a stone fragment", "A stone fragment with carving on it.")
	add_object(:platform, "a stone platform", "a stone platform with a fragment missing and a computer on top.")
	add_object(:computer, "a computer", "It's an old computer, still running, on top of the platform.")
	add_object(:monitor, "a monitor", "A computer monitor on top of the computer. It is too dusty to read")
	add_object(:mouse, "a mouse (computer)", "A plain-old 2-button computer mouse.")
	add_object(:canteen, "a canteen", "A half-full reusable water canteen.")
	add_object(:matchbox, "a matchbox", "A strike-on-box with so many matches you can't run out.")
	add_object(:ghost, "a spooky ghost", "A terrifying ghost moaning and staring right at you!")
	add_object(:cord, "a cord coming out of the hole", "A cord is sticking out of the mouse hole.")

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

def turn_phase
	torch_burn
	room_items
	the_darkness
	ghost_check
end

end

my_adventure = Adventure.new





my_adventure.intro
#my_adventure.skip_intro
