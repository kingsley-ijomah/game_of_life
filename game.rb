require 'gosu'
require_relative 'game_of_life.rb'

class GameOfLife < Gosu::Window
  def initialize(width=800, height=600)
    @width = width
    @height = height
    super @width, @height, false
    self.caption = 'Game of Life'
    @background_color = Gosu::Color.new(0xffdedede)
    @alive_color = Gosu::Color.new(0xff121212)
    @dead_color = Gosu::Color.new(0xffededed)
    
    # Game
    @cols = width/10
    @rows = height/10
    @cell_width = width / @cols
    @cell_height = height / @rows

    @world = World.new(@cols, @rows)
    @game = Game.new(@world)
  end

  def update
    @game.tick!
  end

  def draw
    draw_quad(
      0, 0, @background_color,
      @width, 0, @background_color,
      @width, @height, @background_color,
      0, @height, @background_color
    ) 

    @game.world.cells.each do |cell|
      if cell.alive?
        # draw a live cell
        draw_quad(cell.x * @cell_width, cell.y * @cell_height, @alive_color,
                  cell.x * @cell_width + @cell_width, cell.y * @cell_height, @alive_color,
                  cell.x * @cell_width + @cell_width, cell.y * @cell_height + @cell_height, @alive_color,
                  cell.x * @cell_width, cell.y * @cell_height + @cell_height, @alive_color) 
      else
        # draw a dead cell
        draw_quad(cell.x * @cell_width, cell.y * @cell_height, @dead_color,
                  cell.x * @cell_width + @cell_width, cell.y * @cell_height, @dead_color,
                  cell.x * @cell_width + @cell_width, cell.y * @cell_height + @cell_height, @dead_color,
                  cell.x * @cell_width, cell.y * @cell_height + @cell_height, @dead_color) 
      end
    end
  end

  def needs_cursor?
    true
  end
end

GameOfLife.new.show
