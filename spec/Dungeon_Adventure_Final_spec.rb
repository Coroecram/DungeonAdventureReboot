RSpec.describe Dungeon_adventure_final do
    describe '#inspect' do
      it 'returns the object description' do
        expect(Dungeon_adventure_final.new.inspect).to eq(	@object_list = Abbrev.abbrev(["bag", "room", "hands", "book", "lamp", "litlamp", "torch", "tree", "branch", "cat", "hole", "keyboard", "chest", "disk", "fragment", "keypad", "platform", "computer", "monitor", "mouse", "canteen", "matchbox", "ghost", "cord", "littorch"]); @object_list["h"]= "hands"; @object_list["fl"] = "disk"; @object_list["flo"] = "disk"; @object_list["flop"] = "disk"; @object_list["flopp"] = "disk"; @object_list["floppy"] = "disk")
      end
    end
    describe '#to_s' do
      it 'returns the object name' do
        expect(Dungeon_adventure_final.new.to_s).to eq(    "Your good ole' reliable hands.")
      end
    end
end