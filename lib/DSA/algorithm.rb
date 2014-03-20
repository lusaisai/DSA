module DSA
  module Algorithm

    # Factorial function, the "Hello World" program of recursion
    def self.factorial(n)
      if n == 0
        1
      else
        n * factorial(n-1)
      end
    end


    # Binary search in sorted array
    def self.binary_search(data, target, low, high)
      return false if low > high
      middle = (low + high) / 2
      if data[middle] == target
        true
      elsif target < data[middle]
        binary_search data, target, low, middle-1
      else
        binary_search data, target, middle+1, high
      end
    end

    # Insertion sort, n square worst running time, should not be used in general, built-in array sort is very good
    def self.insertion_sort!(data)
      data.length.times do |index|
        this_value = data[index]
        j = index - 1
        while j >= -1
          if data[j] > this_value && j != -1
            data[j+1] = data[j]
          else
            data[j+1] = this_value
            break
          end
          j -= 1
        end
      end
    end

    # in place quick sort
    def self.quick_sort!(data, low, high)
      return if low >= high
      pivot = data[high]
      left = low
      right = high - 1
      while left <= right
        until left > right || data[left] >= pivot
          left += 1
        end
        until left > right || data[right] <= pivot
          right -= 1
        end
        if left <= right
          data[left], data[right] = data[right], data[left]
          left += 1
          right -= 1
        end
      end
      data[left], data[high] = data[high], data[left]
      quick_sort!(data, low, left - 1)
      quick_sort!(data, left+1, high)
    end

  end
end