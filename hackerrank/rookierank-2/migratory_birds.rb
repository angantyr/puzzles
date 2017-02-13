#!/bin/ruby

class Hash
  def safe_invert
    self.each_with_object({}){|(k,v),o|(o[v]||=[])<<k}
  end
end

def bird_count(str)
  str.each_char.with_object({}) { |c,h|
    (h[c] = h.fetch(c,0) + 1) if c =~ /[1-5]/ }
end

n = gets.strip.to_i
count = bird_count(gets.strip)
puts count.safe_invert.sort.reverse.first.flatten.last
