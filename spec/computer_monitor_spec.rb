require 'computer_monitor'

RSpec.describe ComputerMonitor do
  let(:monitor) { ComputerMonitor.new }


    describe '#inspect' do
      it 'returns the monitor description' do
        expect(monitor.inspect).to eq("A computer monitor on top of the computer. It is too dusty to read")
      end
    end

    describe '#to_s' do
      it 'returns the monitor string' do
        expect(monitor.to_s).to eq("a monitor")
      end
    end
end
