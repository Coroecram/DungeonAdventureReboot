require 'mouse'

RSpec.describe Mouse do
    describe '#inspect' do
      it 'returns the object description' do
        expect(Mouse.new.inspect).to eq(    "A plain-old 2-button computer mouse.")
      end
    end
    describe '#to_s' do
      it 'returns the object name' do
        expect(Mouse.new.to_s).to eq(    "a mouse (computer)")
      end
    end
end