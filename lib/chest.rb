require 'keyboard'

class Chest
  attr_accessor :locked, :opened, :contents

  def initialize
    @locked = true
    @opened = false
    @contents = [Keyboard.new]
  end

  def unlock
    self.locked = false
  end

  def open
    self.opened = true if self.locked == false
  end

  def close
    self.opened = !self.opened if self.opened
  end

  def empty
    @contents = []
  end

  def empty?
    self.locked ? false : @contents.empty?
  end

  def inspect
    if self.locked
      "A large locked wooden chest with a keypad on it."
    else
      if self.opened
        self.empty? ?  "An open treasure chest with only dust inside." :
                       "An open treasure chest with a keyboard inside."
      else
        self.empty? ? "A large unlocked treasure chest with nothing inside." :
                      "A large unlocked wooden treasure chest."
      end
    end
  end

  def to_s
    return self.locked ? "a large wooden treasure chest" : ""
  end
end
