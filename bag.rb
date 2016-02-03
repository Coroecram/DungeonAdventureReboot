class Bag
  attr_accessor :contents

  def initialize(contents)
    @contents = contents
  end

  def in_bag
  	@scope_bag = 1; @scope_hands = 0; @scope_room = 0
  	if @in_bag.length == 0
  		puts "There is nothing in your bag."
  	else
  		things = []
  		@in_bag.each {|object| things << find_object((object[/\D+/]).to_sym).name}
  		stuff_total = "You open the bag. There is " + things.join(" and ") + " in your bag."
  		puts stuff_total.scan(/.{1,80}\W/).map(&:strip)
  	end
  end
end
