require 'adventure'

RSpec.describe Adventure do
  let(:adventure) { Adventure.new }

  describe 'includes Util' do
    it 'has the Util module' do
      expect((class << adventure; self; end).included_modules.include?(Util)).to eq(true)
    end

    it 'has a HighLine console' do
      expect(adventure.console.class).to eq(HighLine)
    end
  end

  describe '.initialize' do

  end
end
