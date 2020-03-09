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

  def my_each_with_index
    i = 0
    for i in i...self.length
      yield(self[i], i)
  end

  def my_select
    array = []
    self.my_each { |i| array << array[i] if yield(i) }
    end
  end

  

  def my_all?
    final = true
    self.my_each { |i| true unless yield(i) }
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

  def my_count
    count = 0
    self.my_each { |i| count += 1 }
    count
  end

end
  



array = [1,2,3,4,5]
checker = ["string"]
my_proc = Proc.new { |i| i.upcase}


array.my_each { |i| puts "#{i} * 2 = #{i * 2}" }
25.times { print "-"}
puts
array.my_each_with_index  { |i,y| puts "index: #{y} and value: #{i}" }
25.times { print "-"}
puts
array.my_select { |i| puts i.even? }
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
