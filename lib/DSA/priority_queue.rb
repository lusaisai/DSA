module DSA
  class PriorityQueueNode
    attr_accessor :priority, :element
    def initialize( priority, element )
      @priority = priority
      @element = element
    end
  end
  # priority queue built on top of array based heap
  class PriorityQueue
    def initialize
      @data = Array.new
    end

    def length
      @data.length
    end

    # get the value of the top without removing it
    def top
      return nil if length == 0
      @data.first.element
    end

    # priority is a number, the smaller it is, higher it has a priority
    def add(priority, element)
      @data.push PriorityQueueNode.new(priority,element)
      up_heap_bubbling length-1
    end

    # remove the top and return the element
    def pop
      value = top
      @data[0] = @data.pop # move the rightmost node to the top
      down_heap_sinking 0
      value
    end

    private
    def up_heap_bubbling(index)
      parent_index = (index - 1) / 2
      return if parent_index < 0
      if @data[index].priority < @data[parent_index].priority
        swap index, parent_index
        up_heap_bubbling parent_index
      end
    end

    def swap(index_a, index_b)
      @data[index_a], @data[index_b] = @data[index_b], @data[index_a]
    end

    def down_heap_sinking(index)
      left_child_index = 2*index + 1
      right_child_index = 2*index + 2
      small_child_index = index
      if left_child_index < length
        small_child_index = left_child_index if @data[left_child_index].priority < @data[small_child_index].priority
      end
      if right_child_index < length
        small_child_index = right_child_index if @data[right_child_index].priority < @data[small_child_index].priority
      end
      if small_child_index != index
        swap small_child_index, index
        down_heap_sinking small_child_index
      end
    end

  end
end