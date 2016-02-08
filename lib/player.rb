class Player
	
	def clean(object)
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
				clean(:litlamp)
			elsif @in_hands.any?{ |word| (word[/\D+/]).to_sym == object}
				puts "You clean off the #{object}."
			else
				puts "That item is not around to clean."
			end
		end
	end

	def take(object)
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

	def inspect(object)
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
				inspect(:litlamp)
			elsif object == :keypad && @room_place == 9 && @chest_opener == 0
				inspect_keypad
			else
				puts "That item is not around."
			end
		end
	end

	def put(object)
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

	def light(object)
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

	def move(direction)
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
				move(direction)
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
end
