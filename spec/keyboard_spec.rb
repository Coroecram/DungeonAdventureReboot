require 'keyboard'

RSpec.describe Keyboard do
    describe '#inspect' do
      it 'returns the keyboard description' do
        expect(Keyboard.new.inspect).to eq("A standard QWERTY keyboard.")
      end
    end
    describe '#to_s' do
      it 'returns the keyboard string' do
        expect(Keyboard.new.to_s).to eq("a computer keyboard")
      end
    end
end
