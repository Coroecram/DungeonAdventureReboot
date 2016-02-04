require 'util'

RSpec.describe Util do
    describe '#inspect' do
      it 'returns the object description' do
        expect(Util.new.inspect).to eq(				@scope_bag = 1; @scope_hands = 0; @scope_room = 0)
      end
    end
    describe '#to_s' do
      it 'returns the object name' do
        expect(Util.new.to_s).to eq(						stuff_total = "You open the bag. You can feel a " + things.join(" and ") + " in your bag.")
      end
    end
end