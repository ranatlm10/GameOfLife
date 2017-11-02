require './app/cell'
require './app/space'

describe Cell do
  before(:each) do
    @space = Space.new([5, 5])
  end

  describe "Cell properties" do
    it "Check default status dead" do
      cell = @space.cell_at([1, 1])

      expect(cell.is_dead?).to be true
      expect(cell.is_live?).to be false
    end

    it "Set cell status to live" do
      cell = @space.cell_at([1, 1])
      cell.live!

      expect(cell.is_dead?).to be false
      expect(cell.is_live?).to be true
    end

    it "Check neighbours" do
      @space.set_cell_val([1, 1], 1)

      expect(@space.cell_at([0, 0]).get_live_neighbour_count).to be 1
      expect(@space.cell_at([0, 1]).get_live_neighbour_count).to be 1
      expect(@space.cell_at([0, 2]).get_live_neighbour_count).to be 1
      expect(@space.cell_at([1, 0]).get_live_neighbour_count).to be 1
      expect(@space.cell_at([1, 2]).get_live_neighbour_count).to be 1
      expect(@space.cell_at([2, 0]).get_live_neighbour_count).to be 1
      expect(@space.cell_at([2, 1]).get_live_neighbour_count).to be 1
      expect(@space.cell_at([2, 2]).get_live_neighbour_count).to be 1
    end
  end
end
