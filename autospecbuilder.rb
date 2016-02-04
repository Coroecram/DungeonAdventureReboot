require 'find'
require 'fileutils'
require 'pathname'
require 'byebug'
`rspec --init`

spec_folder = "#{Dir.getwd}/spec"

def spec_builder(basename, inspect, to_s)
  proper_name = basename.to_s[0..-4]
  class_name = proper_name.capitalize
  tests = "'require ../#{basename}'
  
RSpec.describe #{class_name} do
    describe '#inspect' do
      it 'returns the object description' do
        expect(#{class_name}.new.inspect).to eq(#{inspect})
      end
    end
    describe '#to_s' do
      it 'returns the object name' do
        expect(#{class_name}.new.to_s).to eq(#{to_s})
      end
    end
end"

  File.open("./spec/#{proper_name}_spec.rb", 'w') do |file|
    file << tests
  end
end

Pathname.new(Dir.getwd).each_child do |filename|
  if filename.basename.to_s != $0 && filename.extname == ".rb"
      each_array = []
      filename.each_line { |line| each_array << line }
      each_array.each_with_index do |line, index|
        @inspect_return = each_array[index+1].gsub("\n", "") if line =~ /inspect/
        @to_s_return = each_array[index+1].gsub("\n", "") if line =~ /to_s/
      end
      spec_builder(filename.basename, @inspect_return, @to_s_return)
  end
end
