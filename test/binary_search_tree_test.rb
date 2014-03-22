require 'test/unit'
require 'DSA'
require 'benchmark'

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

  def test_rb
    rb = DSA::RedBlackTree.new
    rb[100] = 'string_100'
    rb[50] = 'string_50'
    rb[1] = 'string_1'
    rb.bfs_print
    rb[120] = 'string_120'
    rb.bfs_print
    rb[150] = 'string_150'
    rb.bfs_print

    5.times do
      key = Random.rand 200
      value = "string_#{key}"
      puts "inserting #{key}"
      rb[key] = value
      rb.bfs_print
    end

    100.times do
      key = Random.rand 200
      value = "string_#{key}"
      rb[key] = value
    end
    rb.bfs_print
    rb.gt(50) do |key, value|
      printf "<#{key}-#{value}>\t"
    end
  end


  def test_rb_deletion
    rb = DSA::RedBlackTree.new
    rb[100] = 'string_100'
    rb[50] = 'string_50'
    rb[1] = 'string_1'
    rb[120] = 'string_120'
    rb[150] = 'string_150'
    rb.bfs_print
    rb.delete 100
    rb.bfs_print
    rb[20] = 'string_20'
    rb.bfs_print
    rb.delete 1
    rb.bfs_print
    rb[180] = 'string_180'
    rb[170] = 'string_170'
    rb[190] = 'string_190'

    rb.bfs_print
    assert_equal 'string_120', rb.delete(120), 'deletion failed'
    rb.bfs_print

    rb[18] = 'string_18'
    rb[174] = 'string_174'
    rb[113] = 'string_113'
    rb[92] = 'string_92'
    rb[108] = 'string_108'
    rb[193] = 'string_193'
    rb[42] = 'string_42'
    rb[35] = 'string_35'
    rb[82] = 'string_82'
    rb[31] = 'string_31'
    rb[61] = 'string_61'
    rb[37] = 'string_37'
    rb[179] = 'string_179'
    rb[23] = 'string_23'
    rb[10] = 'string_10'
    rb[1] = 'string_1'
    rb[28] = 'string_28'
    rb[187] = 'string_187'
    rb[170] = 'string_170'
    rb[77] = 'string_77'
    rb.bfs_print

    rb.delete 92

    rb[177] = 'string_177'
    rb[95] = 'string_95'
    rb[71] = 'string_71'
    rb[18] = 'string_18'
    rb[33] = 'string_33'
    rb[87] = 'string_87'
    rb[94] = 'string_94'
    rb[109] = 'string_109'
    rb.bfs_print
    rb[38] = 'string_38'
    rb[190] = 'string_190'
    rb[101] = 'string_101'
    rb[90] = 'string_90'
    rb[35] = 'string_35'
    rb[73] = 'string_73'
    rb[27] = 'string_27'
    rb[58] = 'string_58'
    rb.bfs_print
    rb[101] = 'string_101'
    rb[135] = 'string_135'
    rb.bfs_print
    rb[18] = 'string_18'
    rb[159] = 'string_159'
    rb[32] = 'string_32'
    rb[127] = 'string_127'
    rb.bfs_print
    rb[152] = 'string_152'
    rb[160] = 'string_160'
    rb.bfs_print
    rb[11] = 'string_11'
    rb[5] = 'string_5'
    rb[97] = 'string_97'
    rb[79] = 'string_79'
    rb[11] = 'string_11'
    rb[148] = 'string_148'
    rb[132] = 'string_132'
    rb.bfs_print
    rb[37] = 'string_37'
    rb[17] = 'string_17'
    rb[20] = 'string_20'
    rb[26] = 'string_26'
    rb[23] = 'string_23'
    rb.bfs_print
    rb[101] = 'string_101'
    rb.bfs_print
    rb[172] = 'string_172'
    rb[192] = 'string_192'
    rb[193] = 'string_193'
    rb[131] = 'string_131'
    rb[150] = 'string_150'
    rb[151] = 'string_151'
    rb[130] = 'string_130'
    rb[119] = 'string_119'
    rb[110] = 'string_110'
    rb[26] = 'string_26'
    rb[31] = 'string_31'
    rb[110] = 'string_110'
    rb[63] = 'string_63'

    rb.bfs_print
    rb.delete 87
    rb.bfs_print

    200.times do
      key = Random.rand 200
      value = "string_#{key}"
      puts "rb[#{key}] = '#{value}'"
      rb[key] = value
    end

    100.times do
      key = Random.rand 200
      puts "deleting #{key}"
      rb.delete key
      rb.bfs_print
    end

    rb.each do |key, value|
      printf "<#{key}-#{value}>\t"
    end

  end

  def test_performance
    puts
    rb = DSA::RedBlackTree.new
    sl = DSA::SkipList.new
    hash = Hash.new
    value = 10**5
    Benchmark.bm(20) do |x|
      x.report('RedBlack') { value.times { rb[Random.rand(value)] = 'whatever' } }
      x.report('RedBlack Find') { value.times { rb[Random.rand(value)] } }
      x.report('RedBlack Find gt') { value.times { rb.gt(Random.rand(value)) } }
      x.report('RedBlack Deletion') { (value/2).times { rb.delete Random.rand(value) } }
      x.report('SkipList') { value.times { sl.add Random.rand(value), 'whatever' } }
      x.report('SkipList Find') { value.times { sl.find Random.rand(value) } }
      x.report('SkipList Find gt') { value.times { sl.gt Random.rand(value) } }
      x.report('SkipList Deletion') { (value/2).times { sl.delete Random.rand(value) } }
      x.report('Built-In Hash') { value.times { hash[Random.rand(value)] = 'whatever' } }
      x.report('Built-In Hash Find') { value.times { hash[Random.rand(value)] } }
      x.report('Built-In Hash Deletion') { (value/2).times { hash.delete Random.rand(value) } }
    end
  end


end