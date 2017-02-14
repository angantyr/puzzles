#!/usr/bin/env ruby

# TODO: replace current path tracking, using a hash table, with a queue system
# based on Dijkstra's algorithm: Invented to find the shortest paths between
# nodes in a graph, which sounds just like what we're looking for.
# https://en.wikipedia.org/wiki/Dijkstra%27s_algorithm#Pseudocode

# n = gets.strip.to_i
n = 5

class Board
  attr_accessor :target, :size

  def initialize(size)
    @size = size
    @target = [size-1,size-1]
    reset_board
  end

  def reset_board
    @grid = Array.new(size) { Array.new(size, 'O') }
  end

  def show
    puts ''
    @grid.each do |row|
      puts row.join(' ')
    end
    puts ''
  end

  def mark_path(path)
    path.values.each do |crumb|
      @grid[crumb.first][crumb.last] = 'X'
    end
  end

end

class Knight

  attr_accessor :path, :position, :path, :board, :step_combo

  def initialize(step_combo,board)
    @step_combo = step_combo
    @board = board
    @position = []
    @path = {}
    jump_to([0,0])
  end

  def start
    candidate_moves = possible_moves_from(@position)
    candidate_moves.each_with_index do |move|
      jump_to(move)
      return true if arrived?
      continue
    end
  end

  alias_method :continue, :start

  def jump_to(square)
    @path[@position] = square
    @position = square
  end

  def arrived?
    @position == board.target
  end

  def possible_moves_from(position)
    # step_combo = [1,2]
    c = calc(step_combo) + calc(step_combo.reverse)

    possible_squares = get_squares(c.uniq)
    # puts possible_squares.inspect
    possible_moves = collect_moves_from(possible_squares)
    # puts possible_moves.inspect
    possible_moves
  end

  def collect_moves_from(possible_squares)
    possible_squares.reject {|s| @path.values.include? s }
  end


  def get_squares(steps)
    sqs = []
    steps.each do |step|
      c = [ position[0] + step[0], position[1] + step[1] ]
      sqs << c unless c.sort.first < 0 || c.sort.last >= board.size
    end
    sqs
  end

  def calc(steps)
    a = steps
    b = a.map {|i| -i}
    c = []
    c << a << [ a[0], b[1] ] << [ b[0],a[1] ] << b
    # puts c.inspect
    c
  end


  def result
    puts "path:\n#{path.inspect}"
    puts "board.target => #{board.target.inspect}"
    puts "path.values:\n #{path.values.inspect}"
    if path.values.include? board.target
      -1
    else
      0
    end
  end

end

def build_step_combinations_from(n)
  combos = []
  n.times do |x|
    combos[x] = []
    n.times do |y|
      combos[x][y] = [x+1,y+1]
    end
  end
  combos
end


b = Board.new(n)
# puts b.inspect

# start

# build unique step combinations
step_combinations = build_step_combinations_from(n-1)

# store attempts
attempts = {}

# build knights and send them off for target
step_combinations.each do |combinations|
  attempts[combinations[0][0]] = {}
  combinations.each do |combination|
    puts "checking combination: #{combination.inspect}"
    # check if combination has already been tried here
    b.reset_board
    k = Knight.new(combination,b)
    # puts k.inspect
    k.start
    puts "k.path.values.size => #{k.path.values.size}"
    attempts[combination[0]][combination] = k.result
    # puts k.path.inspect
    b.mark_path(k.path)
    b.show
  end
end



attempts.each do |row,runs|
  puts runs.values.join(' ')
end
