require './app/cell'

class Space
  @dimension = 2
  @under_population_count = 2
  @over_population_count = 3
  @rebirth_count = 3

  def initialize(dimension_counts, default_cell_value = 0, under_population_count = 2, over_population_count = 3, rebirth_count = 3)
    @dimension_counts, @under_population_count, @over_population_count, @rebirth_count = dimension_counts, under_population_count, over_population_count, rebirth_count
    @dimension = dimension_counts.count

    @cells = []

    create_space(@cells, dimension_counts, 0, [], default_cell_value)
  end

  def print_cells
    if @dimension == 2
      print_2d_space
    else
      print_space @cells
    end
  end

  def cell_at(coords)
    if !check_coords(coords)
      raise "Invalid coordinates provided"
    end

    find_cell(@cells, coords, 0)
  end

  def check_coords(coords)
    if coords.length != @dimension_counts.length
      return false
    end

    coords.each_with_index do |coord, index|
      if coord < 0 || coord >= @dimension_counts[index]
        return false
      end
    end

    true
  end

  def set_cell_val(coords, value)
    cell = cell_at(coords)

    if value == 1
      cell.live!
    elsif value == 0
      cell.dead!
    end
  end

  def create_next_generation
    next_gen_cells = []

    create_space(next_gen_cells, @dimension_counts, 0, [], 0)

    next_generation_util(next_gen_cells, [], 0)

    @cells = next_gen_cells
  end

  private

  def update_cell(prev_cell, next_cell)
    live_count = prev_cell.get_live_neighbour_count

    if live_count < @under_population_count
      next_cell.die!
    elsif live_count > @over_population_count
      next_cell.die!
    elsif live_count == @rebirth_count
      next_cell.live!
    else
      if prev_cell.is_live?
        next_cell.live!
      end
    end
  end

  def next_generation_util(next_gen_cells, indexes, index)
    if indexes.count == @dimension
      if check_coords(indexes)
        cell = cell_at(indexes)
        new_cell = find_cell(next_gen_cells, indexes, 0)

        update_cell(cell, new_cell)
      end

      return 0
    end

    @dimension_counts[index].times do |i|
      new_indexes = Array.new indexes
      new_indexes.push(i)

      next_generation_util(next_gen_cells, new_indexes, index + 1)
    end
  end

  def print_2d_space_2(array)
    array.each do |row|
      row.each do |cell|
        print "#{cell.get_value_char}"
      end
      puts ""
    end
  end

  def print_2d_space
    @cells.each do |row|
      row.each do |cell|
        print "#{cell.get_value_char}"
      end
      puts ""
    end
  end

  def find_cell(cells, coords, index)
    if(index == coords.count - 1)
      return cells[coords[index]]
    end

    find_cell(cells[coords[index]], coords, index + 1)
  end

  def print_space(d_current)
    if d_current.kind_of?(Array)
      print "["

      d_current.each do |x|
        print_space x
      end

      print "], "
    else
      print "#{d_current.get_value_char}, "
    end
  end

  def create_space(d_prev, d_counts, index, indexes, default_cell_value)
    return if index == d_counts.count

    if index == d_counts.count - 1
      d_counts[index].times do |i|
        new_indexes = Array.new(indexes)
        new_indexes.push(i)

        d_current = Cell.new(self, new_indexes, default_cell_value)

        d_prev.push(d_current)
      end
    else
      d_counts[index].times do |i|
        d_current = []

        new_indexes = Array.new(indexes)
        new_indexes.push(i)

        create_space(d_current, d_counts, index+1, new_indexes, default_cell_value)

        d_prev.push(d_current)
      end
    end
  end
end
