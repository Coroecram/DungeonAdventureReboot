require 'chest'

RSpec.describe Chest do
    describe '#inspect' do
      it 'returns the object description' do
        expect(Chest.new.inspect).to eq(    locked ? "A large locked wooden chest with a keypad on it." : "")
      end
    end
    describe '#to_s' do
      it 'returns the object name' do
        expect(Chest.new.to_s).to eq(    locked ? "a large wooden treasure chest" : "")
      end
    end
end