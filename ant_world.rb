require 'gosu'

class AntWorld

  attr_accessor :grid_width, :grid_height, :grid, :ants

  def initialize(width=$config[:grid_width], height=$config[:grid_height])
    @grid_width = width
    @grid_height = height
    @grid = Array.new(@grid_width) { Array.new(@grid_height) { Gosu::Color.new(Random.rand(25)*10, Random.rand(25)*10, Random.rand(25)*10) } }
    @ants = Array.new($config[:number_of_ants]) { Ant.new(Random.rand(@grid_width), Random.rand(@grid_height)) }
  end

  def tick
    @ants.each do |ant|
      ant.move((Random.rand(3) - 1).round, (Random.rand(3) - 1).round, @grid_width, @grid_height)
      ant.consider_swap(@grid, self)
    end
  end

  def total_score
    s = 0
    @grid.each_with_index do |row, i|
      row.each_with_index do |col, j|
        s += score(@grid, i, j, col)
      end
    end
    s
  end

  def score(grid, x, y, color=nil)
    color = grid[x][y] unless color
    total_dist = 0
    (x-$config[:neighborhood] .. x+$config[:neighborhood]).each do |nx|
      (y-$config[:neighborhood] .. y+$config[:neighborhood]).each do |ny|
        total_dist += dist(color, grid[nx%grid.count][ny%grid[0].count])
      end
    end
    total_dist
  end

  def dist(c1, c2)
    (c1.red - c2.red).abs + (c1.green - c2.green).abs + (c1.blue - c2.blue).abs
  end

  class Ant

    attr_accessor :x, :y, :carry_color, :carry_time

    def initialize(x, y)
      @x = x
      @y = y
      @carry_time = 0
      @carry_color = Gosu::Color.new(Random.rand(25)*10, Random.rand(25)*10, Random.rand(25)*10)

      @carry_time_max = $config[:carry_time_max]
    end

    def move(dx, dy, max_x, max_y)
      @x = (@x + dx) % max_x
      @y = (@y + dy) % max_y
    end

    def consider_swap(grid, aw)
      current_tile_score = aw.score(grid, @x, @y, grid[@x][@y])
      swap_tile_score = aw.score(grid, @x, @y, @carry_color)
      if (swap_tile_score < current_tile_score || @carry_time > @carry_time_max)
        t = grid[@x][@y]
        grid[@x][@y] = @carry_color
        @carry_color = t
        @carry_time = 0
      else
        @carry_time += 1
      end
    end

  end
end