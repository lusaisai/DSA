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

  def test_stack
    s = DSA::ArrayStack.new
    s.push 1
    s.push 2
    assert_equal 2, s.pop, 'failed pop'
    assert_equal false, s.empty?, 'failed empty?'
    assert_equal 1, s.top, 'failed top'
    assert_equal 1, s.length, 'failed length'

    s = DSA::ListStack.new
    s.push 1
    s.push 2
    assert_equal 2, s.pop, 'failed pop'
    assert_equal false, s.empty?, 'failed empty?'
    assert_equal 1, s.top, 'failed top'
    assert_equal 1, s.length, 'failed length'
  end

  class DSA::ArrayQueue
    def print_me
      print @data.join(' --> ')
      puts
    end
  end

  class DSA::ListQueue
    def print_me
      printf 'Head --> '
      @data.each do |e|
        printf e.to_s + ' --> '
      end
      puts 'Tail'
    end
  end

  def test_queue
    puts
    q = DSA::ArrayQueue.new
    q.print_me
    assert_equal true, q.empty?, 'failed empty?'
    q.enqueue 1
    q.enqueue 2
    q.enqueue 3
    assert_equal 3, q.length, 'failed length'
    q.print_me
    q.dequeue
    q.dequeue
    assert_equal 3, q.first, 'failed first'
    q.print_me
    25.times { |i| q.enqueue i }
    q.print_me
    10.times { q.dequeue }
    q.print_me
    assert_equal 9, q.first, 'failed first'
    assert_equal 16, q.length, 'failed length'


    puts
    q = DSA::ListQueue.new
    q.print_me
    assert_equal true, q.empty?, 'failed empty?'
    q.enqueue 1
    q.enqueue 2
    q.enqueue 3
    assert_equal 3, q.length, 'failed length'
    q.print_me
    q.dequeue
    q.dequeue
    assert_equal 3, q.first, 'failed first'
    q.print_me
    25.times { |i| q.enqueue i }
    q.print_me
    10.times { q.dequeue }
    q.print_me
    assert_equal 9, q.first, 'failed first'
    assert_equal 16, q.length, 'failed length'
  end
end