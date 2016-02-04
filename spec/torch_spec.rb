require 'torch'

RSpec.describe Torch do
    describe '#inspect' do
      it 'returns the torch description' do
        expect(Torch.new.inspect).to eq("A piece of wood with flammable resin inside.\nIt can be lit to provide a bright flame.")
      end
    end
    describe '#to_s' do
      it 'returns the torch string' do
        expect(Torch.new.to_s).to eq("a torch")
      end
    end
end
