require 'ui'

RSpec.describe UI do
    describe '#inspect' do
      it 'returns the object description' do
        expect(UI.new.inspect).to eq()
      end
    end
    describe '#to_s' do
      it 'returns the object name' do
        expect(UI.new.to_s).to eq()
      end
    end
end
