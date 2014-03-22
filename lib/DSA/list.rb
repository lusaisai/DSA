module DSA
  # Exception
  class ListIndexError < StandardError
  end
  class ListRemovalError < StandardError
  end

  # Node
  class ListNode
    attr_accessor :element, :prev, :next
    def initialize(e)
      @element = e
      @prev = nil
      @next = nil
    end
  end

  # ListIterator provides iteration on the list and constant time insertion and removal
  class ListIterator
    def initialize(node, list)
      @node = node
      @list = list
    end

    def next
      @node = @node.next
      raise StopIteration if @node == @list.tail || !@node
      @node.element
    end

    def previous
      @node = @node.prev
      raise StopIteration if @node == @list.head || !@node
      @node.element
    end

    def insert(e)
      @list.insert_node_between @node.prev, @node, ListNode.new(e)
    end

    def remove
      node = @list.remove_node(@node)
      node.element
    end

    def update(e)
      @node.element = e
    end


  end

  # doubly linked list
  class List
    attr_reader :length
    attr_reader :head, :tail # head and tail are two empty guards
    include Enumerable

    def initialize
      @head = ListNode.new nil
      @tail = ListNode.new nil
      @head.next = @tail
      @tail.prev = @head
      @length = 0
    end

    def push(e)
      insert_node_between @tail.prev, @tail, ListNode.new(e)
    end

    def pop
      node = remove_node @tail.prev
      node.element
    end

    def unshift(e)
      insert_node_between @head, @head.next, ListNode.new(e)
    end

    def shift
      node = remove_node @head.next
      node.element
    end

    def first
      self[0]
    end

    def last
      self[@length-1]
    end

    def empty?
      @length == 0
    end

    # insert an element at position index(0 based), linear time cost, use with caution, iterator preferred
    def insert_at(index, e)
      push e if index > @length - 1
      node = get_node index
      insert_node_between node.prev, node, ListNode.new(e)
    end

    # remove an element at position index(0 based), linear time cost, use with caution, iterator preferred
    def remove_at(index)
      node = get_node index
      remove_node node
      node.element
    end

    # access an element at position index(0 based), linear time cost, use with caution
    def [](index)
      get_node(index).element
    end

    def each
      node = @head.next
      while 1
        break if node == @tail
        yield node.element
        node = node.next
      end
    end

    # an iterator starting from head
    def begin_iterator
      ListIterator.new @head, self
    end

    # an iterator starting from end
    def end_iterator
      ListIterator.new @tail, self
    end

    # the following methods are used to process nodes, user usually does not need to use them
    # insert node between two nodes
    def insert_node_between(a, b, new_one)
      a.next = new_one
      new_one.prev = a
      new_one.next = b
      b.prev = new_one
      @length += 1
    end

    # remove a node
    def remove_node(node)
      raise( ListRemovalError, 'List is empty' ) if @length == 0
      before = node.prev
      after = node.next
      before.next = after
      after.prev = before
      @length -= 1
      node
    end

    private
    def get_node(index)
      index += @length if index < 0
      raise(ListIndexError, 'Index out of bound: ' + index.to_s) if index > @length - 1 || index < 0
      if index > @length / 2
        node = @tail.prev
        current_index = @length - 1
        while 1
          return node if index == current_index
          node = node.prev
          current_index -= 1
        end
      else
        node = @head.next
        current_index = 0
        while 1
          return node if index == current_index
          node = node.next
          current_index += 1
        end
      end
    end
  end




end