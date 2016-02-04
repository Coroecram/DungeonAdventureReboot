require 'cat'

RSpec.describe Cat do
    describe '#inspect' do
      it 'returns the cat description' do
        expect(Cat.new.inspect).to eq(    "It's a Siamese cat in the corner, looks friendly enough.")
      end
    end
    describe '#to_s' do
      it 'returns the cat string' do
        expect(Cat.new.to_s).to eq(    "a cat")
      end
    end
end
