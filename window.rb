require 'gosu'
require 'debugger'

class Window < Gosu::Window

  CELL_SIZE = $config[:cell_size]

  def initialize(ant_world)
    super ant_world.grid_width * CELL_SIZE, ant_world.grid_height * CELL_SIZE + 40, false
    self.caption = "ANTS!"
    @ant_world = ant_world
    @output = Gosu::Font.new(self, "courier new", 20)
  end
  
  def update
    @ant_world.tick()
  end
  
  def draw
    (0 ... @ant_world.grid_width).each do |grid_x|
      (0 ... @ant_world.grid_height).each do |grid_y|
        c = @ant_world.grid[grid_x][grid_y]
        x = grid_x * CELL_SIZE
        y = grid_y * CELL_SIZE
        self.draw_quad(x, y, c, x+CELL_SIZE, y, c, x+CELL_SIZE, y+CELL_SIZE, c, x, y+CELL_SIZE, c, 1)
      end
    end
    @ant_world.ants.each do |ant|
      x = ant.x * CELL_SIZE + (CELL_SIZE * 0.25)
      y = ant.y * CELL_SIZE + (CELL_SIZE * 0.25)
      d = CELL_SIZE * 0.5
      c = ant.carry_color
      self.draw_quad(x, y, c, x+d, y, c, x+d, y+d, c, x, y+d, c, 2)
    end

    @output.draw("global score: " + @ant_world.total_score.to_s, 20, @ant_world.grid_height * CELL_SIZE + 10, 2)

  end

  def button_down(id)
    if id == Gosu::KbEscape
      close
    elsif id == Gosu::MsLeft
      debugger
    end
  end
  
end