#!/bin/ruby
n = gets.strip.to_i
i = gets.strip
a = i.split.map(&:to_i).sort
diffs = []
(a.size-1).times do |i|
  diffs << (a[i] - a[i+1]).abs
end
puts diffs.sort.first
