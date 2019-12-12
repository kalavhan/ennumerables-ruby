# frozen_string_literal: true

require './main'

describe Enumerable do
  describe '#my_each' do
    it 'returns every value of an array, values will be pushed into an empty array' do
      array = []
      [3, 4, 5].my_each { |x| array.push(x) }
      expect(array).to eql([3, 4, 5])
    end

    it 'returns an enumerator when no block is given' do
      expect([3, 4, 5].my_each).to be_an Enumerator
    end
  end

  describe '#my_each_with_index' do
    it 'returns the item and index of an array, it is placed i a hash to see if the value and index are okay' do
      hash = {}
      %w[cat dog wombat].my_each_with_index { |item, index| hash[item] = index }
      expect(hash).to eql('cat' => 0, 'dog' => 1, 'wombat' => 2)
    end

    it 'returns an enumerator if no block is given' do
      result = %w[cat dog wombat].my_each_with_index
      expect(result).to be_an Enumerator
    end
  end

  describe '#my_select' do
    it 'returns an array of the items that match the conditional' do
      expect((1..10).my_select { |i| i % 3 == 0 }).to eql([3, 6, 9])
    end

    it 'returns an array of the items that match the instance method' do
      expect([1, 2, 3, 4, 5].my_select { |num| num.even? }).to eql([2, 4])
    end

    it 'returns in an array the objects that match the condition' do
      expect(%i[foo bar].my_select { |x| x == :foo }).to eql([:foo])
    end
    it 'returns an enumerator if no block is given' do
      expect([1, 2, 3].my_select).to be_an Enumerator
    end
  end

  describe '#my_all?' do
    it 'should return true if a block is given and all elements meet the specified condition' do
      expect(%w[ant bear cat].my_all? { |word| word.length >= 3 }).to eql(true)
    end

    it 'should return false if a block is given and all elements do not meet the specified condition' do
      expect(%w[ant bear cat].my_all? { |word| word.length >= 4 }).to eql(false)
    end

    it 'should return true if all elements belong to a specified class' do
      expect([1, 2i, 3.14].my_all?(Numeric)).to eql(true)
    end

    it 'should return false if all elements do not belong to a specified class' do
      expect([1, 'String', 3.14].my_all?(Numeric)).to eql(false)
    end

    it 'should return true if all elements match a regular expression' do
      expect(%w[ant bat cat].my_all?(/t/)).to eql(true)
    end

    it 'should return false if all elements do not belong to a specified class' do
      expect(%w[ant bear cat].my_all?(/t/)).to eql(false)
    end

    it 'should return true if all elements are equal to an argument' do
      expect([1, 1, 1].my_all?(1)).to eql(true)
    end

    it 'should return false if all elements are not equal to an argument' do
      expect([1, 11, 111].my_all?(1)).to eql(false)
    end

    it 'should return true if no block is given but the array has no falsey value' do
      expect(%w[ant bear cat].my_all?).to eql(true)
    end

    it 'should return false if no block is given but the array has a falsey value' do
      expect([1, nil, 3].my_all?).to eql(false)
    end
  end

  describe '#my_any?' do
    it 'should return true if a block is given and any element meets the specified condition' do
      expect(%w[ant bear cat].my_any? { |word| word.length > 3 }).to eql(true)
    end

    it 'should return false if a block is given and no element meets the specified condition' do
      expect(%w[ant bear cat].my_any? { |word| word.length == 1 }).to eql(false)
    end

    it 'should return true if any element belongs to a specified class' do
      expect([1, nil, nil].my_any?(Numeric)).to eql(true)
    end

    it 'should return false if no element belongs to a specified class' do
      expect(%w[ant bear cat].my_any?(Numeric)).to eql(false)
    end

    it 'should return true if any element matches a regular expression' do
      expect(%w[ant bear barn].my_any?(/t/)).to eql(true)
    end

    it 'should return false if no element matches a regular expression' do
      expect(%w[song bro from].my_any?(/t/)).to eql(false)
    end

    it 'should return true if any element is equal to specified argument' do
      expect([1, 2, 3].my_any?(1)).to eql(true)
    end

    it 'should return false if no element is equal to specified argument' do
      expect([11, 11, 111].my_any?(1)).to eql(false)
    end

    it 'should return true if at least one element in the array is truthy' do
      expect([1, nil, nil].my_any?).to eql(true)
    end

    it 'should return false if all elements evaluate to falsey' do
      expect([nil, nil, nil].my_any?).to eql(false)
    end
  end

  describe '#my_none?' do
    it 'should return true if a block is given and no element meets the specified condition' do
      expect(%w[ant bear cat].my_none? { |word| word.length == 5 }).to eql(true)
    end

    it 'should return false if a block is given and an element meets the specified condition' do
      expect(%w[ant bear cat].my_none? { |word| word.length >= 4 }).to eql(false)
    end

    it 'should return true if no element belongs to a specified class' do
      expect([1, 3, 42].my_none?(Float)).to eql(true)
    end

    it 'should return false if an element belongs to a specified class' do
      expect([1, 3.14, 42].my_none?(Float)).to eql(false)
    end

    it 'should return true if no element matches a regular expression' do
      expect(%w[ant bear cat].my_none?(/f/)).to eql(true)
    end

    it 'should return false if an element matches a regular expression' do
      expect(%w[ant bear cat].my_none?(/t/)).to eql(false)
    end

    it 'should return true if no  block is given and no element of the array resolves to truthy' do
      expect([].my_none?).to eql(true)
    end

    it 'should return false if no block is given but an element resolves to truthy' do
      expect([nil, false, true].my_none?).to eql(false)
    end
  end

  describe '#my_count' do
    ary = [1, 2, 4, 2]
    it 'should return the number of elements in the array equal to the argument passed' do
      expect(ary.my_count(2)).to eql(2)
    end
    it 'should return the number of elements that resolve to true if a block is given' do
      expect(ary.my_count { |x| x.even? }).to eql(3)
    end
    it 'should return a count of all the elements in the array if neither a block nor an argument is given' do
      expect(ary.my_count).to eql(4)
    end
  end

  describe '#my_map' do
    it '' do
    end
  end

  describe '#my_inject' do
    it '' do
    end
  end
end
