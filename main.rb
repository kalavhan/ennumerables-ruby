module Enumerable
  def my_each(array)
    return unless array.is_a? Array
    for i in 0...(array.length)
      yield(array[i])
    end
  end
  
  def my_each_with_index(array)
    return unless array.is_a? Array
    for i in 0...(array.length)
      yield(array[i], i)
    end
  end
end
