#!/usr/bin/env ruby

class Keypad

  def initialize(origin)
    @layout = layout
    @x, @y = origin
    @code = []
  end

  def process(file)
    File.readlines(file).each_with_index do |line,idx|
      line.chomp!
      @code[idx] = follow(line)
    end
  end

  def follow(movements)
    movements.each_char do |char|
      move(char)
    end
    return @layout[@y][@x]
  end

  def move(char)
    case char
    when 'U'
      @y -= 1 unless off_pad?(@x,@y-1)
    when 'R'
      @x += 1 unless off_pad?(@x+1,@y)
    when 'D'
      @y += 1 unless off_pad?(@x,@y+1)
    when 'L'
      @x -= 1 unless off_pad?(@x-1,@y)
    end
  end

  def off_pad?(x,y)
    @layout[y][x] == 0 || @layout[y][x] == '-'
  end

  def code
    @code.join
  end

end

class StandardKeypad < Keypad

  def layout
    [
      [0, 0,  0,  0,  0],
      [0, 1,  2,  3,  0],
      [0, 4,  5,  6,  0],
      [0, 7,  8,  9,  0],
      [0, 0,  0,  0,  0]
    ]
  end

end

class StarKeypad < Keypad

  def layout
    [
      ['-','-','-','-','-','-','-'],
      ['-','-','-','1','-','-','-'],
      ['-','-','2','4','3','-','-'],
      ['-','5','6','7','8','9','-'],
      ['-','-','A','B','C','-','-'],
      ['-','-','-','D','-','-','-'],
      ['-','-','-','-','-','-','-']
    ]
  end

end
