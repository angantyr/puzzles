#!/usr/bin/env ruby

file = 'input.txt'

$ssl_ips = []

def is_aba? (chars)
  chars[0] != chars[1] && chars[0] == chars[2]
end

def find_abas(segment)
  abas = []
  (0..segment.length-3).each do |i|
    token = segment.slice(i,3).chars
    abas << token.join if is_aba? token
  end
  return abas
end

def extract_abas_from(segments)
  abas = []
  segments.each do |segment|
    abas << find_abas(segment)
  end
  return abas
end

def collect_matching_babs(abas, segments)
  babs = []
  abas.each do |aba|
    segments.each do |segment|
      bab = aba.chars[1] + aba.chars[0] + aba.chars[1]
      babs << segment.scan(/#{bab}/)
    end
  end
  return babs
end

File.readlines(file).each_with_index do |line,idx|
  ip =line.chomp
  abas = []

  external_segments = ip.scan(/(\w*)\[\w*\](\w*)/).flatten.delete_if{|e| e.empty?}
  abas = extract_abas_from(external_segments)
  next if abas.flatten.compact.uniq.empty?

  internal_segments = ip.scan(/\[(\w+)\]/).flatten
  babs = collect_matching_babs(abas.flatten.compact.uniq, internal_segments)

  if babs.flatten.compact.any?
    $ssl_ips << ip
    next
  end
  
end

puts 'Answer 2: %s' % $ssl_ips.size
