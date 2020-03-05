module Enumerable
    def my_each
        i = 0
        while i < self.length 
            yield(self[i])
            i += 1
        end
    end
end

arr = [1,2,3]
arr.my_each do 
    return 10
end