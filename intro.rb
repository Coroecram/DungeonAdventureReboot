def intro()
room_items

puts " ______            _        _______  _______  _______  _       ".center(70)
puts "(  __  \\ |\\     /|( (    /|(  ____ \\(  ____ \\(  ___  )( (    /|".center(70)
puts "| (  \\  )| )   ( ||  \\  ( || (    \\/| (    \\/| (   ) ||  \\  ( |".center(70)
puts "| |   ) || |   | ||   \\ | || |      | (__    | |   | ||   \\ | |".center(70)
puts "| |   | || |   | || (\\ \\) || | ____ |  __)   | |   | || (\\ \\) |".center(70)
puts "| |   ) || |   | || | \\   || | \\_  )| (      | |   | || | \\   |".center(70)
puts "| (__/  )| (___) || )  \\  || (___) || (____/\\| (___) || )  \\  |".center(70)
puts "(______/ (_______)|/    )_)(_______)(_______/(_______)|/    )_)".center(70)
puts "  ___ ______ _   _ _____ _   _ _____ _   _______ _____ ".center(70)
puts " / _ \\|  _  \\ | | |  ___| \\ | |_   _| | | | ___ \\  ___|".center(70)
puts "/ /_\\ \\ | | | | | | |__ |  \\| | | | | | | | |_/ / |__ ".center(68)
puts "|  _  | | | | | | |  __|| . ` | | | | | | |    /|  __|".center(68)
puts "| | | | |/ /\\ \\_/ / |___| |\\  | | | | |_| | |\\ \\| |___".center(68)
puts "\\_| |_/___/  \\___/\\____/\\_| \\_/ \\_/  \\___/\\_| \\_\\____/ ".center(70)
puts

	while true
		puts "What is your name?".chomp
		traveler = gets
		if traveler == "\n"
			puts "Come on, everyone has a name..."
		else
			@traveler = traveler.chomp.split[0]
			break
		end
	end
	puts "You have been adventuring deep into the forest, #{@traveler}.\n".center(80)
	puts "When your way is blocked by a steep stone outcropping\n".center(80)
	puts "At the foot of the outcropping there is a worn leather-bound book.\n".center(80)
	fails = 0
		while true
		puts "Enter 'take book' to pick it up, if you dare."
			input = gets
			@input = input.chomp.downcase
			@input = abbrev_check(@input)
			if @input == 'take book'
			puts "You take the book from the forest floor, it has an unearthly feel..."
				@in_hands.push("book"); @in_room.delete("book") ; fails = 0
				puts "Press <ENTER> to proceed."
				gets
				while true
					puts "To have a look inside, enter the command 'inspect book'"
					input = gets
					@input = input.chomp.downcase
					@input = abbrev_check(@input)
					if @input == 'inspect book'
						puts "You open the book and look on the first page"
						inspect_book; fails = 0
						puts "Press <ENTER> to proceed."
						gets
						break
					elsif fails == 2
						puts "*cough* 'inspect book' *cough*"
						fails = 0
					else
						fails+=1

					end
				end
				break
			elsif fails == 2
				abort
			else
				fails += 1
			end
		end
	puts
	puts "The book is magic, there's no use denying it.\n"
	puts "You've brought your bag along with you to keep something like this.\n"
	puts "Press <ENTER> to proceed."
	gets
		while true
			puts "To open your bag you have to inspect it."
			input = gets
			@input = input.chomp.downcase
			@input = abbrev_check(@input)
				if @input == 'inspect bag'
					inputs(@input); fails = 0
						puts "Press <ENTER> to proceed."
						gets
					break
				elsif fails == 2
					puts "*cough* 'inspect bag' *cough*"
					fails = 0
				else
					fails += 1
				end
		end
		while true
		puts "Inspect something in your bag."
		input = gets
		@input = input.chomp.downcase
		@input = abbrev_check(@input)
			if @input == "inspect canteen" || @input == "inspect matchbox"
				inputs(@input) ; fails = 0
				puts "Press <ENTER> to proceed."
				gets
			break
			elsif fails == 2
				puts "*cough* 'inspect canteen or matchbook' *cough*"
				fails = 0
			else
				fails += 1
			end
		end
		while true
		puts "Very interesting, now look at what you have in your hands."
		input = gets
		@input = input.chomp.downcase
		@input = abbrev_check(@input)
			if @input == "inspect hands" || @input == "inspect hand"
				inputs(@input); fails = 0
				puts "Press <ENTER> to proceed."
				gets
				break
			elsif fails == 2
				puts "*cough* 'inspect hands' *cough*"
				fails = 0
			else
				fails += 1
			end
		end
		puts "Now try to inspect the canteen or matchbox in your bag again."
		while true
			input = gets
			@input = input.chomp.downcase
			@input = abbrev_check(@input)
			if @input == "inspect bag"
				inputs(@input) ; fails = 0
				puts
				puts "Press <ENTER> to proceed."
				gets
				break
			elsif @input == "inspect canteen" || @input == "inspect matchbox"
				inputs(@input)
				puts
				puts "Odd? No. You closed the bag to look in your hands.\nInspect your bag then see what's in there."
			elsif fails == 2
				puts "*cough* 'inspect bag' *cough*"
				fails = 0
			else
				fails += 1
			end
		end
		puts "You have to open the bag before utilizing the items in it."
		puts "It 'closes' every time you look at your hands or the room you are in."
		puts "Press <ENTER> to proceed."
		gets
		while true
			puts "Good, now inspect an item in your bag."
			input = gets
			@input = input.chomp.downcase
			@input = abbrev_check(@input)
			if @input == "inspect canteen" || @input == "inspect matchbox"
				inputs(@input) ; fails = 0
				puts "Press <ENTER> to proceed."
				gets
				break
			elsif @input == 'inspect bag'
				inputs(@input)
				puts
			elsif fails == 2
				puts "*cough* 'inspect canteen or matchbook' *cough*"
				fails = 0
			else
				fails += 1
			end
		end
		puts
		puts "Get it? Inspect your bag to open it before looking at the objects inside."
		puts "Press <ENTER> to proceed."
		gets
		fails = 0
		while true
			puts "Now, put the magic book in the bag."
			input = gets
			@input = input.chomp.downcase
			@input = abbrev_check(@input)
			if @input == "put book" || @input == "place book" || @input == "drop book"
				inputs(@input); fails = 0
				break
			elsif fails == 2
				puts "*cough* 'put book' *cough*"
				fails = 0
			else
				fails += 1
			end
		end
		puts "Press <ENTER> to proceed."
		gets
		while true
		puts
		puts "Great, now look in the bag again to check it out."
			input = gets
			@input = input.chomp.downcase
			@input = abbrev_check(@input)
			if @input == "inspect bag"
				inputs(@input); fails = 0
				puts "Press <ENTER> to proceed."
				gets
				break
			elsif fails == 2
				puts "*cough* 'inspect bag' *cough*"
				fails = 0
			else
				fails += 1
			end
		end
		while true
		puts "Cool! Now check out what is in your hands."
			input = gets
			@input = input.chomp.downcase
			@input = abbrev_check(@input)
			if @input == "inspect hand" || @input == "inspect hands"
				inputs(@input); fails = 0
				puts "Press <ENTER> to proceed."
				gets
				break
			elsif fails == 2
				puts "*cough* 'inspect hands' *cough*"
				fails = 0
			else
				fails += 1
			end
		end
		while true
		puts
		puts "And now check out the book."
			input = gets
			@input = input.chomp.downcase
			@input = abbrev_check(@input)
			if @input == "inspect book"
				inputs(@input) ; fails = 0
				puts "Press <ENTER> to proceed."
				gets
				fails = 0
				break
			elsif fails == 2
				puts "*cough* 'inspect book' *cough*"
				fails = 0
			else
				fails += 1
			end
		end
		puts
		puts "I know what you're thinking, but the book is still in the bag."
		sleep 3
		puts "The book really is magic! (you can check it out for help anytime)"
		puts "Press <ENTER> to proceed."
		gets
		fails = 0
		puts "-/\\/\\/\\/\\/\\/\\/\\/\\-RUMBLE-/\\/\\/\\/\\/\\/\\/\\/\\-RUMBLE-/\\/\\/\\/\\/\\/\\/\\/\\-".center(80)
		puts "What's that noise?"
		sleep 5
		puts
		puts "-/\\/\\/\\/\\/\\/\\/\\/\\--/\\/\\/\\/\\/\\/\\/\\/\\-RUMBLE-/\\/\\/\\/\\/\\/\\/\\/\\--/\\/\\/\\/\\/\\/\\/\\/\\-".center(80)
		sleep 3
		puts "Holy New Horizons! The rock wall in front of you just opened up!"
		puts "Talk about magic!"
		puts "Press <ENTER> to proceed."
		gets
		fails = 0
		fails = 0
		puts "Inspect the wall for yourself if you don't believe me..."
		while true
			input = gets
			@input = input.chomp.downcase
			@input = abbrev_check(@input)
			if @input == "inspect wall"
				puts "There's a small opening in front of you where a solid rock wall used to be." ; fails = 0
				puts "Press <ENTER> to proceed."
				gets
				break
			elsif fails == 2
				puts "*cough* 'inspect wall' *cough*"
				fails = 0
			else
				puts "Don't believe me? It really opened up, just look!"
				fails += 1
			end
		end
	puts "See? I told you. This adventuring is turning into a real... adventure."
	puts "Press <ENTER> to proceed."
	gets
	fails = 0
	while true
		puts "Let's go inside! Come on!"
			input = gets
			@input = input.chomp.downcase
			@input = abbrev_check(@input)
			if @input == "go forward" || @input == "move forward" || @input == "go straight" || @input == "move straight" || @input == "go inside"
				puts "You step cautiously into the newly formed opening..."
				fails = 0
				@room_place = 2
				room_items
				break
			elsif fails == 2
				puts "*cough* 'go forward' *cough*"
				fails = 0
			else
				fails+=1
			end
		end
	puts "Press <ENTER> to proceed."
	gets
	while true
		puts "The cave chamber is large and mostly vacant, inspect the room for yourself."
			input = gets
			@input = input.chomp.downcase
			@input = abbrev_check(@input)
			if @input == "inspect room"
				inputs(@input); fails = 0
				break
			elsif fails == 2
				puts "*cough* 'inspect room' *cough*"
				fails = 0
			else
				fails+=1
			end
		end
	puts "Press <ENTER> to proceed."
	gets
	while true
		puts "A torch... that might come in handy. Pick it up."
			input = gets
			@input = input.chomp.downcase
			@input = abbrev_check(@input)
			if @input == "take torch" || @input == "grab torch"
				inputs(@input) ; fails = 0
				break
			elsif fails == 2
				puts "*cough* 'grab torch' *cough*"
				fails = 0
			else
				fails+=1
			end
		end
	puts "Press <ENTER> to proceed."
	gets
		while true
		puts "Ok, now let's light it up."
			input = gets
			@input = input.chomp.downcase
			@input = abbrev_check(@input)
			if @input == "inspect bag"
				inputs(@input) ; fails = 0
				break
			elsif fails == 2
				puts "*cough* 'inspect bag' *cough*"
				fails = 0
			else
				fails+=1
			end
		end
		while true
		puts "Take out something to light the torch."
			input = gets
			@input = input.chomp.downcase
			@input = abbrev_check(@input)
			if @input == "take matchbox" || @input == "grab matchbox"
				inputs(@input) ; fails = 0
				break
			elsif fails == 2
				puts "*cough* 'grab matchbox' *cough*"
				fails = 0
			else
				fails+=1
			end
		end
		while true
		puts "Great! Now you can light the torch!"
			input = gets
			@input = input.chomp.downcase
			@input = abbrev_check(@input)
			if @input == "light torch" || @input == "light torch"
				inputs(@input) ; fails = 0
				break
			elsif fails == 2
				puts "*cough* 'light torch' *cough*"
				fails = 0
			else
				fails+=1
			end
		end
		puts "Fire on a stick! Awesome! Light the lamp yourself now..."
		while true
			input = gets
			@input = input.chomp.downcase
			@input = abbrev_check(@input)
			inputs(@input) ; fails = 0
			if @in_room.any? { |item| item == "litlamp" }
				puts "Great job! You got it now!"
				@in_room.delete("lit")
				break
			elsif fails == 5
				puts "(Inspect the room and light the lamp in it.)"
				fails = 0
			else
				fails+=1
			end
		end
	puts "Press <ENTER> to proceed."
	gets
	find_room(2).doors.replace([1,0,0,0])
	puts "-/\\/\\/\\/\\/\\/\\/\\/\\-RUMBLE-/\\/\\/\\/\\/\\/\\/\\/\\-RUMBLE-/\\/\\/\\/\\/\\/\\/\\/\\-".center(80)
	sleep 3
	puts "O no! It's that noise again!!! I'm getting out of here!"
	sleep 3
	puts
	puts "-/\\/\\/\\/\\/\\/\\/\\/\\--/\\/\\/\\/\\/\\/\\/\\/\\-RUMBLE-/\\/\\/\\/\\/\\/\\/\\/\\--/\\/\\/\\/\\/\\/\\/\\/\\-".center(80)
	sleep 1
	puts "Maybe I'll see you again #{@traveler}! Best of luck to ya!"
	sleep 3
	puts "The doorway behind you closes... you are trapped in this dungeon."
	puts "The only way to go is in."
	while true
		input = gets
		@input = input.chomp.downcase
		inputs(@input)
	end

  def skip
    while true
      puts "What is your name?".chomp
      traveler = gets
      if traveler == "\n"
        puts "Come on, everyone has a name..."
      else
        @traveler = traveler.chomp.split[0]
        break
      end
    end
    @room_place = 2
    room_items
    find_room(2).doors.replace([1,0,0,0])
    @in_room.delete("lit")
    @in_room.delete("lamp")
    @in_room.push("litlamp")
    @in_room.delete("torch")
    @in_hands.push("torch")
    light_torch
    @in_bag.push("book")
    while true
      input = gets
      @input = input.chomp.downcase
      inputs(@input)
    end
  end
end
