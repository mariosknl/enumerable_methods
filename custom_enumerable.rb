# frozen_string_literal: true

# rubocop:disable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity, Style/CaseEquality

module Enumerable
  def my_each
    return to_enum unless block_given?
    i = 0
      while i < self.length
        yield(self[i])
        i += 1
      end
    end
  end

  def my_each_with_index
    return to_enum unless block_given?
    i = 0
      for i in i...self.length
        yield(self[i], i)
      end
    
  end

  def my_select
    return to_enum unless block_given?
    array = []
        self.my_each { |i| array << array[i] if yield(i) }
        end
    end
  end

  def my_all?
    return true unless block_given?
    final = true
    self.my_each { |i| true unless yield(i) }
      end
    final
      end
  end

  def my_any?
    return true unless block_given?
    result = false
    self.my_each { |i| false unless yield(i) }
      end
    result
    end
  end

  def my_none?
    return to_enum unless block_given?
    result = true
    self.my_each do |i|
      result = false if self[i] == yield(i)
        end
      end
    result
    end
  end

  def my_count
    return to_enum unless block_given?
    count = 0
    self.my_each { |item| true unless yield(item)}
    count
    end
  end

  def my_map(*)
    return to_enum unless block_given?
    final = []
    my_each do |i|
      final << yield(i) unless yield(i) == 0
      end
    end
    print final
    end
  end

  def my_inject(acc = nil, operator = nil)
    if !block_given?
      if operator.nil?
        operator = acc
      end
      operator.to_sym
      my_each { |i| acc = acc.nil? ? i : acc.send(operator, i) }
    else
      my_each { |i| acc = acc.nil? ? i : yield(acc, i) }
    end
    acc
  end
end

# Testing Sextion of the my_methods

array = [1,2,3,4,5]
# checker = ["string"]
# my_proc = Proc.new { |i| i * 2 }

array.my_each { |i| puts "#{i} * 2 = #{i * 2}" }
25.times { print "-"}
puts
array.my_each_with_index  { |i,y| puts "index: #{y} and value: #{i}" }
25.times { print "-"}
puts
# array.my_select { |i| puts i.even? }
# 25.times { print "-"}
# puts
# array.my_all? { |i| puts i >= 4 }
# 25.times { print "-"}
# puts
# checker.my_any? { |i| puts i.is_a? String }
# 25.times { print "-"}
# puts
# array.my_none? { |i| puts i == 7 }
# 25.times { print "-"}
# puts
puts array.my_count
# 25.times { print "-"}
# puts
# puts array.my_map(&my_proc)
# 25.times { print "-"}
# puts
# p array.my_inject { |i, j| i + j }

# rubocop:enable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity, Style/CaseEquality
