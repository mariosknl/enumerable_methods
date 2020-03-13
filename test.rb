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

    def my_select
      return to_enum(:my_select) unless block_given?
      array = []
      my_each { |i| array << i if yield(i)}
    end

    def my_all?(arg = nil)
      condition = true
      return true if empty?

      my_each do |i|
        return false unless i
        return true if i && arg

        case arg
          when Class
            condition = false if i.is_a?(arg) == false
          when Regexp
            condition = false unless i&to_s&.match?(arg)
          when String || Numeric
            condition = false if arg != i
        end
        result = yield(i) if block_given?
        condition = result if block_given?
        break if condition == false
      end
      condition
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
      to_a.my_each { |i| mapped << yield(i)}
      mapped
    end

    def my_inject(*args)
      raise ArgumentError, "wrong number of arguments (given #{args.length}, expected 0..2" if args.length > 2
      
      acc = args.length == 2 || ((args.length == 1)) && (((args[0].is_a? String) && block_given?) || (!args[0].is_a? Symbol)) ? args[0] : nil
      
      if !args.empty? && (args[-1].class == Symbol || args[-1].class == String)
        to_a.my_each do |i|
          acc = acc.nil? ? i : acc.send(args[-1], i)
        end
        acc
      end
      to_a.my_each do |i|
        acc = acc.nil? ? i : yield(acc, i)
      end
      acc
    end
end


# array = [1,2,3,4,5]
# array2 = { :a => "marios", :b => "monkey", :c => "Teo" }
# rag = (0...5)
# array.my_each { |i| puts "#{i} * 2 = #{i * 2}" }
# puts
# array2.my_each { |key,value| puts "index :#{key} and value: #{value}" }
# puts
# rag.my_each { |i| puts "#{i} * 2 = #{i * 2}" }
# 25.times { print "-"} #line each and each_with_index
# puts
# array.my_each_with_index  { |i,y| puts "index: #{y} and value: #{i}" }
# puts
# array.each_with_index  { |i,y| p "index: #{y} and value: #{i}" }
# puts
# 25.times { print "-"}
# puts
# array.my_each_with_index  { |value,index| puts "index:#{index} and value:#{value}" }
# puts
# array.each_with_index  { |value,index| puts "index:#{index} and value:#{value}" }
# 25.times { print "-"}
# puts
# array2.my_each_with_index  { |(key, value), index| puts "#{index}: #{key} => #{value}" }
# puts
# array2.each_with_index  { |(key, value), index| puts "#{index}: #{key} => #{value}"}
# 25.times { print "-"}
# puts
# rag.my_each_with_index  { |i,y| p "index: #{y} and value: #{i}" }
# puts
# rag.each_with_index  { |i,y| p "index: #{y} and value: #{i}" }
# puts
# 25.times { print "-"}
# puts
# array.my_select { |i| p i.even?}
# puts
# array.select { |i| p i.even?}
# puts
# array2.my_select { |key,value| p value > "2"}
# puts
# array2.select { |key,value| p value > "2"}
# puts
# rag.my_select { |i| puts i }
# puts
# rag.select { |i| puts i }
# 25.times { print "-"}
# puts

array = [1,2,3,4,5]
array2 = { :a => "marios", :b => "monkey", :c => "Teo" }
rag = (0...5)
array.all? { |i| puts i < 6 }
puts
array.my_all? { |i| puts i < 6 }
puts
array2.my_all? { |key,value| p value == "Teo"}
puts
array2.all? { |key,value| p value == "Teo"}
puts
rag.my_all? { |i| puts i < 4 }
puts
rag.all? { |i| puts i < 4 }
# 25.times { print "-"}
# puts
# puts array.my_count
# puts
# puts array.count
# puts
# puts array.my_count{ |x| x%2==0 }
# puts
# puts array.count{ |x| x%2==0 }
# puts
# puts array.my_count(2)
# puts
# puts array.count(2)
# puts
# puts array2.my_count
# puts
# puts array2.count
# puts
# puts rag.my_count
# puts
# puts rag.count
# 25.times { print "-"}
# puts
# array = [1,2,4,2]
# array2 = { :a => "marios", :b => "monkey", :c => "Teo" }
# rag = (0...5)
# p array.my_map { |i| i * i}
# puts
# p array.map { |i| i * i}
# puts
# p array2.my_map { |key,value| puts "index :#{key} and value: #{value}" }
# puts
# p rag.my_map { |i| i * i}
# puts
# p rag.my_map { |i| i * i}