require 'hand'

RSpec.describe Hand do
  let(:hand) { Hand.new }

    describe '#to_s' do
      it 'returns the hand description' do
        expect(hand.to_s).to eq("Your good ole' reliable hands.")
      end
    end
end
