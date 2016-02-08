require 'util'

RSpec.describe Util do
  let(:util) { Class.new { extend Util } }

  describe 'console' do
    it 'has a HighLine console' do
      expect(util.console.class).to eq(HighLine)
    end

    it 'can input from console' do
      expect(util.ask("How are you?")).to receive(:gets)
    end
  end
end
