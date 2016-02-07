require 'platform'

RSpec.describe Platform do
  before(:all) do
    @platform = Platform.new
  end
    describe '#inspect' do
      it 'returns the platform description' do
        expect(@platform.inspect).to eq("a stone platform with a fragment missing and a computer on top.")
      end
    end
    describe '#to_s' do
      it 'returns the platform string' do
        expect(@platform.to_s).to eq("a stone platform")
      end
    end
end
