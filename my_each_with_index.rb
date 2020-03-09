module Enumerable
  def my_each
    i = 0
    if block_given?
      while i < self.length
        yield(self[i])
        i += 1
      end
    end
  end

  def my_select
    array = []
    self.my_each { |i| array << array[i] if yield(i) }
  end

  def my_all?
    final = true
    self.my_each { |i| false unless yield(i) }
    final
  end

  def my_any?
    result = false
    self.my_each { |i| false unless yield(i) }
    result
  end

  def my_none?
    result = true
    self.my_each do |i|
      result = false if self[i] == yield(i)
    end
    result
  end
  end

  def my_count
    count = 0
    self.my_each { count += 1 }
    count
  end

  def my_map(my_proc)
    final = []
    self.my_each { |i| final.push(my_proc != nil ? my_proc.call(i) : yield(i)) }
    final
  end

  def my_inject(sum = 0)
    self.my_each { |i| sum = yield(sum,i) }
    sum
  end
    
end

my_proc = Proc.new { |i| i.upcase }

array = [3, 6, 8, 5, 1]
checker = ["string"]

array.my_each { |i| puts "#{i} * 2 = #{i * 2}" }
array.my_select { |i| puts i.odd? }
array.my_all? { |i| puts i >= 4 }
checker.my_any? { |i| puts i.is_a? String }
array.my_none? { |i| puts i == 7 }
puts array.my_count
p checker.my_map(my_proc)
p array.my_inject { |i, j| i + j }
