#!/usr/bin/env ruby

@real_names = {}
@sections = []

file = 'input.txt'

class Hash
  def safe_invert
    self.each_with_object({}){|(k,v),o|(o[v]||=[])<<k}
  end
end

def letter_count(str)
  str.downcase.each_char.with_object({}) { |c,h|
    (h[c] = h.fetch(c,0) + 1) if c =~ /[a-z]/ }
end

def decrypt(name,section)
  decrypted = []
  offset = section.to_i % 26
  name.chars.each do |char|
    offset.times do
      char = char == 'z' ? 'a' : char.next
    end unless char == '-'
    decrypted << char
  end
  return decrypted.join.gsub(/-/,' ')
end


File.readlines(file).each do |line|
  name,section,checksum = line.chomp.match(/([a-z-]+)-(\d+)\[(\D+)\]/).captures
  count = letter_count(name)
  letters = count.safe_invert.sort.reverse.to_h.values.collect{|a| a.sort}.join
  if letters.slice(0..4) == checksum
    @sections << section.to_i
    real_name = decrypt(name,section)
    @real_names[real_name] = section
  end
end

puts 'Answer 1: %s' % @sections.inject(:+)
puts 'Answer 2: %s' % @real_names['northpole object storage']
