require 'disk'

RSpec.describe Disk do
  before(:all) do
    @disk = Disk.new
  end
    describe '#inspect' do
      it 'returns the disk description' do
        expect(@disk.inspect).to eq(    "An old-time floppy disk")
      end
    end
    describe '#to_s' do
      it 'returns the disk string' do
        expect(@disk.to_s).to eq("a floppy disk")
      end
    end
end
