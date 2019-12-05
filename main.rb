# frozen_string_literal: true

module Enumerable
  def my_each
    return unless block_given?
    array = self
    for i in 0...(array.length)
      yield(array[i])
    end
  end
  
  def my_each_with_index
    return unless block_given?
    array = self
    for i in 0...(array.length)
      yield(array[i], i)
    end
  end

  def my_select
    return unless block_given?
    array = self
    new_array = []
    array.my_each{|x| new_array.push(x) if yield(x)}
    return new_array
  end

  def my_all?
    array = self
    return true if !block_given?
    array.my_each{|x| return false if !yield(x)}
    return true
  end

  def my_any?
    array = self
    return true if (!(block_given?) && !(array.include? nil))
    array.my_each{|x| return true if yield(x)}
    return false
  end

  def my_none?
    array = self
    return false if !block_given?
    array.my_each{|x| return false if yield(x)}
    return true
  end
end
array = [5, 7, 6]
puts array.none? {|x| x>9}
puts array.my_none? {|x| x>9}
