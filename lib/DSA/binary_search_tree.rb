module DSA
  # A basic binary search tree node
  class BasicBinarySearchTreeNode
    attr_accessor :key, :value, :parent, :left, :right
    def initialize(key, value)
      @key = key
      @value = value
      @parent = nil
      @left = nil
      @right = nil
    end
  end
  # A basic binary search tree(or ordered map), with no specific self balancing
  class BasicBinarySearchTree
    include Enumerable

    def initialize
      @root = nil
    end

    def []=(key, value)
      new_node = BasicBinarySearchTreeNode.new(key, value)
      if @root.nil?
        @root = new_node
      else
        insert(@root, new_node)
      end
    end

    def delete(key)
      return nil if @root.nil?
      node = find_node @root, key
      return nil if node.nil?
      delete_node node
    end

    def [](key)
      return nil if @root.nil?
      node = find_node @root, key
      if node
        node.value
      else
        nil
      end
    end

    # yield the key/value pair for all those great than input key
    def gt(key)
      return nil if @root.nil?

      if block_given?
        node = find_gt_node @root, key
        if node
          yield [node.key, node.value]
          loop do
            node = in_order_next_node node
            if node
              yield [node.key, node.value]
            else
              break
            end
          end
        end
      else
        Enumerator.new do |y|
          gt(key) do |key, value|
            y << [key, value]
          end
        end
      end


    end

    # yield the key/value pair for all those less than input key
    def lt(key)
      return nil if @root.nil?

      if block_given?
        node = find_lt_node @root, key
        if node
          yield [node.key, node.value]
          loop do
            node = in_order_prev_node node
            if node
              yield [node.key, node.value]
            else
              break
            end
          end
        end
      else
        Enumerator.new do |y|
          lt(key) do |key, value|
            y << [key, value]
          end
        end
      end
    end

    # yield the key/value pair for all those great than or equal to input key
    def ge(key)
      return nil if @root.nil?

      if block_given?
        node = find_node @root, key
        yield [node.key, node.value] if node
        node = find_gt_node @root, key
        if node
          yield [node.key, node.value]
          loop do
            node = in_order_next_node node
            if node
              yield [node.key, node.value]
            else
              break
            end
          end
        end
      else
        Enumerator.new do |y|
          ge(key) do |key, value|
            y << [key, value]
          end
        end
      end
    end

    # yield the key/value pair for all those great than or equal to input key
    def le(key)
      return nil if @root.nil?

      if block_given?
        node = find_node @root, key
        yield [node.key, node.value] if node
        node = find_lt_node @root, key
        if node
          yield [node.key, node.value]
          loop do
            node = in_order_prev_node node
            if node
              yield [node.key, node.value]
            else
              break
            end
          end
        end
      else
        Enumerator.new do |y|
          le(key) do |key, value|
            y << [key, value]
          end
        end
      end

    end


    def each(&block)
      return if @root.nil?
      if block.nil?
        Enumerator.new do |y|
          each do |key, value|
            y << [key, value]
          end
        end
      else
        in_order_traversal @root, block
      end
    end

    def min
      if @root.nil?
        nil
      else
        min_node(@root).value
      end
    end

    def max
      if @root.nil?
        nil
      else
        max_node(@root).value
      end
    end

    # breadth first traversal
    def bfs_print
      puts '=' * 100
      level = [@root]
      until level.empty?
        next_level = []
        level.each do |node|
          if node
            printf "<#{node.key}, #{node.value}>"
            printf "(parent_is_#{node.parent.key})\t" if node != @root
            next_level.push node.left
            next_level.push node.right
          else
            printf "<Nil>\t"
            next_level.push nil
            next_level.push nil
          end
        end
        puts
        if next_level.count(nil) < next_level.length
          level = next_level
        else
          level = []
        end
      end
      puts '=' * 100
    end

    protected
    def in_order_next_node(node)
      # if it has a right subtree, take the left most of right subtree
      if !node.right.nil?
        return min_node node.right

      # if it is a left child, take the parent
      # if it is a right child, go up till we find a left child's parent, otherwise finished
      else
        while !node.nil?
          return node.parent if left_child? node
          node = node.parent
        end
      end

      nil
    end

    def in_order_prev_node(node)
      # if it has a left subtree, take the right most of left subtree
      if !node.left.nil?
        return max_node node.left

      # if it is a right child, take the parent
      # if it is a left child, go up till we find a right child's parent, otherwise finished
      else
        while !node.nil?
          return node.parent if right_child? node
          node = node.parent
        end
      end

      nil
    end

    def left_child?(node)
      parent = node.parent
      if parent
        parent.left == node
      else
        false
      end
    end

    def right_child?(node)
      parent = node.parent
      if parent
        parent.right == node
      else
        false
      end
    end


    # in-order traversal
    def in_order_traversal(node, block)
      unless node.left.nil?
        in_order_traversal(node.left, block)
      end
      block.call(node.key, node.value)
      unless node.right.nil?
        in_order_traversal(node.right, block)
      end
    end

    def delete_node(node)
      if node.left.nil? && node.right.nil? # it's a leaf
        replace node, nil
      elsif ! node.left.nil? && node.right.nil? # only has a left child
        replace node, node.left
      elsif node.left.nil? && ! node.right.nil? # only has a right child
        replace node, node.right
      else # has both children
        next_node = min_node node.right
        node.key = next_node.key
        node.value = next_node.value
        delete_node next_node
      end
      node.value
    end

    # replace a node with another node, this includes the links that node has
    def replace(node, new_node)
      if node == @root
        @root = new_node
      else
        parent = node.parent
        if parent.left == node
          parent.left = new_node
        else
          parent.right = new_node
        end
        new_node.parent = parent unless new_node.nil?
      end
    end


    # find the minimum node of a subtree
    def min_node(node)
      if node.left.nil?
        node
      else
        min_node node.left
      end
    end

    # find the maximum node of a subtree
    def max_node(node)
      if node.right.nil?
        node
      else
        max_node node.right
      end
    end

    # find a node through a key in a subtree
    def find_node(node, key)
      if node.key == key
        node
      elsif key < node.key
        if node.left
          find_node node.left, key
        else
          nil
        end
      else
        if node.right
          find_node node.right, key
        else
          nil
        end
      end

    end

    # find first node that is greater than the key in a subtree
    def find_gt_node(node, key)
      if key == node.key
        in_order_next_node node
      elsif key < node.key
        if node.left
          find_gt_node node.left, key
        else
          node
        end
      else
        if node.right
          find_gt_node node.right, key
        else
          in_order_next_node node
        end
      end

    end

    # find first node that is less than the key in a subtree
    def find_lt_node(node, key)
      if key == node.key
        in_order_prev_node node
      elsif key < node.key
        if node.left
          find_lt_node node.left, key
        else
          in_order_prev_node node
        end
      else
        if node.right
          find_lt_node node.right, key
        else
          node
        end
      end

    end

    # insert a new node into the binary search (sub)tree
    def insert(node, new_node)
      if node.key == new_node.key
        node.value = new_node.value
      elsif new_node.key < node.key
        if node.left.nil?
          node.left = new_node
          new_node.parent = node
        else
          insert( node.left, new_node )
        end
      else
        if node.right.nil?
          node.right = new_node
          new_node.parent = node
        else
          insert( node.right, new_node )
        end
      end
    end


  end
end