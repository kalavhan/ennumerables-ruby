# frozen_string_literal: true

module Enumerable # rubocop:disable Metrics/ModuleLength
  def my_each
    return unless block_given?

    array = is_a?(Range) ? to_a : self
    i = 0
    while i < array.length
      yield(array[i])
      i += 1
    end
  end

  def my_each_with_index
    return unless block_given?

    array = is_a?(Range) ? to_a : self
    i = 0
    while i < array.length
      yield(array[i], i)
      i += 1
    end
  end

  def my_select
    return unless block_given?

    new_array = []
    my_each { |x| new_array.push(x) if yield(x) }
    new_array
  end

  def my_all?(pattern = nil) # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
    if block_given?
      my_each { |x| return false unless yield(x) }
    elsif pattern.class == Class
      my_each { |x| return false unless x.is_a? pattern }
    elsif pattern.class == Regexp
      my_each { |x| return false if pattern.match? x }
    else
      my_each { |x| return false if x == pattern }
    end
    true
  end

  def my_any?(pattern = nil) # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
    if block_given?
      my_each { |x| return true if yield(x) }
    elsif pattern.class == Class
      my_each { |x| return true if x.is_a? pattern }
    elsif pattern.class == Regexp
      my_each { |x| return false unless pattern.match? x }
    else
      my_each { |x| return true if x == pattern }
    end
    false
  end

  def my_none?(pattern = nil) # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
    if block_given?
      my_each { |x| return false if yield(x) }
    elsif pattern.class == Class
      my_each { |x| return false if x.is_a? pattern }
    elsif pattern.class == Regexp
      my_each { |x| return false if pattern.match? x }
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
    array = to_a
    if block_given?
      if initi.nil?
        res = array[0]
        array.shift
      else
        res = initi
      end
      array.my_each { |x| res = yield(res, x) }
      res
    elsif initi.class == Symbol
      res = array[0]
      array.shift
      array.my_each { |x| res = res.send(initi, x) }
      res
    elsif sym.class == Symbol
      res = initi
      array.my_each { |x| res = res.send(sym, x) }
      res
    end
  end
end

def multiply_els(array)
  array.my_inject { |sum, n| sum * n }
end
