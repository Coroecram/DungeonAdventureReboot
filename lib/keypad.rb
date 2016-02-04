class Keypad

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
end
