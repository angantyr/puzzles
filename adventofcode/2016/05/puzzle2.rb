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
    char = hash.chars[5]
    if char.match(/\d/) && char.to_i < 8 && !password_array[char.to_i]
      password_array[char.to_i] = hash.chars[6]
    end
  end
  counter +=1;
end until password_array.compact.size == password_length

puts 'Answer 2: %s' % password_array.join
