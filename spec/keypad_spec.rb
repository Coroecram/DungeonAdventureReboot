RSpec.describe Keypad do
    describe '#inspect' do
      it 'returns the object description' do
        expect(Keypad.new.inspect).to eq(	puts "The keypad on the chest has the following buttons on it:")
      end
    end
    describe '#to_s' do
      it 'returns the object name' do
        expect(Keypad.new.to_s).to eq(    spooky  ? "a spooky ghost" : "a ghost")
      end
    end
end