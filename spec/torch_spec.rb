RSpec.describe Torch do
    describe '#inspect' do
      it 'returns the object description' do
        expect(Torch.new.inspect).to eq(    lit ?  "By the looks of it, the torch will burn for (x more movements)" :)
      end
    end
    describe '#to_s' do
      it 'returns the object name' do
        expect(Torch.new.to_s).to eq(    lit ? "a bright flaming torch" : "a torch")
      end
    end
end