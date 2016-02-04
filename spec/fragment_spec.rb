require 'fragment'

RSpec.describe Fragment do
    describe '#inspect' do
      it 'returns the object description' do
        expect(Fragment.new.inspect).to eq(		"A stone fragment with carving on it.")
      end
    end
    describe '#to_s' do
      it 'returns the object name' do
        expect(Fragment.new.to_s).to eq(		"a stone fragment")
      end
    end
end