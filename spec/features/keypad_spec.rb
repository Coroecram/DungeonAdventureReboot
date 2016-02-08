require 'keypad'
require 'stringio'

RSpec.describe Keypad do
  let(:keypad) { Keypad.new }

    describe '.initialize' do
        it 'initializes a keypad' do
            expect(keypad).to be_kind_of(Keypad)
        end
    end

    describe '#inspect' do
      it 'prompts for a password' do
        expect { keypad.inspect }.to output(intro).to_stdout
      end
    end
end

def intro
<<i
The keypad on the chest has the following buttons on it:
W  L  D  T  M
 O  R  H  Y
B  Q  E  S  U
Enter the password:
i
end
