require 'matchbox'

RSpec.describe Matchbox do
    describe '#inspect' do
      it 'returns the object description' do
        expect(Matchbox.new.inspect).to eq(    "A strike-on-box with so many matches you can't run out.")
      end
    end
    describe '#to_s' do
      it 'returns the object name' do
        expect(Matchbox.new.to_s).to eq(    "a matchbox")
      end
    end
end