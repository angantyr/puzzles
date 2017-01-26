#!/usr/bin/env ruby

file = 'input.txt'

$decompressed = ''

def decompress(source)
  tokens = source.scan(/(\D*)\((\d*x\d*)\)(.*)/)
  if tokens.empty?
    $decompressed << source
  else
    prefix, multiplier, remainder = tokens.flatten
    $decompressed << prefix
    length,count = multiplier.split('x').collect{|d| d.to_i}
    fragment = remainder.slice(0..length-1)
    remainder = remainder.slice(length..-1)
    $decompressed << fragment*count
    decompress(remainder) unless remainder.empty?
  end
end

input =  File.read('input.txt')
decompress(input.chomp!)
puts 'Answer 1: %s' % $decompressed.size
