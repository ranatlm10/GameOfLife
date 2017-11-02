#Game Of life

The Game of Life, also known simply as Life, is a cellular automaton devised by the British mathematician John Horton Conway in 1970.

The "game" is a zero-player game, meaning that its evolution is determined by its initial state, requiring no further input. One interacts with the Game of Life by creating an initial configuration and observing how it evolves.

The universe of the Game of Life is an infinite two-dimensional orthogonal grid of square cells, each of which is in one of two possible states, live or dead. Every cell interacts with its eight neighbors, which are the cells that are directly horizontally, vertically, or diagonally adjacent. At each step in time, the following transitions occur:
1. Any live cell with fewer than two live neighbours dies, as if caused by underpopulation.
1. Any live cell with more than three live neighbours dies, as if by overcrowding.
1. Any live cell with two or three live neighbours lives on to the next generation.
1. Any dead cell with exactly three live neighbours becomes a live cell.

##Instructions

1. Clone the repository
1. `cd GameOfLife`
1. `bundle install`
1. Dry run - `ruby main.rb`
1. Specs in spec/ folder
1. `rspec spec/cell_spec.rb`
1. `rspec spec/space_spec.rb`
1. `rspec spec/main_spec.rb`
