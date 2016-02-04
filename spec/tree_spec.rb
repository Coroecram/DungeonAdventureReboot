require 'tree'

RSpec.describe Tree do
    describe '#inspect' do
      it 'returns the tree description' do
        expect(Tree.new.inspect).to eq("There is a large dead tree with many branches that look like they can burn.\nWho knows how it got here?")
      end
    end
    describe '#to_s' do
      it 'returns the tree string' do
        expect(Tree.new.to_s).to eq("a large dead tree")
      end
    end
end
