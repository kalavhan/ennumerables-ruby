# frozen_string_literal: true

module Enumerable
  def my_each
    return to_enum unless block_given?

    array = is_a?(Range) ? to_a : self
    i = 0
    while i < array.length
      yield(array[i])
      i += 1
    end
  end

  def my_each_with_index
    return to_enum unless block_given?

    array = is_a?(Range) ? to_a : self
    i = 0
    while i < array.length
      yield(array[i], i)
      i += 1
    end
  end

  def my_select
    return to_enum unless block_given?

    new_array = []
    my_each { |x| new_array.push(x) if yield(x) }
    new_array
  end

  def my_all?(pattern = nil)
    if block_given?
      my_each { |x| return false unless yield(x) }
    elsif pattern.class == Class
      my_each { |x| return false unless x.is_a? pattern }
    elsif pattern.class == Regexp
      my_each { |x| return false unless x.match? pattern }
    elsif !pattern.nil?
      my_each { |x| return false unless x == pattern }
    else
      my_each { |x| return false unless x }
    end
    true
  end

  def my_any?(pattern = nil)
    if block_given?
      my_each { |x| return true if yield(x) }
    elsif pattern.class == Class
      my_each { |x| return true if x.is_a? pattern }
    elsif pattern.class == Regexp
      my_each { |x| return true if x.match? pattern }
    elsif !pattern.nil?
      my_each { |x| return true if x == pattern }
    else
      my_each { |x| return true if x }
    end
    false
  end

  def my_none?(pattern = nil)
    if block_given?
      my_each { |x| return false if yield(x) }
    elsif pattern.class == Class
      my_each { |x| return false if x.is_a? pattern }
    elsif pattern.class == Regexp
      my_each { |x| return false if x.match? pattern }
    elsif !pattern.nil?
      my_each { |x| return false if x == pattern}
    else
      my_each { |x| return false if x }
    end
    true
  end

  def my_count(pattern = nil)
    count = 0
    if block_given?
      my_each { |x| count += 1 if yield(x) }
    elsif !pattern.nil?
      my_each { |x| count += 1 if pattern == x }
    else
      my_each { count += 1 }
    end
    count
  end

  def my_map(n_proc = nil)
    new_array = []
    if !n_proc.nil?
      my_each { |x| new_array.push(n_proc.call(x)) }
      return new_array
    elsif block_given?
      my_each { |x| new_array.push(yield(x)) }
      return new_array
    end
    to_enum
  end

  def my_inject(initi = nil, sym = nil)
    array_n = to_a
    if block_given?
      res = initi
      if initi.nil?
        res = array_n[0]
        array_n = array_n[1..-1]
      end
      array_n.my_each { |x| res = yield(res, x) }
      res
    elsif initi.class == Symbol
      res = array_n[0]
      array_n[1..-1].my_each { |x| res = res.send(initi, x) }
      res
    elsif sym.class == Symbol
      res = initi
      array_n.my_each { |x| res = res.send(sym, x) }
      res
    end
  end
end

def multiply_els(array)
  array.my_inject { |sum, n| sum * n }
end
