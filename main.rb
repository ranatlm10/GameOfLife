#!/usr/bin/ruby -w
require './app/space'

space = Space.new([10, 10])

space.set_cell_val([1, 3], 1)
space.set_cell_val([1, 4], 1)
space.set_cell_val([2, 4], 1)

space.set_cell_val([5, 3], 1)
space.set_cell_val([5, 4], 1)
space.set_cell_val([6, 2], 1)
space.set_cell_val([6, 3], 1)
space.set_cell_val([7, 5], 1)
space.set_cell_val([8, 4], 1)

puts "Input :"
space.print_cells

space.create_next_generation

puts "\nOutput :"
space.print_cells
