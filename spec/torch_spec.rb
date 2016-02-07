require 'torch'

RSpec.describe Torch do
  before(:all) do
    @torch = Torch.new
  end
    describe '#inspect' do
      it 'returns the torch description' do
        expect(@torch.inspect).to eq("A piece of wood with flammable resin inside.\nIt can be lit to provide a bright flame.")
      end
    end
    describe '#to_s' do
      it 'returns the torch string' do
        expect(@torch.to_s).to eq("a torch")
      end
    end
end
