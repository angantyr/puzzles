#!/usr/bin/env ruby

file = 'input.txt'

class Panel
  attr_accessor :outputs, :find_or_create_output
  def initialize
    @outputs = Hash.new
  end

  def outputs
    @outputs
  end

  def find_or_create_output(name)
    outputs[name] || outputs[name] = Output.new(name)
  end

end

class Output
  attr_accessor :name, :chips, :add_chip

  def initialize(name)
    @name = name
    @chips = []
  end

  def add_chip(chip)
    @chips << chip
  end

end


class Herd
  attr_accessor :bots, :find_or_create_bot
  def initialize
    @bots = Hash.new
  end

  def bots
    @bots
  end

  def find_or_create_bot(name)
      bots[name] || bots[name] = Bot.new(name)
  end

end

class Bot
  attr_accessor :name, :chips, :low, :high

  def initialize(name, opts = {})
    @name = name
    @chips = opts[:chips] || []
    @low = opts[:low]
    @high = opts[:high]
  end

  def ready_to_distribute?
    @low && @high && @chips.size == 2
  end

  def is_answer?
    (@chips & $chip_ids).size == 2
  end

  def report_answer
    puts 'Answer 1: %s' % @name
  end

  def add_chip(chip)
    @chips << chip
    report_answer if is_answer?
    distribute_chips if ready_to_distribute?
  end

  def add_low(receiver)
    @low = receiver
    distribute_chips if ready_to_distribute?
  end

  def add_high(receiver)
    @high = receiver
    distribute_chips if ready_to_distribute?
  end

  def high_value
    @chips.sort.last
  end

  def low_value
    @chips.sort.first
  end

  def distribute_chips
    @high.add_chip(high_value)
    @low.add_chip(low_value)
    @chips = []
  end

end

def add_chip_to_bot(line)
  chip,bot_id = line.scan(/\D+ (\d+)/).flatten.collect{|d| d.to_i}
  # puts "  add_chip_to_bot(chip:#{chip}, bot:#{bot_id})"
  bot = $herd.find_or_create_bot(bot_id)
  bot.add_chip(chip)
end

def add_rule_to_bot(line)
  b,l,h = line.scan(/bot \d+|output \d+/)
  # puts "  add_rule_to_bot(bot:#{b},low:#{l},high:#{h})"
  bot = get_receiver_from_name(b)
  bot.add_low(get_receiver_from_name(l))
  bot.add_high(get_receiver_from_name(h))
end

def get_receiver_from_name(name)
  # puts "  get_receiver_from_name(#{name})"
  id = name.split(' ').last.to_i
  # puts "    id: #{id}"
  if name.start_with? 'bot'
    $herd.find_or_create_bot(id)
  else
    $panel.find_or_create_output(id)
  end
end


$panel = Panel.new
$herd = Herd.new
$chip_ids = [17,61]
$output_ids = [0,1,2]

File.readlines(file).each_with_index do |line,idx|
  line.chomp!
  if line.start_with? 'value'
    add_chip_to_bot(line)
  else
    add_rule_to_bot(line)
  end
end

def calculate_answer_two
  factors = []
  $output_ids.each do |idx|
    factors << $panel.outputs.fetch(idx).chips
  end
  factors.flatten.inject(:*)
end

puts 'Answer 2: %s' % calculate_answer_two
