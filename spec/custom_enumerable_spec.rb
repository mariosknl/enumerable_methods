require 'rspec'
require_relative '../custom_enumerable.rb'

RSpec.describe Enumerable do
  let(:arr) { [] }
  let(:arr2) { [1, 2, 3, 4, 5] }
  let(:arr3) { %w[ant bear cat] }
  let(:ran) { (2..5) }
  let(:boo) { [nil, false] }
  let(:prc) { proc { |i| i * 2 } }

  describe '#my_each' do
    it 'returns enumerable if no block given' do
      expect(arr.my_each).to be_a Enumerable
    end
    it 'returns array' do
      arr2.my_each { |i| arr << i }
      expect(arr).to eq [1, 2, 3, 4, 5]
    end
    it 'returns array of string' do
      arr3.my_each { |i| arr << i }
      expect(arr).to eq arr3
    end
    it 'should not return an array of the values' do
      arr3.my_each
      expect(arr).not_to eq arr3
    end
  end

  describe '#my_each_with_index' do
    it 'returns enumerable if no block given' do
      expect(arr.my_each_with_index).to be_a Enumerable
    end
    # rubocop:disable  Lint/UnusedBlockArgument
    it 'returns array' do
      arr2.my_each_with_index { |i, y| arr << i }
      expect(arr).to eq [1, 2, 3, 4, 5]
    end
    it 'returns indexes of the array' do
      arr2.my_each_with_index { |i, y| arr << y }
      expect(arr).to eq [0, 1, 2, 3, 4]
    end
  end
  # rubocop:enable  Lint/UnusedBlockArgument

  describe '#my_select' do
    it 'returns enumerable if no block given' do
      expect(arr.my_select).to be_a Enumerable
    end
    it 'return array for values that pass the test' do
      expect(arr2.my_select { |i| i < 2 }).to eq [1]
    end
  end

  describe '#my_all?' do
    it 'returns true if all elements matches the condition' do
      expect(arr2.my_all? { |i| i > 0 }).to eq true
    end
    it 'returns true if an empty array is given' do
      expect(arr.my_all?).to eq true
    end
    it 'should not return true if the array is falsy' do
      expect(boo.my_all?).not_to eq true
    end
    it 'return true if everything matches the class' do
      expect(arr3.my_all?(String)).to eq true
    end
  end

  describe '#my_any?' do
    it 'returns false if no block given' do
      expect(arr.my_any?).to eq false
    end
    it 'returns true if any value passes the test block' do
      expect(arr2.my_any? { |i| i > 2 }).to eq true
    end
    it 'should not return true for falsy array' do
      expect(boo.my_any?).not_to eq true
    end
    it 'returns true if any of the elements match the pattern' do
      expect(arr3.my_any?(/c/)).to eq true
    end
    it 'returns true if an argument is not falsy' do
      expect([false, 1].my_any?).to eq true
    end
  end

  describe '#my_none' do
    it 'returns false if all elements matches the condition' do
      expect(arr2.my_none? { |i| i > 0 }).to eq false
    end
    it 'should not return false if the array is empty' do
      expect(arr.my_none?).not_to eq false
    end
    it 'return true if the array is falsy' do
      expect(boo.my_none?).to eq true
    end
    it 'return false if everything matches the class' do
      expect(arr3.my_none?(String)).to eq false
    end
  end

  describe '#my_count' do
    it 'returns the length of the array if no block given' do
      expect(arr3.my_count).to eq 3
    end
    it 'returns the number of results that matches the condition' do
      expect(arr2.my_count { |i| i < 5 }).to eq 4
    end
  end

  describe '#my_map' do
    it 'returns to enumerator if no block given' do
      expect(arr.my_map).to be_a Enumerator
    end
    it 'returns a new array with the results of the running block' do
      expect(arr2.my_map { |i| i * i }).to eq [1, 4, 9, 16, 25]
    end
    it 'returns a new array with the results of the running Proc' do
      expect(arr2.my_map(prc)).to eq [2, 4, 6, 8, 10]
    end
  end

  describe '#my_inject' do
    it 'returns the product of the range' do
      expect(ran.my_inject { |i| i * i }).to eq 256
    end
    it 'returns the sum of the elements of the array' do
      expect(arr2.my_inject(:+)).to eq 15
    end
    it 'return the results of the array multiplied by 3' do
      expect(arr2.my_inject(3, :*)).to eq 360
    end
    it 'The result should not be an array' do
      expect(arr2.my_inject(:*).class).not_to be_a Array
    end
  end
end
