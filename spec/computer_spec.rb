RSpec.describe Computer do
    describe '#inspect' do
      it 'returns the object description' do
        expect(Computer.new.inspect).to eq(    "It's an old computer, still running, on top of the platform.")
      end
    end
    describe '#to_s' do
      it 'returns the object name' do
        expect(Computer.new.to_s).to eq(    "a computer")
      end
    end
end