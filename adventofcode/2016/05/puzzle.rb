#!/usr/bin/env ruby

require 'digest/md5'

door_id = 'cxdnnyjw'
pattern = '00000'
password_hash = {}
password_array = []
password_length = 8
counter = 0

begin
   hash = Digest::MD5.hexdigest(door_id + counter.to_s)
  if hash.start_with? pattern
    password_hash[counter] = hash
    password_array << hash.chars[5]
  end
  counter +=1;
end until password_array.size == password_length

puts 'Answer 1: %s' % password_array.join
