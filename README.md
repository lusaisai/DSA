# DSA

Ruby gem for basic Data Structures and Algorithms

## Installation

Add this line to your application's Gemfile:
```
    gem 'DSA'
```
And then execute:
```
    $ bundle
```
Or install it yourself as:
```
    $ gem install DSA
```
## Usage

To include the package,
```
    require 'DSA'
```

### List
A doubly linked list data structure. Use when there are lots of insertions/deletions in the middle,
otherwise, built-in array is better.
```
    l = DSA::List.new
    l.push 'some value'
    l.pop
    l.unshift 'some value'
    l.shift
    l.first
    l.last
    l.empty?
    l.length
```
General access/removal/insertion using index is supported, these operations require linear time, so use carefully.
```
    l[2]
    l.insert_at 10, 'some value'
    l.remove_at 2
```
To do lots of insertions/deletions, use the iterator, StopIteration is raised when reaching to head or tail
```
    li = l.begin_iterator # the iterator starts from the head
    puts li.next
    li.insert 'some value'
    li.remove
    li.update 'new value'

    li = l.end_iterator # the iterator starts from the tail
    li.previous
```
Enumerable is included, all those method such as 'each' are all available, since other methods are based on each,
the performance might not be the best, use only when a full traversal is inevitable.

### BinarySearchTree
An ordered map, works like a hash, but preserves an order and provides range search, implemented as a RedBlack tree.

The following three are aliases in creating a new object,
```
    rb = DSA::BinarySearchTree.new
    rb = DSA::OrderedMap.new
    rb = DSA::RedBlackTree.new
```
Method are very like a hash,
```
    rb[key] = value
    rb[key]
    rb.delete key
```
And special methods related to orders, those methods yield key/value pairs to block, if no block, enumerator is returned.
```
    rb.each # in-order traversal
    rb.gt(key) # key/value pairs for keys greater than key
    rb.ge(key)
    rb.lt(key)
    rb.le(key)
```
A help method tried to print a tree, not quite pretty, but may helps test
```
    rb.bfs_print
```
Enumerable is included, all those method such as 'each' are all available, since other methods are based on each,
the performance might not be the best, use only when a full traversal is inevitable.

### SkipList
An ordered map, storing key/value pairs, duplicate keys are allowed, value can be omitted, preserves an order and provides range search, implemented as a skip list.

```
    sl = DSA::SkipList.new
    sl.add key, value
    sl.add key # value will be nil
    sl.delete key # all those pairs with the key will be deleted
    sl.delete key, value # the pair has same key/value pair will be deleted
```

And special methods related to orders, those methods yield key/value pairs to block, if no block, enumerator is returned.
```
    sl.find key
    sl.each # in-order traversal
    sl.gt(key) # key/value pairs for keys greater than key
    sl.ge(key)
    sl.lt(key)
    sl.le(key)
```
A help method prints the skip list
```
    sl.print_me
    sl.print_me width # width, the length of evert key/value pair, default to 10
```
Enumerable is included, all those method such as 'each' are all available, since other methods are based on each,
the performance might not be the best, use only when a full traversal is inevitable.


### PriorityQueue
An array based heap, priority is a number, the smaller it is, higher priority it has
```
    pq = DSA::PriorityQueue.new
    pq.add 10, 'some job'
    pq.length
    pq.top  # look at the highest priority without removing it
    job = pq.pop # get and remove the highest priority job
```

### Stack and Queue
Implemented based on array or list.
```
    s = DSA::ArrayStack.new
    s = DSA::ListStack.new
    s.push 'some value'
    s.pop
    s.empty?
    s.top
    s.length
```
```
    q = DSA::ArrayQueue.new
    q = DSA::ListQueue.new
    q.enqueue 'some value'
    q.dequeue
    q.empty?
    q.first
    q.length
```
### Algorithm
The following functions are for demonstrations, specially sort, using built-in Array#bsearch and Array#sort instead,
they have a better performance.
```
    DSA::Algorithm::factorial(5)
    DSA::Algorithm::fibonacci(10) # There are different implementations with different performance, defaults to fibonacci_logarithm(10)
    DSA::Algorithm::fibonacci_exponential(10)
    DSA::Algorithm::fibonacci_linear(10)
    DSA::Algorithm::fibonacci_logarithm(10)
    DSA::Algorithm::fibonacci_constant(10)
    DSA::Algorithm::fibonacci_bad(10)
    DSA::Algorithm::binary_search((1..9).to_a, 2, 0, 8)
    DSA::Algorithm::insertion_sort!(array)
    DSA::Algorithm::quick_sort!(array, 0, array.length-1)
    DSA::Algorithm::radix_sort(array) # array should be integers
    DSA::Algorithm::sqrt(number)
```
