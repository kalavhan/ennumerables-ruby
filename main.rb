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

  def my_all?(pattern = nil)
    array = self
    if block_given?
      array.my_each{|x| return false if !yield(x)}
    elsif pattern.class == Class
      array.my_each{|x| return false if !(x.is_a? pattern)}
    elsif pattern.class == Regexp
      array.my_each{|x| return false if pattern.match? x}
    else
      array.my_each{|x| return false if x == pattern}
    end
    return true
  end

  def my_any?(pattern = nil)
    array = self
    if block_given?
      array.my_each{|x| return false if yield(x)}
    elsif pattern.class == Class
      array.my_each{|x| return true if (x.is_a? pattern)}
    elsif pattern.class == Regexp
      array.my_each{|x| return false if !(pattern.match? x)}
    else
      array.my_each{|x| return true if x == pattern}
    end
    return false
  end

  def my_none?(pattern = nil)
    array = self
    if block_given?
      array.my_each{|x| return false if yield(x)}
    elsif pattern.class == Class
      array.my_each{|x| return false if (x.is_a? pattern)}
    elsif pattern.class == Regexp
      array.my_each{|x| return false if (pattern.match? x)}
    else
      array.my_each{|x| return false if x}
    end
    return true
  end

  def my_count (pattern = nil)
    array = self
    count = 0
    if block_given?
      array.my_each{|x| count += 1 if yield(x)}
    elsif pattern != nil
      array.my_each{|x| count += 1 if pattern == x}
    else
      array.my_each{|x| count += 1}
    end
    return count
  end

  def my_map
    return to_enum if !block_given?
    new_array = []
    for i in (self)
      new_array.push(yield(i))
    end
    return new_array
  end
end
