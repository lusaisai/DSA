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

  def test_function
    assert_equal 120, DSA::Algorithm::factorial(5), 'factorial function is wrong'
    assert DSA::Algorithm::binary_search((1..9).to_a, 2, 0, 8), 'binary search failed'
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


  def test_insertion_sort
    original = [3,6,7,8,2,4,7,8,1,5,9,6]
    expect =   [1,2,3,4,5,6,6,7,7,8,8,9]
    DSA::Algorithm::insertion_sort!(original)
    assert_equal expect, original, 'sort failed'

    puts
    puts 'insertion sort vs built in'
    value = 10**5
    sorted_a = (0..value).to_a
    sorted_b = (0..value).to_a


    puts 'sort on already sorted'
    Benchmark.bm(20) do |x|
      x.report('insertion sort') { DSA::Algorithm::insertion_sort! sorted_a }
      x.report('built in sort') { sorted_b.sort!  }
    end


    puts 'sort on not sorted'
    value = 10**4
    not_sorted_a = value.times.map { Random.rand(value) }
    not_sorted_b = value.times.map { Random.rand(value) }
    Benchmark.bm(20) do |x|
      x.report('insertion sort') { DSA::Algorithm::insertion_sort! not_sorted_a }
      x.report('built in sort') { not_sorted_b.sort!  }
    end


  end



end