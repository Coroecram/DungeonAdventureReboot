require 'cord'

RSpec.describe Cord do
  before(:all) do
    @cord = Cord.new
  end
    describe '#inspect' do
      it 'returns the cord description' do
        expect(@cord.inspect).to eq("a cord coming out of the hole")
      end
    end
    describe '#to_s' do
      it 'returns the cord string' do
        expect(@cord.to_s).to eq("A cord is sticking out of the mouse hole.")
      end
    end
end
