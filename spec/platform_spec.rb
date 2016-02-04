require 'platform'

RSpec.describe Platform do
    describe '#inspect' do
      it 'returns the platform description' do
        expect(Platform.new.inspect).to eq("a stone platform with a fragment missing and a computer on top.")
      end
    end
    describe '#to_s' do
      it 'returns the platform string' do
        expect(Platform.new.to_s).to eq("a stone platform")
      end
    end
end
