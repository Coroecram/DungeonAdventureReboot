require 'bag'

RSpec.describe Bag do
    describe '#inspect' do
      it 'returns the object description' do
        expect(Bag.new.inspect).to eq(    "A black leather-bound book with a certain feel. There are no markings on it.\nYou open to the first page.")
      end
    end
    describe '#to_s' do
      it 'returns the object name' do
        expect(Bag.new.to_s).to eq(    "A worn black leather messenger bag, big enough to hold a few items.")
      end
    end
end