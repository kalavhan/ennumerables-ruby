module Enumerable
  def my_each(array)
    return unless array.is_a? Array
    for i in 0...(array.length)
      yield(array[i])
      puts i
    end
  end
end

