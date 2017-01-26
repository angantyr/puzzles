#!/usr/bin/env ruby

require File.join(File.dirname(__FILE__), "/keypad.rb")

file = 'input.txt'

keypad1 = StandardKeypad.new([2,2])
keypad1.process(file)

keypad2 = StarKeypad.new([1,3])
keypad2.process(file)

puts 'Answer 1: %s' % keypad1.code
puts 'Answer 2: %s' % keypad2.code
