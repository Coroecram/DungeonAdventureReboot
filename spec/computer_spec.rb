require 'computer'

RSpec.describe Computer do
  before(:all) do
    @computer = Computer.new
  end
    describe '#inspect' do
      it 'returns the computer description' do
        expect(@computer.inspect).to eq("It's an old computer, still running, on top of the platform.")
      end
    end
    describe '#to_s' do
      it 'returns the computer string' do
        expect(@computer.to_s).to eq("a computer")
      end
    end
end
