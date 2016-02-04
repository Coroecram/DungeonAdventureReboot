RSpec.describe Lamp do
    describe '#inspect' do
      it 'returns the object description' do
        expect(Lamp.new.inspect).to eq(    flame ? "A black metal lamp hanging on a post about 6 feet tall burning brightly." :)
      end
    end
    describe '#to_s' do
      it 'returns the object name' do
        expect(Lamp.new.to_s).to eq(    flame ? "a lamp burning brightly" : "a lamp")
      end
    end
end