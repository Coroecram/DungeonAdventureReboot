require 'keyboard'

RSpec.describe Keyboard do
  before(:all) do
    @keyboard = Keyboard.new
  end
    describe '#inspect' do
      it 'returns the keyboard description' do
        expect(@keyboard.inspect).to eq("A standard QWERTY keyboard.")
      end
    end
    describe '#to_s' do
      it 'returns the keyboard string' do
        expect(@keyboard.to_s).to eq("a computer keyboard")
      end
    end
end
