require 'intro'

RSpec.describe Intro do
    describe '#inspect' do
      it 'returns the object description' do
        expect(Intro.new.inspect).to eq(				fails = 0)
      end
    end
    describe '#to_s' do
      it 'returns the object name' do
        expect(Intro.new.to_s).to eq(    "a matchbox")
      end
    end
end