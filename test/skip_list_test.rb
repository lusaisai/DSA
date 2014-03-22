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
    value = 20
    value.times { sl.add Random.rand(value/3), Random.rand(value*2) }

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
    assert_equal 200, sl.delete(5, 200), 'delete failed'
    sl.print_me
    puts sl.delete 5
    sl.print_me

    value = 20
    value.times { sl.add Random.rand(value), Random.rand(value*2) }
    sl.print_me
    value.times { sl.delete Random.rand(value) }
    sl.print_me 5

    sl.each do |key, value|
      printf "(#{key}, #{value})"
    end
    puts

    e = sl.each
    loop do
      key, value = e.next
      printf "(#{key}, #{value})"
    end
    puts

    sl.gt(10) do |key, value|
      printf "(#{key}, #{value})"
    end
    puts

    e = sl.gt(10)
    loop do
      key, value = e.next
      printf "(#{key}, #{value})"
    end
    puts

    sl.ge(10) do |key, value|
      printf "(#{key}, #{value})"
    end
    puts

    e = sl.ge(10)
    loop do
      key, value = e.next
      printf "(#{key}, #{value})"
    end
    puts

    sl.lt(10) do |key, value|
      printf "(#{key}, #{value})"
    end
    puts

    e = sl.lt(10)
    loop do
      key, value = e.next
      printf "(#{key}, #{value})"
    end
    puts

    sl.le(10) do |key, value|
      printf "(#{key}, #{value})"
    end
    puts

    e = sl.le(10)
    loop do
      key, value = e.next
      printf "(#{key}, #{value})"
    end
    puts

    value = 10 ** 3
    value.times { sl.add Random.rand(value), Random.rand(value*2) }
    sl.print_me

  end
end