require 'lamp'

RSpec.describe Lamp do
  before(:all) do
    @lamp = Lamp.new
  end
    describe '#inspect' do
      it 'returns the lamp description' do
        expect(@lamp.inspect).to eq("A black metal lamp hanging on a post about 6 feet tall in the middle of the room.")
      end
    end
    describe '#to_s' do
      it 'returns the lamp string' do
        expect(@lamp.to_s).to eq("a lamp")
      end
    end
end
