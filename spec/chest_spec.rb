require 'chest'

RSpec.describe Chest do
  before(:each) do
    @chest = Chest.new
  end
    describe '@locked' do
      it 'is locked when initialized' do
        expect(@chest.locked).to eq(true)
      end
    end
    describe '#unlock' do
      it 'can be unlocked' do
        @chest.unlock
        expect(@chest.locked).to eq(false)
      end
    end
    describe '#inspect' do
      it 'returns the object description' do
        expect(@chest.inspect).to eq("A large locked wooden chest with a keypad on it.")
      end
    end
    describe '#to_s' do
      it 'returns the chest string' do
        expect(@chest.to_s).to eq("a large wooden treasure chest")
      end
    end
end
