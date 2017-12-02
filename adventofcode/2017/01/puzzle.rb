#!/usr/bin/env ruby

matches_next = []
matches_across = []

input =  File.read('input.txt')
digits = input.chomp.split('').map(&:to_i)

digits.each_with_index do |digit,idx|
  offset = idx+1
  matches_next << digit if digit == digits.rotate(offset).first
  offset = digits.size/2 + idx
  matches_across << digit if digit == digits.rotate(offset).first
end

puts "Answer 1: #{matches_next.inject :+}"
puts "Answer 2: #{matches_across.inject :+}"
