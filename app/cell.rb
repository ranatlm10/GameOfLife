class Cell
  attr_reader :space, :coords

  STATUSES = { "dead" => 0, "live" => 1 }

  def initialize(space, coords, value = 0)
    @space, @coords, @value = space, coords, value
  end

  def status
    STATUSES.key(@value)
  end

  def get_value_char
    @value == 1 ? "*" : '.'
  end

  def is_dead?
    @value == 0
  end

  def is_live?
    @value == 1
  end

  def die!
    @value = 0
  end

  def live!
    @value = 1
  end

  def get_live_neighbour_count
    get_live_neighbour_count_recursively([], 0)
  end

  private

  def get_live_neighbour_count_recursively(indexes, index)
    if indexes.count == coords.count
      if indexes == @coords
        return 0
      end

      if @space.check_coords(indexes)
        cell = @space.cell_at(indexes)

        if (cell.is_live?)
          return 1
        end
      end

      return 0
    end

    coord = @coords[index]

    live_count = 0

    new_indexes = Array.new indexes
    new_indexes.push(coord-1)
    live_count += get_live_neighbour_count_recursively(new_indexes, index + 1)

    new_indexes = Array.new indexes
    new_indexes.push(coord)
    live_count += get_live_neighbour_count_recursively(new_indexes, index + 1)

    new_indexes = Array.new indexes
    new_indexes.push(coord+1)
    live_count += get_live_neighbour_count_recursively(new_indexes, index + 1)

    live_count
  end
end
