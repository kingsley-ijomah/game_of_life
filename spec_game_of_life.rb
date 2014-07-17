# spec file
require 'rspec'
require_relative 'game_of_life'

describe 'Game of life' do

	context 'world' do
		subject { World.new }

		it 'should create a new world instance' do
			expect(subject.is_a? World).to be true
		end

		it 'should respond to methods' do
			expect(subject).to respond_to :rows
			expect(subject).to respond_to :cols
			expect(subject).to respond_to :cell_grid
		end

		it 'checks that cell_grid is an array' do
			expect(subject.cell_grid).is_a? Array
			subject.cell_grid.each do |row|
				expect(row.is_a? Array).to be true
				row.each do |col|
					expect(col.is_a? Cell).to be true
				end
			end
		end
	end

	context 'Cell' do
		subject { Cell.new }

		it 'should create a new cell instance' do
			expect(subject.is_a? Cell).to be true
		end
	end

end