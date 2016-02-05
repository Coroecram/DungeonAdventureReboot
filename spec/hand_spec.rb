require 'hand'

RSpec.describe Hand do
    describe '#inspect' do
      it 'returns the hand description' do
        expect(Hand.new.inspect).to eq("Your good ole' reliable hands.")
      end
    end
end
