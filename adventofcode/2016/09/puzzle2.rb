#!/usr/bin/env ruby

def get_decompressed_length(source)
  l = 0
  tokens = source.scan(/(\D*)\((\d*x\d*)\)(.*)/)
  if tokens.empty?
    l = source.length
  else
    prefix, multiplier, remainder = tokens.flatten
    l += prefix.length
    size,count = multiplier.split('x').collect{|d| d.to_i}
    fragment = remainder.slice(0..size-1)
    fragment_length = get_decompressed_length(fragment)
    remainder = remainder.slice(size..-1)
    l += fragment_length*count
    l += get_decompressed_length(remainder) unless remainder.empty?
  end
  return l
end

input =  File.read('input.txt')
puts 'Answer 2: %s' % get_decompressed_length(input.chomp!)
