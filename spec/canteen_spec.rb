require 'canteen'

RSpec.describe Canteen do
    describe '#inspect' do
      it 'returns the canteen description' do
        expect(Canteen.new.inspect).to eq("A half-full reusable water canteen.")
      end
    end
    describe '#to_s' do
      it 'returns the canteen string' do
        expect(Canteen.new.to_s).to eq("a canteen")
      end
    end
end
