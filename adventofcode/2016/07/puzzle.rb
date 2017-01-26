#!/usr/bin/env ruby

file = 'input.txt'

$tls = []

def is_abba? (chars)
  chars[0] != chars[1] && chars[0] == chars[3] && chars[1] == chars[2]
end

def has_abba? (segment)
  (0..segment.length-4).each do |i|
    return true if is_abba? segment.slice(i,4).chars
  end
  return false
end

def contains_abbas? (segments)
  segments.each do |segment|
    return true if has_abba? segment
  end
  return false
end

File.readlines(file).each_with_index do |line,idx|
  ip =line.chomp
  internal_segments = ip.scan(/\[(\w+)\]/).flatten
  next if contains_abbas?(internal_segments)

  external_segments = ip.scan(/(\w*)\[\w*\](\w*)/).flatten.delete_if{|e| e.empty?}

  if contains_abbas?(external_segments)
    $tls << ip
    next
  end

end

puts 'Answer 1: %s' % $tls.size
