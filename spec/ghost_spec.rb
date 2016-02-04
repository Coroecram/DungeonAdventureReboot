require 'ghost'

RSpec.describe Ghost do
    describe '#inspect' do
      it 'returns the ghost description' do
        expect(Ghost.new.inspect).to eq("A terrifying ghost moaning and staring right at you!")
      end
    end
    describe '#to_s' do
      it 'returns the object name' do
        expect(Ghost.new.to_s).to eq("a spooky ghost")
      end
    end
end
