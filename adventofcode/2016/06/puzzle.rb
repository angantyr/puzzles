#!/usr/bin/env ruby

file = 'input.txt'

$matrix = {}
$answer_1 = []
$answer_2 = []

class Hash
  def safe_invert
    self.each_with_object({}){|(k,v),o|(o[v]||=[])<<k}
  end
end

def letter_count(str)
  str.downcase.each_char.with_object({}) { |c,h|
    (h[c] = h.fetch(c,0) + 1) if c =~ /[a-z]/ }
end

File.readlines(file).each_with_index do |line,idx|
  chars =line.chomp.chars
  chars.each_with_index do |char,idx|
    $matrix[idx] = [] unless $matrix[idx]
    $matrix[idx] << [char]
  end
end

def most_frequent(hash)
  hash.first.last.first
end

def least_frequent(hash)
  hash[hash.keys.last].first
end

$matrix.values.each_with_index do |col,idx|
  frequency_counts = letter_count(col.join)
  $answer_1 << most_frequent(frequency_counts.safe_invert.sort.reverse.to_h)
  $answer_2 << least_frequent(frequency_counts.safe_invert.sort.reverse.to_h)
end

puts 'Answer 1: %s' % $answer_1.join
puts 'Answer 2: %s' % $answer_2.join
