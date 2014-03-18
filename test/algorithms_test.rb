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

end