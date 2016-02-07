require 'bag'

RSpec.describe Bag do
  before(:all) do
    @bag = Bag.new
  end
  describe '#to_s' do
    it 'returns the bag string' do
      expect(@bag.to_s).to eq("A worn black leather messenger bag, big enough to hold a few items.")
    end
  end
end
