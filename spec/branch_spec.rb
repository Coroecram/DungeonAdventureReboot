RSpec.describe Branch do
    describe '#inspect' do
      it 'returns the object description' do
        expect(Branch.new.inspect).to eq(    "A branch; it looks like it could be taken and used as a torch.")
      end
    end
    describe '#to_s' do
      it 'returns the object name' do
        expect(Branch.new.to_s).to eq(    "a tree branch")
      end
    end
end