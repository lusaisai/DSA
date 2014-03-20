# DSA

Ruby gem for basic Data Structures and Algorithms

## Installation

Add this line to your application's Gemfile:

    gem 'DSA'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install DSA

## Usage

To include the package,

    require 'DSA'


### List
A doubly linked list data structure. Use when there are lots of insertions/deletions in the middle,
otherwise, built-in array is better.

    l = DSA::List.new
    l.push 'some value'
    l.pop
    l.unshift 'some value'
    l.shift
    l.first
    l.last
    l.empty?
    l.length

General access/removal/insertion using index is supported, these operations require linear time, so use carefully.

    l[2]
    l.insert_at 10, 'some value'
    l.remove_at 2

To do lots of insertions/deletions, use the iterator, StopIteration is raised when reaching to head or tail

    li = l.begin_iterator # the iterator starts from the head
    puts li.next
    li.insert 'some value'
    li.remove
    li.update 'new value'

    li = l.end_iterator # the iterator starts from the tail
    li.previous

Enumerable is included, all those method such as 'each' are all available.

### BinarySearchTree
An ordered map, works like a hash, but preserves an order and provides range search, implemented as a RedBlack tree.

The following three are aliases in creating a new object,

    rb = DSA::BinarySearchTree.new
    rb = DSA::OrderedMap.new
    rb = DSA::RedBlackTree.new

Method are very like a hash,

    rb[key] = value
    rb[key]
    rb.delete key

And special methods related to orders, those methods yield key/value pairs to block, if no block, enumerator is returned.

    rb.each # in-order traversal
    rb.gt(key) # key/value pairs for keys greater than key
    rb.ge(key)
    rb.lt(key)
    rb.le(key)

A help method tried to print a tree, not quite pretty, but may helps test

    rb.bfs_print

Enumerable is included, all those method such as 'each' are all available.


### PriorityQueue
An array based heap, priority is a number, the smaller it is, higher priority it has

    pq = DSA::PriorityQueue.new
    pq.add 10, 'some job'
    pq.length
    pq.top  # look at the highest priority without removing it
    job = pq.pop # get and remove the highest priority job


### Stack and Queue
Implemented based on array or list.

    s = DSA::ArrayStack.new
    s = DSA::ListStack.new
    s.push 'some value'
    s.pop
    s.empty?
    s.top
    s.length

    q = DSA::ArrayQueue.new
    q = DSA::ListQueue.new
    q.enqueue 'some value'
    q.dequeue
    q.empty?
    q.first
    q.length

### Algorithm
The following functions are for demonstrations, specially sort, using built-in Array#bsearch and Array#sort instead,
they have a better performance.

    DSA::Algorithm::factorial(5)
    DSA::Algorithm::binary_search((1..9).to_a, 2, 0, 8)
    DSA::Algorithm::insertion_sort!(array)
    DSA::Algorithm::quick_sort!(array, 0, array.length-1)