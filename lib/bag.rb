class Bag
  attr_accessor :contents

  def initialize(contents)
    @contents = contents
  end

  def in_bag
  	@scope_bag = 1; @scope_hands = 0; @scope_room = 0
  	if @contents.length == 0
  		puts "There is nothing in your bag."
  	else
  		output = "You open the bag. There is " + @contents.join(" and ") + " in your bag."
  		puts output.scan(/.{1,80}\W/).map(&:strip)
  	end
  end

  def to_s
    "A worn black leather messenger bag, big enough to hold a few items."
  end
end
