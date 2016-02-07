require 'book'

RSpec.describe Book do
    let(:book) { Book.new }

    describe '#inspect' do
      it 'returns the book description' do
        expect(book.inspect).to eq("A black leather-bound book with a certain feel. There are no markings on it.\nYou open to the first page.")
      end
    end
    
    describe '#to_s' do
      it 'returns the book string' do
        expect(book.to_s).to eq("a magical book")
      end
    end
end
