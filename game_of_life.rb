class Game
	attr_accessor :world, :seeds

	def initialize(world=World.new, seeds=[])
		@world = world
		@seeds = seeds
    seeds.each do |seed|
      world.cell_grid[seed[0]][seed[1]].activate
    end

    if seeds.empty?
      world.random_seed
    end
	end

  def tick!
    revive_next_round = []
    kill_next_round = []

    world.cells.each do |cell|
      live_neighbours = world.live_neighbours_around_cell(cell)
      
      # Rule 1 
      if cell.alive? and live_neighbours.count < 2
       kill_next_round << cell
      end
      # Rule 2
      if cell.alive? and [2,3].include? live_neighbours.count
       revive_next_round << cell 
      end
      # Rule 3
      if cell.alive? and live_neighbours.count > 3
       kill_next_round << cell 
      end
      # Rule 4
      if cell.dead? and live_neighbours.count == 3
       revive_next_round << cell
      end
    end 
    
    revive_next_round.each do |cell|
      cell.activate
    end
    
    kill_next_round.each do |cell|
      cell.die!
    end
  end
end

class World
	attr_accessor :rows, :cols, :cell_grid, :cells

	def initialize rows=3, cols=3
		@rows = rows
		@cols = cols
    @cells = []
    
    # [[Cell.new][Cell.new][Cell.new]
    #  [Cell.new][Cell.new][Cell.new]
    #  [Cell.new][Cell.new][Cell.new]]
		@cell_grid = Array.new(rows) do |row|
			Array.new(cols) do |col|
				cell = Cell.new(col, row)
        @cells << cell
        cell
			end
		end
	end

  def live_cells
    @cells.select { |cell| cell.alive }
  end

  def random_seed
    @cells.each do |cell|
      cell.alive = [true, false].sample
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
    if cell.x < (cols - 1)
      eastern_cell = self.cell_grid[cell.y][cell.x + 1]
      if eastern_cell.alive?
        live_cells << eastern_cell
      end
    end
    if cell.y < (rows - 1)
      southern_cell = self.cell_grid[cell.y + 1][cell.x]
      if southern_cell.alive?
        live_cells << southern_cell
      end
    end
    if cell.y > 0 and cell.x < (cols - 1)
      northeast_cell = self.cell_grid[cell.y - 1][cell.x + 1]
      if northeast_cell.alive?
        live_cells << northeast_cell
      end
    end
    if cell.y > 0 and cell.x > 0
      northwest_cell = self.cell_grid[cell.y - 1][cell.x - 1]
      if northwest_cell.alive?
        live_cells << northwest_cell
      end
    end
    if cell.y < (rows - 1) and cell.x < (cols - 1)
      southeast_cell = self.cell_grid[cell.y + 1][cell.x + 1]
      if southeast_cell.alive?
        live_cells << southeast_cell
      end
    end
    if cell.y < (rows - 1) and cell.x > 0
      southwest_cell = self.cell_grid[cell.y + 1][cell.x - 1] 
      if southwest_cell.alive?
        live_cells << southwest_cell
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
    @alive
  end

  def dead?
    @alive != true
  end

  def die!
    @alive = false
  end
end
