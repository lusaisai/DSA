require 'test/unit'
require 'benchmark'
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

  class DSA::List
    def print_me
      printf 'Head --> '
      each do |e|
        printf e.to_s + ' --> '
      end
      puts 'Tail'
    end
  end

  def test_list
    l = DSA::List.new
    l.push 1
    l.push 10
    l.push 20
    l.insert_at 1, 30
    assert_equal 10, l[2], '[] failed'
    assert_equal 1, l.first, 'first failed'
    assert_equal 20, l.last, 'last failed'
    l.unshift 40
    l.unshift 50
    l.unshift 60
    l.print_me
    assert_equal 20, l.pop, 'pop failed'
    l.print_me
    assert_equal 60, l.shift, 'shift failed'
    l.print_me
    assert_equal 1, l.remove_at(2), 'remove failed'
    l.print_me

    li = l.begin_iterator
    loop do
      puts li.next
    end
    li = l.end_iterator
    assert_equal 10, li.previous, 'iteration failed'
    li.insert 60
    l.print_me
    li.previous
    li.previous
    assert_equal 30, li.remove, 'remove failed'
    l.print_me

  end

  def test_performance
    value = 10**6
    a = Array.new
    b = DSA::List.new
    puts 'test construction'
    Benchmark.bm(20) do |x|
      x.report('Array') { value.times{ |i| a.push i } }
      x.report('List') { value.times{ |i| b.push i } }
    end

    puts 'test insertion'

    value = 10**3
    li = b.begin_iterator
    Benchmark.bm(20) do |x|
      x.report('Array') { value.times{ |i| a.insert(value, i) } }
      x.report('List') { value.times{ li.next }; value.times{ |i| li.insert(i) }; }
    end
  end
end