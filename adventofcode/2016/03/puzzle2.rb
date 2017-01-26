#!/usr/bin/env ruby

file = 'input.txt'

triangles = 0
h = []
File.readlines(file).each_with_index do |line,idx|
  l =line.chomp.split.map(&:to_i)
  h << l
  if (idx+1) % 3 == 0
    a,b,c = h
    cols = a.zip(b).zip(c)
    cols.each do |t|
      t.flatten!
      checks = []
      3.times do
        checks << (t[0]+t[1] > t[2])
        t.rotate!
      end
      triangles += 1 unless checks.include?(false)
    end
    h = []
  end
end

puts 'Answer 2: %s' % triangles
