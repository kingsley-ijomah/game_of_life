require 'gosu'
require_relative 'game_of_life.rb'

class GameOfLife < Gosu::Window
  def initialize
    super 800, 800, false
    self.caption = 'Game of Life'
  end
end

GameOfLife.new.show
