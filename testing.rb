module Enumerable  
  def my_each
    return to_enum(:my_each) unless block_given?
    i = 0
    array = to_a
      while i < array.length
        yield(array[i])
        i += 1
      end
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?
    i = 0
    array = to_a
      for i in i...array.length
        yield(array[i], i)
      end
  end

  def my_select(&block)
    array = []
    if block_given?
      my_each { |i| array << i if block.call }
      return array
    else
      to_enum
    end
  end

  def my_all?(args= nil, &block)
    final = true
      if block
        my_each { |i| final << yield(i) if yield(i) != 0 } and return final if block_given?
        to_enum
      end
  end

  def my_any?(args = nil, &block)
    final = false
    if block 
      my_each { |i| final = true if block.call(i)}
    elsif args.nil?
        my_each { |i| final = true if i}
    else
        my_each { |i| final = true if args === item }
    end
      final
  end

  def my_none?(args = nil, &block)
    result = true
    if block
      my_each { |i| result = false if block.call(i) }
    elsif args.nil?
      my_each { |i| result = false if i }
    else
      my_each { |i| result = false if args === i }
      to_enum
    end
    result
  end

  def my_count(args = nil, &block)
    count = 0
    if block_given?
      my_each { |item| count += 1 if block.call(item)}
    elsif args.nil?
      my_each { |item| count += 1 if item }
    else
      my_each { |item| count += 1 if args === item }
    end
    count
  end

  def my_map
    final = []
      if block_given?
      my_each { |i| final << yield(i) if yield(i) != 0 }
      return final
      else
      to_enum
      end
  end

  def my_inject(acc = nil, operator = nil)
    if !block_given?
      if operator.nil?
        operator = acc
        acc = nil
      end
      operator.to_sym
      my_each { |i| acc = acc.nil? ? i : acc.send(operator, i) }
    else
      my_each { |i| acc = acc.nil? ? i : yield(acc, i) }
    end
    acc
  end
end


array = { a: "1", b: "2", c: "3"}
array2 = (0..5)

array.my_each_with_index { |i,y| p i }

