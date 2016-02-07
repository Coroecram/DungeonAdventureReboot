require 'cat'

RSpec.describe Cat do
  let(:cat) { Cat.new }

    describe '#purr' do
      it 'the cat can purr' do
        expect(cat.purr).to eq("The cat purrs gratefully")
      end
    end

    describe '#inspect' do
      it 'returns the cat description' do
        expect(cat.inspect).to eq("It's a Siamese cat in the corner, looks friendly enough.")
      end
    end
    
    describe '#to_s' do
      it 'returns the cat string' do
        expect(cat.to_s).to eq("a cat")
      end
    end
end
