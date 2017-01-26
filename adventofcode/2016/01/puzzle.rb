#!/usr/bin/env ruby

direction = 0 + 1i
location  = 0 + 0i
crumbs   = [location]
revisits = []

input =  File.read('input.txt')
instructions = input.chomp.split(', ')

instructions.each_with_index do |instruction, idx|
  turn, distance = instruction.chomp.split('',2)
  direction = turn.eql?('L') ? direction *= 1i : direction *= -1i
  distance.to_i.times do
    location += direction
    revisits << location if crumbs.include? location
    crumbs << location
  end

end

puts 'Answer 1: %s' % (location.real.abs + location.imag.abs)
puts 'Answer 2: %s' % (revisits.first.real.abs + revisits.first.imag.abs)
