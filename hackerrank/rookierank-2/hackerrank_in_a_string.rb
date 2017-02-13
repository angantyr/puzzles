#!/bin/ruby

target = 'hackerrank'
pattern = target.chars.map {|c| '(['+c+']).*' }.join
regex = Regexp.new(pattern)

q = gets.strip.to_i
for a0 in (0..q-1)
  s = gets.strip
  puts s.scan(regex).flatten.join == target ? 'YES' : 'NO'
end
