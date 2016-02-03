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
