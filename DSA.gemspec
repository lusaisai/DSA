# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'DSA/version'

Gem::Specification.new do |spec|
  spec.name          = "DSA"
  spec.version       = DSA::VERSION
  spec.authors       = ["lusaisai"]
  spec.email         = ["lusaisai@163.com"]
  spec.summary       = %q{Data Structures and Algorithms in Ruby}
  spec.description   = %q{List, BinarySearchTree(RedBlackTree), SkipList, PriorityQueue, (Array/List)Stack and Queue}
  spec.homepage      = "https://github.com/lusaisai/DSA"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end

