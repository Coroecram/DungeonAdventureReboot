require 'canteen'

RSpec.describe Canteen do
  before(:all) do
    @canteen = Canteen.new
  end
    describe '#inspect' do
      it 'returns the canteen description' do
        expect(@canteen.inspect).to eq("A half-full reusable water canteen.")
      end
    end
    describe '#to_s' do
      it 'returns the canteen string' do
        expect(@canteen.to_s).to eq("a canteen")
      end
    end
end
