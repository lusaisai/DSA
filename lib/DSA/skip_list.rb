module DSA
  class SkipListNode
    attr_accessor :key, :value, :prev, :next, :up, :down
    def initialize(key, value = nil)
      @key = key
      @value = value
      @prev = nil
      @next = nil
      @up = nil
      @down = nil
    end

    def is_sentinel?
      @key.equal? SkipListLevel::SENTINEL
    end
  end

  class SkipListLevel
    attr_accessor :head, :tail
    SENTINEL = Object.new
    def initialize
      @head = SkipListNode.new(SENTINEL, 'Sentinel')
      @tail = SkipListNode.new(SENTINEL, 'Sentinel')
      @head.next = @tail
      @tail.prev = @head
    end
  end

  class SkipList
    attr_reader :length, :height
    def initialize
      @levels = [SkipListLevel.new]
      @length = 0
      @height = 0
    end

    def find(key)
      nodes = find_nodes key

      if block_given?
        nodes.each do |node|
          yield [node.key, node.value]
        end
      else
        Enumerator.new do |y|
          find(key) do |key, value|
            y << [key, value]
          end
        end
      end

    end


    # if value provided, the nodes have the same key/value pairs will be deleted,
    # otherwise, all nodes have the same key are deleted
    # return the value of last deleted node
    def delete(key, value = nil)
      nodes = find_nodes(key)
      return_value = false

      nodes.each do |node|
        return_value = remove_tower node if !value || value == node.value
      end

      return_value
    end

    def add(key, value = nil)
      potential_place = []
      walk = start_node
      while 1
        if walk.next.is_sentinel? || key <= walk.next.key
          if walk.down
            potential_place.push walk
            walk = walk.down
            next
          else
            insert_node_between walk, walk.next, SkipListNode.new(key, value)
            @length += 1
            build_tower walk.next, potential_place, key, value
            break
          end
        else
          walk = walk.next
          next
        end
      end
    end

    def print_me(width = 5)
      rec = Hash.new
      walk = @levels.first.head
      i = 0
      j = 0
      walk = walk.next
      while ! walk.is_sentinel?
        rec[ [i, j] ] = "#{walk.key},#{walk.value}"
        up_walk = walk
        while up_walk.up
          up_walk = up_walk.up
          j += 1
          rec[ [i, j] ] ="#{up_walk.key},#{up_walk.value}"
        end
        walk = walk.next
        i += 1
        j = 0
      end

      # print
      puts '=' * 100
      (height+1).times.reverse_each do |j|
        printf 'Sentinel--'
        (length).times do |i|
          if rec[ [i, j] ]
            printf ">%#{width+2}s", "#{rec[ [i, j] ]}--"
          else
            printf '-' + '-' * width + '--'
          end
        end
        puts '>Sentinel'
      end
      puts '=' * 100
    end

    private
    def find_nodes(key)
      walk = start_node
      while 1
        if !walk.is_sentinel? && key == walk.key
          break
        elsif walk.next.is_sentinel? || key < walk.next.key
          if walk.down
            walk = walk.down
            next
          else
            return nil
          end
        else
          walk = walk.next
          next
        end
      end

      nodes = []
      while !walk.is_sentinel? && walk.down
        walk = walk.down
      end

      nodes.push walk

      # to find the duplicates
      other_node = walk.next
      while !other_node.is_sentinel? && other_node.key == key
        nodes.push other_node
        other_node = other_node.next
      end

      other_node = walk.prev
      while !other_node.is_sentinel? && other_node.key == key
        nodes.push other_node
        other_node = other_node.prev
      end

      nodes
    end

    def remove_tower(base)
      remove_node base
      remove_tower base.up if base.up
      base.value
    end

    def build_tower(base, tower, key, value)
      up_stair_previous = nil
      tower.reverse_each do |node|
        return unless go_up?
        up_stair_previous = node
        new_node = SkipListNode.new(key, value)
        insert_node_between up_stair_previous, up_stair_previous.next, new_node
        vertical_link_node new_node, base
        base = new_node
      end
      # add new level
      if go_up?
        add_level
        @height += 1
      end

    end

    def add_level
      new_level = SkipListLevel.new
      vertical_link_node  new_level.head, @levels.last.head
      vertical_link_node  new_level.tail, @levels.last.tail
      @levels.push new_level
    end

    def vertical_link_node(above, below)
      above.down = below
      below.up = above
    end

    def go_up?
      [true, false].sample
    end

    def insert_node_between(a, b, new_one)
      a.next = new_one
      new_one.prev = a
      new_one.next = b
      b.prev = new_one
    end

    # remove a node
    def remove_node(node)
      before = node.prev
      after = node.next
      before.next = after
      after.prev = before
      node
    end

    def start_node
      @levels.last.head
    end

    def end_node
      @levels.first.tail
    end


  end
end