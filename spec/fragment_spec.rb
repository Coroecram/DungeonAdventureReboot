require 'fragment'

RSpec.describe Fragment do
  let(:fragment) { Fragment.new }

    describe '#inspect' do
      it 'returns the fragment description' do
        expect(fragment.inspect).to eq("A stone fragment with carving on it.")
      end
    end
    
    describe '#to_s' do
      it 'returns the fragment string' do
        expect(fragment.to_s).to eq("a stone fragment")
      end
    end
end
