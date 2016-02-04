require 'hole'

RSpec.describe Hole do
    describe '#inspect' do
      it 'returns the object description' do
        expect(Hole.new.inspect).to eq(    "There is a small hole in the wall. You can hear scurrying inside.")
      end
    end
    describe '#to_s' do
      it 'returns the object name' do
        expect(Hole.new.to_s).to eq(    "a small hole in the wall")
      end
    end
end