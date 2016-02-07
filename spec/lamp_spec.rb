require 'lamp'

RSpec.describe Lamp do
  before(:all) do
    @lamp = Lamp.new
  end
  describe 'Flammable::Lamp' do
    it 'inherits from Flammable' do
      expect(@lamp.kind_of?(Flammable)).to eq(true)
    end
    it 'is flammable' do
      expect(@lamp.flammable).to eq(true)
    end
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
    describe '#light' do
      it 'lights up' do
        @lamp.light
        expect(@lamp.lit).to eq(true)
      end
    end
end
