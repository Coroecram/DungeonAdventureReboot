require 'ghost'

RSpec.describe Ghost do
  before(:all) do
    @ghost = Ghost.new
  end
    describe '#inspect' do
      it 'returns the ghost description' do
        expect(@ghost.inspect).to eq("A terrifying ghost moaning and staring right at you!")
      end
    end
    describe '#to_s' do
      it 'returns the object name' do
        expect(@ghost.to_s).to eq("a spooky ghost")
      end
    end
end
