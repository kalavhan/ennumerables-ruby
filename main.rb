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
    if !block_given?
      return true
    end
    if array.length == 0
      return true
    end
    array.my_each{|x| return false if !yield(x)}
    return true
  end
end
