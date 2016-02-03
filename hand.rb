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
