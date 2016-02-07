require 'branch'

RSpec.describe Branch do
  before(:all) do
    @branch = Branch.new
  end
    describe '#inspect' do
      it 'returns the branch description' do
        expect(@branch.inspect).to eq("A branch; it looks like it could be taken and used as a torch.")
      end
    end
    describe '#to_s' do
      it 'returns the branch string' do
        expect(@branch.to_s).to eq("a tree branch")
      end
    end
end
