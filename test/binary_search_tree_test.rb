require 'test/unit'
require 'DSA'

class MyTest < Test::Unit::TestCase

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    # Do nothing
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def teardown
    # Do nothing
  end

  def test_bst
    bst = DSA::BasicBinarySearchTree.new
    bst[50] = 'string: 50'
    bst[90] = 'string: 90'
    bst[80] = 'string: 80'
    bst[70] = 'string: 70'
    bst[25] = 'string: 25'
    bst[30] = 'string: 30'
    bst[95] = 'string: 95'
    bst.bfs_print
    assert_equal 'string: 95', bst.max, 'max failed'
    assert_equal 'string: 25', bst.min, 'min failed'
    assert_equal 'string: 80', bst[80], 'get value by key failed'
    assert_equal nil, bst[55], 'get value by key failed'
    assert_equal 'string: 80', bst.delete(80), 'delete failed'
    bst.bfs_print
    bst.delete 70
    bst.bfs_print
    bst.delete 50
    bst.bfs_print
    bst[50] = 'string: 50'

    10.times do
      key = Random.rand 200
      value = 'string: ' + key.to_s
      bst[key] = value
    end
    bst.bfs_print
    bst.each do |key, value|
      printf "<#{key}-#{value}>\t"
    end
    puts

    enum = bst.each
    loop do
      key, value = enum.next
      printf "<#{key}-#{value}>\t"
    end
    puts

    bst.gt(50) do |key, value|
      printf "<#{key}-#{value}>\t"
    end
    puts

    enum = bst.gt(50)
    loop do
      key, value = enum.next
      printf "<#{key}-#{value}>\t"
    end
    puts

    bst.ge(50) do |key, value|
      printf "<#{key}-#{value}>\t"
    end
    puts

    enum = bst.ge(50)
    loop do
      key, value = enum.next
      printf "<#{key}-#{value}>\t"
    end
    puts

    bst.lt(50) do |key, value|
      printf "<#{key}-#{value}>\t"
    end
    puts

    enum = bst.lt(50)
    loop do
      key, value = enum.next
      printf "<#{key}-#{value}>\t"
    end
    puts

    bst.le(50) do |key, value|
      printf "<#{key}-#{value}>\t"
    end
    puts

    enum = bst.le(50)
    loop do
      key, value = enum.next
      printf "<#{key}-#{value}>\t"
    end
    puts

  end


end