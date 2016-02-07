require 'branch'
require 'torch'

RSpec.describe Branch do
  let(:branch) { Branch.new }

  describe 'Branch < Torch' do
    it 'inherits from Flammable' do
      expect(branch.kind_of?(Flammable)).to eq(true)
    end

    it 'is flammable' do
      expect(branch.flammable).to eq(true)
    end
  end
  #Should be replaced by Torch in production
  describe '#light' do
    it 'returns a new torch' do
      branch.light
      expect(branch.lit).to eq(true)
    end
  end

    describe '#inspect' do
      it 'returns the branch description' do
        expect(branch.inspect).to eq("A branch; it looks like it could be taken and used as a torch.")
      end
    end
    
    describe '#to_s' do
      it 'returns the branch string' do
        expect(branch.to_s).to eq("a tree branch")
      end
    end
end
