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

    # fibonacci numbers
    def self.fibonacci(n)
      if !n.is_a? Integer or n < 0
        raise ArgumentError
      end

      if n == 0
        0
      elsif n == 1
        1
      elsif n >= 2
        a = 0
        b = 1
        2.upto(n) {
          b, a = a + b, b
        }
        b
      end
    end

    # we could implement fibonacci using recursion which looks simple, unfortunately, the running time of this algorithm
    # itself is a fibonacci sequence, which grows fast, kind of exponential
    def self.fibonacci_bad(n)
      if !n.is_a? Integer or n < 0
        raise ArgumentError
      end

      if n == 0
        0
      elsif n == 1
        1
      elsif n >= 2
        fibonacci(n-1) + fibonacci(n-2)
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
      pivot = data[Random.rand(low..high)]
      left = low
      right = high
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
      quick_sort!(data, low, right)
      quick_sort!(data, left, high)
    end

    # radix sort, in base 10
    def self.radix_sort(data)
      goto_next_digit = true
      position = 0
      while goto_next_digit
        goto_next_digit = false
        buckets = []
        10.times { buckets << [] }
        data.each do |number|
          digit = get_digit(number, position)
          goto_next_digit = true if digit > 0 # if all digits are zero, loop will end
          buckets[digit] << number
        end
        data = buckets.flatten!
        position += 1
      end
      data
    end

    def self.get_digit(number, position)
      number % (10 ** (position+1)) / (10 ** position)
    end

  end
end