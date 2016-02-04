require 'book'

RSpec.describe Book do
    describe '#inspect' do
      it 'returns the book description' do
        expect(Book.new.inspect).to eq("A black leather-bound book with a certain feel. There are no markings on it.\nYou open to the first page.")
      end
    end
    describe '#to_s' do
      it 'returns the book string' do
        expect(Book.new.to_s).to eq("a magical book")
      end
    end
end
