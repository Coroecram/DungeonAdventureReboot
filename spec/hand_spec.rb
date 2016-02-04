require 'hand'

RSpec.describe Hand do
    describe '#inspect' do
      it 'returns the hand description' do
        expect(Hand.new.inspect).to eq("It's an old computer, still running, on top of the platform.")
      end
    end
    describe '#to_s' do
      it 'returns the hand string' do
        expect(Hand.new.to_s).to eq("Your good ole' reliable hands.")
      end
    end
end
