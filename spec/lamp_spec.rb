require 'lamp'

RSpec.describe Lamp do
    describe '#inspect' do
      it 'returns the lamp description' do
        expect(Lamp.new.inspect).to eq("A black metal lamp hanging on a post about 6 feet tall in the middle of the room.")
      end
    end
    describe '#to_s' do
      it 'returns the lamp string' do
        expect(Lamp.new.to_s).to eq("a lamp")
      end
    end
end
