require_relative 'list'

module DSA
  # The stack data structure
  # Delegate the job to ruby Array, no need to worry about its growing and shrinking.
  class ArrayStack
    def initialize
      @data = Array.new
    end

    def push(e)
      @data.push e
    end

    def pop
      @data.pop
    end

    def top
      @data.last
    end

    def empty?
      @data.empty?
    end

    def length
      @data.length
    end

  end

  # Stack built on top of list
  class ListStack
    def initialize
      @data = DSA::List.new
    end

    def push(e)
      @data.push e
    end

    def pop
      @data.pop
    end

    def top
      @data.last
    end

    def empty?
      @data.empty?
    end

    def length
      @data.length
    end

  end

  # Typically, array is not a good idea to implement a queue, as it requires linear time to shift other elements after dequeue
  # We can try to avoid the shifting by keep track of the index of the front queue element and make the array circular
  class ArrayQueue
    attr_reader :length

    def initialize(initial_capacity = 10)
      @data = Array.new initial_capacity
      @front_index = 0
      @length = 0
    end

    def enqueue(e)
      grow if @length+1 == capacity
      @length += 1
      index = (@front_index + @length - 1 ) % capacity
      @data[index] = e
    end

    def dequeue
      shrink if @length - 1 < capacity / 2 and capacity / 2 >= 10
      return nil if @length == 0
      next_front = (@front_index + 1 ) % capacity
      value = @data[@front_index]
      @data[@front_index] = nil
      @front_index = next_front
      @length -= 1
      value
    end

    def first
      @data[@front_index]
    end

    def empty?
      @length == 0
    end

    private
    def capacity
      @data.length
    end

    def grow
      new_data = Array.new capacity * 2
      copy_to new_data
    end

    def shrink
      new_data = Array.new capacity / 2
      copy_to new_data
    end

    def copy_to(new_data)
      (0..@length-1).each do |i|
        old_index = (@front_index + i) % capacity
        new_data[i] = @data[old_index]
      end
      @data = new_data
      @front_index = 0
    end

  end

  # FIFO queue built on top of linked list
  class ListQueue
    def initialize
      @data = DSA::List.new
    end

    def enqueue(e)
      @data.push e
    end

    def dequeue
      @data.shift
    end

    def first
      @data.first
    end

    def empty?
      @data.empty?
    end

    def length
      @data.length
    end
  end

end