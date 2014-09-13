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

  def test_radix_sort
    assert_equal( 2, DSA::Algorithm::get_digit(123, 1), 'get digit failed' )
    assert_equal( 0, DSA::Algorithm::get_digit(123, 5), 'get digit failed' )
    original = [123,6,7890,88,32,254,345677,238,1,125,29,226]
    expected = [1, 6, 29, 32, 88, 123, 125, 226, 238, 254, 7890, 345677]
    assert_equal expected, DSA::Algorithm::radix_sort(original), 'sort failed'
  end

  def test_function
    assert_equal 120, DSA::Algorithm::factorial(5), 'factorial function is wrong'
    assert DSA::Algorithm::binary_search((1..9).to_a, 2, 0, 8), 'binary search failed'
    assert_equal 55, DSA::Algorithm::fibonacci(10), 'fibonacci failed'
  end

  def test_fibonacci
    assert_equal 55, DSA::Algorithm::fibonacci(10), 'fibonacci failed'
    assert_equal 55, DSA::Algorithm::fibonacci_bad(10), 'fibonacci_bad failed'
    Benchmark.bm(20) do |x|
      x.report('fibonacci iterate') { DSA::Algorithm::fibonacci(500000) }
      x.report('fibonacci recursion') { DSA::Algorithm::fibonacci_bad(500000) }
    end
  end


  def test_performance
    puts

    value = 10**7
    target = value/3
    data = (0..value).to_a
    puts 'testing performance'
    Benchmark.bm(20) do |x|
      x.report('binary search') { DSA::Algorithm::binary_search(data, target, 0, value-1) }
      x.report('linear search') { data.each do |a| break if a == target end  }
    end
  end


  def test_sort
    original = [3,6,7,8,2,4,7,8,1,5,9,6]
    expect =   [1,2,3,4,5,6,6,7,7,8,8,9]
    DSA::Algorithm::insertion_sort!(original)
    assert_equal expect, original, 'sort failed'

    original = [3,6,7,8,2,4,7,8,1,5,9,6]
    expect =   [1,2,3,4,5,6,6,7,7,8,8,9]
    DSA::Algorithm::quick_sort!(original, 0, original.length-1)
    assert_equal expect, original, 'sort failed'

  end

  def test_sort_performance
    puts 'sort on already sorted'
    puts '=' * 50
    value = 10**5
    sorted_a = (0..value).to_a
    sorted_b = sorted_a.map {|e| e}
    sorted_c = sorted_a.map {|e| e}
    assert_equal sorted_a, sorted_b, ''
    assert_equal sorted_a, sorted_c, ''
    Benchmark.bm(20) do |x|
      x.report('insertion sort') { DSA::Algorithm::insertion_sort! sorted_a }
      x.report('quick sort') { DSA::Algorithm::quick_sort! sorted_c, 0, sorted_c.length-1 }
      x.report('built in sort') { sorted_b.sort!  }
    end
    assert_equal sorted_a, sorted_b, ''
    assert_equal sorted_a, sorted_c, ''

    puts
    puts 'sort on not sorted'
    puts '=' * 50
    value = 10**4
    not_sorted_a = value.times.map { Random.rand(value) }
    not_sorted_b = not_sorted_a.map { |e| e }
    not_sorted_c = not_sorted_a.map { |e| e }
    Benchmark.bm(20) do |x|
      x.report('insertion sort') { DSA::Algorithm::insertion_sort! not_sorted_a }
      x.report('quick sort') { DSA::Algorithm::quick_sort! not_sorted_c, 0, not_sorted_c.length-1 }
      x.report('built in sort') { not_sorted_b.sort!  }
    end
    assert_equal not_sorted_a, not_sorted_b, ''
    assert_equal not_sorted_a, not_sorted_c, ''

    puts
    puts 'sort on a million not sorted'
    puts '=' * 50
    value = 10**6
    not_sorted_b = value.times.map { Random.rand(value) }
    not_sorted_c = value.times.map { Random.rand(value) }
    not_sorted_d = value.times.map { Random.rand(value) }
    Benchmark.bm(20) do |x|
      x.report('quick sort') { DSA::Algorithm::quick_sort! not_sorted_c, 0, not_sorted_c.length-1 }
      x.report('radix sort') { DSA::Algorithm::radix_sort not_sorted_d }
      x.report('built in sort') { not_sorted_b.sort!  }
    end


  end



end