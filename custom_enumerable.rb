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
      while i < length - 1
        yield [self[i], i]
        i += 1
      end
    elsif is_a? Hash
      arr = to_a
      while i < length - 1
        yield [arr[i], i]
        i += 1
      end
    end
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    array = []
    my_each { |i| array << i if yield(i) }
  end

  def my_all?(arg = nil)
    arr = self.class == Range ? Array(self) : self
    condition = true
    return true if self.class != Range && empty?

    arr.my_each do |i|
      return false unless i
      return true if i && arg

      case arg
      when Class
        condition = false if i.is_a?(arg) == false
      when Regexp
        condition = false unless i & to_s&.match?(arg)
      when String || Numeric
        condition = false if arg != i
      end
      result = yield(i) if block_given?
      condition = result if block_given?
      break if condition == false
    end
    condition
  end

  def my_none?(arg = nil)
    return my_none?(arg) if block_given? && !arg.nil?

    if block_given?
      to_a.my_each { |i| return false if yield i }
    elsif arg.is_a? Regexp
      to_a.my_each { |i| return false if i.to_s.match(arg) }
    elsif arg.is_a? Class
      to_s.my_each { |i| return false if i.is_a? arg }
    elsif arg.nil?
      to_a.my_each { |i| return false if i }
    elsif arg
      to_a.my_each { |i| return false if i == arg }
    end
    true
  end

  def my_any?(arg = nil)
    return my_any?(arg) if block_given? && !arg.nil?

    if block_given?
      to_a.my_each { |i| return true if yield i }
      false
    elsif arg.is_a? Regexp
      to_a.my_each { |i| return true if i.to_s.match(arg) }
    elsif arg.is_a? Class
      to_a.my_each { |i| return true if i.is_a? i == arg }
    elsif arg
      to_a.my_each { |i| return true if i == arg }
    elsif arg.nil?
      to_a.my_each { |i| return true if i }
    end
    false
  end

  def my_count(*args)
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

  def my_inject(*args)
    arr = to_a
    raise ArgumentError, "wrong number of arguments (given #{args.length}, expected 0..2" if args.length > 2

    memo = args.length == 2 && arr.respond_to?(arg[1]) || args.length == 1 && block_given? ? arga[0] : arr.shift
    sum = if args.length == 2
            args[1]
          elsif !block_given? && args.length == 1 && arr.respond_to?(args[0])
            args[0]
          else
            false
          end
    arr.my_each { |i| memo = sum ? memo.send(sum, i) : yield(memo, i) }
    memo
  end

  def multiply_els(arr)
    arr.my_inject(:*)
  end
end
