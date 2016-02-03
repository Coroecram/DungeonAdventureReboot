class Monitor

  def inspect
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
end
