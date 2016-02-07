require 'matchbox'

RSpec.describe Matchbox do
  before(:all) do
    @matchbox = Matchbox.new
  end
    describe '#inspect' do
      it 'returns the matchbox description' do
        expect(@matchbox.inspect).to eq("A strike-on-box with so many matches you can't run out.")
      end
    end
    describe '#to_s' do
      it 'returns the matchbox string' do
        expect(@matchbox.to_s).to eq("a matchbox")
      end
    end
end
