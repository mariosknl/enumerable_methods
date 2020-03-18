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
    if is_a? Array
      while i < length
        yield [self[i], i]
        i += 1
      end
    elsif is_a? Hash
      arr = to_a
      while i < length
        yield [arr[i], i]
        i += 1
      end
    end
  end

  def my_select(*)
    return to_enum(:my_select) unless block_given?

    array = []
    my_each { |i| p array << i if yield(i) }
  end

  def my_all?(arg = nil) # rubocop:disable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity
    return to_enum(:my_select) unless block_given?

    arr = to_a
    return true if arr.empty?

    case arg
    when block_given?
      to_a.my_each { |i| return false unless yield(i) }
    when arg.nil?
      to_a.my_each { |i| return false unless i }
    when arg.is_a?(Class)
      to_a.my_each { |i| return false unless i.is_a? arg }
    when arg.is_a?(Regexp)
      to_a.my_each { |i| return false unless i.to_s.match(arg) }
    else
      to_a.my_each { |i| return false unless i == arg }
    end
    true
  end

  def my_any?(arg = nil, &block) # rubocop:disable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity
    return my_any?(arg) if block_given? && !arg.nil?

    if block_given?
      to_a.my_each { |i| return true if block.call(i) }
      false
    elsif arg.is_a? Class
      to_a.my_each { |i| return true if i.is_a? arg }
    elsif arg.is_a? Regexp
      to_a.my_each { |i| return true if i.to_s.match(arg) }
    elsif arg
      to_a.my_each { |i| return true if i == arg }
    elsif arg.nil?
      to_a.my_each { |i| return true if i }
    end
    false
  end

  def my_none?(_arg = nil, &block)
    !my_any?(_arg = nil, &block)
  end

  def my_count(*args) # rubocop:disable Metrics/CyclomaticComplexity
    return to_a.length if !block_given? && args.empty?

    count = 0
    to_a.my_each { |i| count += 1 if i == args[0] } unless args.empty?
    to_a.my_each { |i, y| count += 1 if yield(i, y) } if block_given?
    count
  end

  def my_map
    return to_enum(:my_map) unless block_given?

    mapped = []
    to_a.my_each { |i| mapped << yield(i) }
    mapped
  end

  def my_inject(*value) # rubocop:disable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity
    raise ArgumentError, "wrong number of argumets (given #{value.length}, expected 0..2" if value.length > 2

    memo = value.length == 2 || ((value.length == 1) && (((value[0].is_a? String) && block_given?) || (!value[0].is_a? Symbol))) ? value[0] : nil # rubocop:disable Style/LineLength
    if !value.empty? && (value[-1].class == Symbol || value[-1].class == String)
      to_a.my_each do |x|
        memo = memo.nil? ? x : memo.send(value[-1], x)
      end
      return memo
    end
    to_a.my_each do |x|
      memo = memo.nil? ? x : yield(memo, x)
    end
    memo
  end

  def multiply_els(arr)
    arr.my_inject(:*)
  end
end
