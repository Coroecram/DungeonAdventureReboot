require 'util'
require 'highline'

RSpec.describe Util do
  before(:all) do
    @input  = StringIO.new
    @output = StringIO.new
  end
  let(:util) { Class.new { extend Util } }
  let(:console) { util.console(@input, @output) }
  let(:question) { HighLine::Question.new("Testing?", nil) }
  let(:asker) { HighLine::QuestionAsker.new(question, console) }

  describe 'console' do
    it 'has a HighLine console' do
      expect(util.console.class).to eq(HighLine)
    end

    it 'passes console input through' do
      @input.string = 'Pass'
      expect(asker.ask_once).to eq('Pass')
    end
  end
end
