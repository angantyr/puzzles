#!/usr/bin/env ruby

file  = 'input.txt'
diffs = []
File.readlines(file).each do |line|
  row = line.chomp.split.map(&:to_i)
  diffs << row.sort.last - row.sort.first
end
puts "Answer 1: #{diffs.inject :+}"

quotients = []
File.readlines(file).each do |line|
  row = line.chomp.split.map(&:to_i)
  digits = row.sort.reverse
  digits.each_with_index do |dividend,idx|
    i = idx+1
    while i < digits.size do
      divisor = digits[i]
      quotient = dividend.to_f/divisor
      quotients << quotient.to_i if quotient % 1 == 0
      i += 1
    end
  end
end
puts "Answer 2: #{quotients.inject :+}"
