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
    describe '@@identifier' do
      it 'new torch has identifier += 1' do
        expect(Torch.new.identifier).to eq(@torch.identifier+1)
      end
    end
    describe '@timeleft' do
      it '@timeleft == 10' do
        expect(@torch.timeleft).to eq(10)
      end
    end
    describe '#burn' do
      before(:each) do
        @torch = Torch.new
      end
      it 'timeleft -= 1 when torch burns' do
        @torch.burn
        expect(@torch.timeleft).to eq(9)
      end
      it "should die after 10 burns" do
        burnout
        expect(@torch.dead).to eq(true)
      end
      it "should not be lit after 10 burns" do
        burnout
        expect(@torch.lit).to eq(false)
      end
    end


end

def burnout
  10.times { @torch.burn }
end
