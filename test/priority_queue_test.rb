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

  class DSA::PriorityQueue
    def print_me
      printf 'Start --> '
      @data.each do |e|
        printf e.element.to_s + ' --> '
      end
      puts 'End'
    end
  end

  def test_priority_queue
    pq = DSA::PriorityQueue.new
    10.times do
      number = Random.rand(50..100)
      pq.add( number, 'job:'+number.to_s )
    end
    pq.print_me
    pq.add 10, 'job:10'
    pq.add 20, 'job:20'
    assert_equal 'job:10', pq.top
    pq.print_me
    assert_equal 'job:10', pq.pop
    pq.print_me
    pq.pop
    pq.print_me
    pq.pop
    pq.print_me
    pq.pop
    pq.print_me
  end
end