class UI
	def inputs(string)
		if string == "pet cat"
			pet_cat
		elsif string =~(/.+lit torch/) || string =~(/.+littorch/)
			command = string.split[0]
			if @commands.any?  {|k, v| k == command}
				command = @commands[command]
			end
			@subject = "littorch".to_sym
			torch_parse(command)
		elsif string =~(/.+lit lamp/) || string =~(/.+litlamp/)
			command = string.split[0]
			@subject = "litlamp".to_sym
			command_parse(command)
		elsif string.class == String && string.split.length == 2
			command = string.split[0]
			@subject = string.split[1]
			command_parse(command)
		else
			puts "Please enter a valid command."
			puts "[action] [object]"
		end
	end

	def command_parse(inquiry)
		if @commands.any?  {|k, v| k == inquiry}
			inquiry = @commands[inquiry]
			if inquiry == "move" || inquiry == "go"
				move_command(@subject.to_s)
			elsif @object_list.any?  {|k, v| k == @subject}
				@subject = @object_list[@subject].to_sym
				@error_count = 0
				if inquiry == "take" || inquiry == "grab"
					take_command(@subject)
				elsif inquiry == "inspect"
					inspect_command(@subject)
				elsif inquiry == "put" || inquiry == "place" || inquiry == "drop"
					put_command(@subject)
				elsif inquiry == "clean" || inquiry == "wipe"
						clean_command(@subject)
				elsif inquiry == "light"
					light_command(@subject)
				end
			else
				if @error_count < 1
					puts "Please enter a valid object. (#{inquiry} what?)"
					@error_count += 1
					@subject = gets.downcase.chomp
					command_parse(inquiry)
				else
					puts "Please enter a valid command."
					@error_count = 0
				end
			end
		else
			puts "That is not something you can do."
			puts "Please enter a valid command"
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
end
