module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?
    i = 0
      while i < self.length
        yield(self[i])
        i += 1
      end
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?
    i = 0
      for i in i...self.size
        yield(self[i], i)
      end
  end

  def my_select
    array = []
      my_each { |i| array << i if yield(i) }
      to_enum
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
      my_each { |i| final << yield(i) if yield(i) != 0 } and return final if block_given?
      to_enum
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

# Testing Section of my_methods

array = [1,2,3,4,5]
checker = ["string"]
my_proc = Proc.new { |i| i * 2 }

# array.my_each { |i| puts "#{i} * 2 = #{i * 2}" }
# 25.times { print "-"}
# puts
# array.my_each_with_index  { |i,y| puts "index: #{y} and value: #{i}" }
25.times { print "-"}
puts
# array.my_select { |i| puts i.even? }
25.times { print "-"}
puts
array.my_all? { |i| puts i >= 4 }
25.times { print "-"}
puts
checker.my_any? { |i| puts i.is_a? String }
25.times { print "-"}
puts
array.my_none? { |i| puts i == 7 }
25.times { print "-"}
puts
puts array.my_count
25.times { print "-"}
puts
puts array.my_map(&my_proc)
25.times { print "-"}
puts
p array.my_inject { |i, j| i + j }


