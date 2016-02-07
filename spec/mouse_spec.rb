require 'mouse'

RSpec.describe Mouse do
  let(:mouse) { Mouse.new }

    describe '#inspect' do
      it 'returns the mouse description' do
        expect(mouse.inspect).to eq("A plain-old 2-button computer mouse.")
      end
    end
    
    describe '#to_s' do
      it 'returns the mouse string' do
        expect(mouse.to_s).to eq("a mouse (computer)")
      end
    end
end
