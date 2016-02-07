require 'hole'

RSpec.describe Hole do
    let(:hole) { Hole.new }

    describe '#inspect' do
      it 'returns the hole description' do
        expect(hole.inspect).to eq("There is a small hole in the wall. You can hear scurrying inside.")
      end
    end
    describe '#to_s' do
      it 'returns the hole string' do
        expect(hole.to_s).to eq("a small hole in the wall")
      end
    end
end
