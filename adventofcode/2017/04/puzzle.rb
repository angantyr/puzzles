#!/usr/bin/env ruby

file  = 'input.txt'
valid_passphrase_count = 0

File.readlines(file).each do |line|
  passphrase = line.chomp.split
  valid_passphrase_count += 1 unless passphrase.detect{ |w| passphrase.count(w) > 1 }
end
puts "Answer 1: #{valid_passphrase_count}"


valid_passphrase_count = 0

def letter_count(str)
  str.downcase.each_char.with_object({}) { |c,h|
    (h[c] = h.fetch(c,0) + 1) if c =~ /[a-z]/ }
end

File.readlines(file).each_with_index do |line,idx|
  passphrase = line.chomp.split
  next if passphrase.detect{ |w| passphrase.count(w) > 1 }
  contains_anagrams = false
  while word = passphrase.shift do
    passphrase.each_with_index do |other, idx|
     if letter_count(word) == letter_count(other)
       contains_anagrams = true
       break
     end
    end
  end
  valid_passphrase_count += 1 unless contains_anagrams
end
puts "Answer 2: #{valid_passphrase_count}"
