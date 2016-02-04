RSpec.describe Disk do
    describe '#inspect' do
      it 'returns the object description' do
        expect(Disk.new.inspect).to eq(    "An old-time floppy disk")
      end
    end
    describe '#to_s' do
      it 'returns the object name' do
        expect(Disk.new.to_s).to eq(    "a floppy disk")
      end
    end
end