require 'ghost'

RSpec.describe Ghost do
    describe '#inspect' do
      it 'returns the object description' do
        expect(Ghost.new.inspect).to eq(    "A terrifying ghost moaning and staring right at you!")
      end
    end
    describe '#to_s' do
      it 'returns the object name' do
        expect(Ghost.new.to_s).to eq(    spooky  ? "a spooky ghost" : "a ghost")
      end
    end
end