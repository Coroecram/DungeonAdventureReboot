require 'chest'

RSpec.describe Chest do
  let(:chest) { Chest.new }

    describe '@locked' do
      it 'is locked when initialized' do
        expect(chest.locked).to eq(true)
      end
    end

    describe '@opened' do
      it 'is closed when initialized' do
        expect(chest.opened).to eq(false)
      end
    end

    describe '@contents' do
      it 'has a Keyboard when initialized' do
        expect(chest.contents[0].class).to eq(Keyboard)
      end
    end

    describe '#unlock' do
      it 'can be unlocked' do
        test_unlock
        expect(chest.locked).to eq(false)
      end
    end

    describe '#open' do
      it 'can be opened' do
        unlock_and_open
        expect(chest.open).to eq(true)
      end
    end

    describe '#inspect' do
      it 'returns the locked chest description' do
        expect(chest.inspect).to eq("A large locked wooden chest with a keypad on it.")
      end

      it 'returns the unlocked chest description' do
        test_unlock
        expect(chest.opened).to eq(false)
      end

      it 'returns the unlocked and open chest description' do
        unlock_and_open
        expect(chest.inspect).to eq("An open treasure chest with a keyboard inside.")
      end

      it 'returns the unlocked, open, and empty chest description' do
        test_empty
        expect(chest.inspect).to eq("An open treasure chest with only dust inside.")
      end

      it 'returns the unlocked, empty, and closed chest description' do
        empty_and_close
        expect(chest.inspect).to eq("A large unlocked treasure chest with nothing inside.")
      end
    end

    describe '#to_s' do
      it 'returns the locked chest string' do
        expect(chest.to_s).to eq("a large wooden treasure chest")
      end
    end
end

def test_unlock
  chest.unlock
end

def unlock_and_open
  test_unlock
  chest.open
end

def test_close
  unlock_and_open
  chest.close
end

def test_empty
  unlock_and_open
  chest.empty
end

def empty_and_close
  test_empty
  chest.close
end
