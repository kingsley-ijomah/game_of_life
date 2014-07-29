require 'gosu'
require_relative 'game_of_life.rb'

class GameOfLife < Gosu::Window
  def initialize(width=800, height=600)
    @width = width
    @height = height
    super @width, @height, false
    self.caption = 'Game of Life'
    @background_color = Gosu::Color.new(0xffdedede)
    
    # Game
    @cols = width/10
    @rows = height/10
    @world = World.new(@cols, @rows)
    @game = Game.new(@world)
  end

  def update
  end

  def draw
    draw_quad(
      0, 0, @background_color,
      @width, 0, @background_color,
      @width, @height, @background_color,
      0, @height, @background_color
    ) 
  end

  def needs_cursor?
    true
  end
end

GameOfLife.new.show
