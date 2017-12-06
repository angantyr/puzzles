#!/usr/bin/env ruby

input = 289326
direction = 0 + 1i
location  = 0 + 0i
spiral = {}

def coordinate(location)
  [location.real, location.imag]
end

spiral[coordinate(location)] = 1

direction *= -1i
location += direction

spiral[coordinate(location)] = 2

steps = input - 2

steps.times do |n|
  square_on_left = location + direction * 1i
  if spiral.fetch(coordinate(square_on_left),false)
    location += direction
  else
    direction *= 1i
    location += direction
  end
  spiral[coordinate(location)] = n+3
end

puts 'Answer 1: %s' % (location.real.abs + location.imag.abs)
