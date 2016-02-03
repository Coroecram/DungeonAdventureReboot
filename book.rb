class Book
  def inspect_book
  	puts "___________________________________________________________________________".center(80)
  	puts "Hello #{@traveler}, looking for some help?\n".center(80)
  	puts "Here's a list of some handy commands and a short description of what they do!\n".center(80)
  	puts "Type [command] [item or direction] and press ENTER".center(80)
  	puts "Command \t Description"
  	puts "move/go   Move your character in [direction].\n"
  	puts "inspect   Inspect an [object].\n\t  Inspect your bag, hands, or the room to manipulate the items in them.\n"
  	puts "take/grab Pick up an [item]."
  	puts "put/place Put down an [item] in your hands."
  	puts "light \t  Light  the [object] on fire (be careful!)."
  	puts "clean \t  Some [items] are dirty.\n\n"
  	puts "____________________________________________________________________________".center(80)
  	puts "Press <ENTER> to look at the facing page."
  	gets
  	puts "____________________________________________________________________________".center(80)
  	puts "Here are some helpful tips #{@traveler}!".center(80)
  	puts "Don't forget torches burn out, it is not safe to be lost in the dark!".center(80)
  	puts "You will always drop and pickup the most burnt torch first.".center(80)
  	puts "Branches can be taken as torches.".center(80)
  	puts "Do not use descriptors except for a 'lit' torch or lamp.".center(80)
  	puts "Unique abbreviations are acceptable.".center(80)
  	puts "Again, don't forget torches burn out, it is not safe to be lost in the dark!".center(80)
  	puts "Check how long your lit torches will last frequently!".center(80)
  	puts "____________________________________________________________________________".center(80)
  	puts "Afraid to read on, you close the book."
  end

  def inspect
    "A black leather-bound book with a certain feel. There are no markings on it.\nYou open to the first page."
  end

  def to_s
    "a magical book"
  end
end
