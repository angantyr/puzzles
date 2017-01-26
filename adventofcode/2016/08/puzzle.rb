#!/usr/bin/env ruby

file = 'input.txt'
$matrix = Array.new(6) { Array.new(50, 0) }

def turn_on(instruction)
  yt,xt = instruction.split('x').collect{|d| d.to_i-1}
  (0..xt).each do |x|
    (0..yt).each do |y|
      $matrix[x][y] = 1
    end
  end
end

def rotate(instruction)
  axis = instruction.first.to_sym
  count = instruction.last.to_i
  pos,idx = instruction[1].split('=')
  if axis.eql? :row
    $matrix[idx.to_i].rotate!(-count)
  else
    m = $matrix.transpose
    m[idx.to_i].rotate!(-count)
    $matrix = m.transpose
  end
end

File.readlines(file).each do |line|
  instruction = line.chomp.split
  if instruction.shift.eql?('rect')
    turn_on(instruction.first)
  else
    rotate(instruction)
  end
end

puts 'Answer 1: %s' % $matrix.flatten.inject(:+)
puts "Answer 2:"
$matrix.each do |row|
  puts row.join.gsub('1','X').gsub('0','.')
end
