class Game
	attr_accessor :world, :seeds

	def initialize(world=World.new, seeds=[])
		@world = world
		@seeds = seeds
    seeds.each do |seed|
      world.cell_grid[seed[0]][seed[1]].activate
    end
	end
end

class World
	attr_accessor :rows, :cols, :cell_grid

	def initialize rows=3, cols=3
		@rows = rows
		@cols = cols
    
    # [[Cell.new][Cell.new][Cell.new]
    #  [Cell.new][Cell.new][Cell.new]
    #  [Cell.new][Cell.new][Cell.new]]
		@cell_grid = Array.new(rows) do |row|
			Array.new(cols) do |col|
				Cell.new(col, row)
			end
		end
	end

  def live_neighbours_around_cell(cell)
    live_cells = []
    if cell.y > 0
      northern_cell = self.cell_grid[cell.y - 1][cell.x]
      if northern_cell.alive?
        live_cells << northern_cell
      end
    end
    if cell.x > 0
      western_cell = self.cell_grid[cell.y][cell.x - 1]
      if western_cell.alive?
        live_cells << western_cell
      end
    end
    if cell.x < cols
      eastern_cell = self.cell_grid[cell.y][cell.x + 1]
      if eastern_cell.alive?
        live_cells << eastern_cell
      end
    end
    if cell.y < rows
      southern_cell = self.cell_grid[cell.y + 1][cell.x]
      if southern_cell.alive?
        live_cells << southern_cell
      end
    end
    live_cells
  end
end

class Cell
	attr_accessor :alive, :x, :y

	def initialize(x=0, y=0)
		@x = x
		@y = y
		@alive = false
	end

  def activate
    @alive = true
  end

  def alive?
    alive
  end
end
