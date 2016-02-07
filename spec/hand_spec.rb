require 'hand'

RSpec.describe Hand do
  before(:all) do
    @hand = Hand.new
  end
    describe '#inspect' do
      it 'returns the hand description' do
        expect(@hand.to_s).to eq("Your good ole' reliable hands.")
      end
    end
end
