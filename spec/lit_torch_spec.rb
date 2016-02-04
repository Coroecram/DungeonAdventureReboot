RSpec.describe Lit_torch do
    describe '#inspect' do
      it 'returns the object description' do
        expect(Lit_torch.new.inspect).to eq(    "A plain-old 2-button computer mouse.")
      end
    end
    describe '#to_s' do
      it 'returns the object name' do
        expect(Lit_torch.new.to_s).to eq(    "a mouse (computer)")
      end
    end
end