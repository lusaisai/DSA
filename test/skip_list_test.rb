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

  def test_skip_list
    sl = DSA::SkipList.new
    value = 50
    value.times.map { sl.add Random.rand(value/3), Random.rand(value*2) }

    sl.print_me

    sl.find 5 do |key, value|
      puts "(#{key}, #{value})"
    end

    e = sl.find 5
    loop do
      key, value = e.next
      puts "(#{key}, #{value})"
    end

    sl.add 5, 100
    sl.add 5, 200
    sl.print_me
    puts 'deleting'
    assert_equal 200, sl.delete(5, 200), 'delete failed'
    sl.print_me
    puts sl.delete 5
    sl.print_me

  end
end