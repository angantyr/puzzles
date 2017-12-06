#!/usr/bin/env ruby

file  = 'input.txt'
@instructions = []
@steps = 0
@cursor = 0

File.readlines(file).each do |line|
  @instructions << line.chomp.to_i
end

def jump(offset)
  @steps += 1
  if offset >= 3
    @instructions[@cursor] -= 1
  else
    @instructions[@cursor] += 1
  end
  @cursor += offset unless offset.zero?
end

while @cursor < @instructions.size
  offset = @instructions[@cursor]
  jump(offset)
end

puts "Answer 2: #{@steps}"
