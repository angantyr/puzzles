#!/usr/bin/env ruby

file = 'input.txt'

triangles = 0

File.readlines(file).each do |line|
  t =line.chomp.split.map(&:to_i)
  checks = []
  3.times do
    checks << (t[0]+t[1] > t[2])
    t.rotate!
  end
  triangles += 1 unless checks.include?(false)
end
puts 'Answer 1: %s' % triangles
