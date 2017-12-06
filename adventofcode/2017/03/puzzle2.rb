#!/usr/bin/env ruby

input = 289326
direction = 0 + 1i
location  = 0 + 0i
spiral = {}

def coordinate(location)
  [location.real, location.imag]
end

def neighbors(location)
  n = []
  lx,ly = location.real, location.imag
  (-1..1).each do |x|
    (-1..1).each do |y|
      n << [lx+x,ly+y]
    end
  end
  return n
end

def get_neighbors_total(location,spiral)
  t = 0
  neighbors(location).each do |coords|
    t += spiral.fetch(coords,0)
  end
  return t
end

spiral[coordinate(location)] = 1

direction *= -1i
location += direction

spiral[coordinate(location)] = 1

steps = input - 2

steps.times do |n|
  square_on_left = location + direction * 1i
  if spiral.fetch(coordinate(square_on_left),false)
    location += direction
  else
    direction *= 1i
    location += direction
  end
  coordinate_value = get_neighbors_total(location,spiral)
  spiral[coordinate(location)] = coordinate_value

  if coordinate_value > input
    puts 'Answer 2: %s' % coordinate_value
    break
  end
  
end
