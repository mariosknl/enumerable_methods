require './enumerable_methods'

array.my_each { |i| puts "#{i} * 2 = #{i * 2}" }
array.my_each_with_index  { |i,y| puts "index: #{y} and value: #{i}" }
array.my_select { |i| puts i.even? }
array.my_all? { |i| puts i >= 4 }
checker.my_any? { |i| puts i.is_a? String }
array.my_none? { |i| puts i == 7 }
puts array.my_count
p checker.my_map(my_proc)
p array.my_inject { |i, j| i + j }