class Hand
  attr_accessor :contents

  def initialize(contents = [])
    @contents = contents
  end

  def holding
  	if @contents.length == 0
  		puts "There is nothing in your hands."
  	else
  		if contents.length == 1
  			puts "There is " + @contents[0] + " in your hand."
  		else
  			puts "There is " + @contents.join(" and ") + " in your hands."
  		end
  	end
  end

  def inspect
    "Your good ole' reliable hands."
  end
end
