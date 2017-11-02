require './app/cell'
require './app/space'

describe "Game of life" do
  before(:each) do
    @space = Space.new([10, 10])
  end

  describe "Cell dies if less than 2 live neighbour cells" do
    it "No live neighbours" do
      cell = @space.cell_at [1, 1]
      cell.live!

      @space.create_next_generation

      cell = @space.cell_at [1, 1]
      expect(cell.is_dead?).to be true
    end

    it "1 live neighbour" do
      cell = @space.cell_at [1, 1]
      neighbour_cell = @space.cell_at [1,2]

      cell.live!
      neighbour_cell.live!

      @space.create_next_generation

      cell = @space.cell_at [1, 1]
      neighbour_cell = @space.cell_at [1,2]

      expect(cell.is_dead?).to be true
      expect(neighbour_cell.is_dead?).to be true
    end
  end

  describe "Cell stays as it is with 2 live neighbour cells" do
    it "Live cell, 2 live neighbours" do
      cell = @space.cell_at [1, 1]
      neighbour_cell_1 = @space.cell_at [1,2]
      neighbour_cell_2 = @space.cell_at [1,0]

      cell.live!
      neighbour_cell_1.live!
      neighbour_cell_2.live!

      @space.create_next_generation

      cell = @space.cell_at [1, 1]

      expect(cell.is_live?).to be true
    end

    it "Live cell, 2 live neighbours" do
      cell = @space.cell_at [1, 1]
      neighbour_cell_1 = @space.cell_at [1,2]
      neighbour_cell_2 = @space.cell_at [1,0]

      neighbour_cell_1.live!
      neighbour_cell_2.live!

      @space.create_next_generation

      cell = @space.cell_at [1, 1]

      expect(cell.is_dead?).to be true
    end
  end

  describe "Cell is live if 3 live neighbour cells" do
    it "Live cell, stays live" do
      cell = @space.cell_at [1, 1]
      neighbour_cell_1 = @space.cell_at [1, 2]
      neighbour_cell_2 = @space.cell_at [1, 0]
      neighbour_cell_3 = @space.cell_at [2, 1]

      cell.live!
      neighbour_cell_1.live!
      neighbour_cell_2.live!
      neighbour_cell_3.live!

      @space.create_next_generation

      cell = @space.cell_at [1, 1]

      expect(cell.is_live?).to be true
    end

    it "Dead cell, rebirth" do
      cell = @space.cell_at [1, 1]
      neighbour_cell_1 = @space.cell_at [1, 2]
      neighbour_cell_2 = @space.cell_at [1, 0]
      neighbour_cell_3 = @space.cell_at [2, 1]

      neighbour_cell_1.live!
      neighbour_cell_2.live!
      neighbour_cell_3.live!

      @space.create_next_generation

      cell = @space.cell_at [1, 1]

      expect(cell.is_live?).to be true
    end
  end

  describe "Live cell dies if more than 3 live neighbour cells" do
    it "Live cell, 4 live neighbour cells" do
      cell = @space.cell_at [1, 1]
      neighbour_cell_1 = @space.cell_at [1, 2]
      neighbour_cell_2 = @space.cell_at [1, 0]
      neighbour_cell_3 = @space.cell_at [2, 1]
      neighbour_cell_4 = @space.cell_at [0, 1]

      cell.live!
      neighbour_cell_1.live!
      neighbour_cell_2.live!
      neighbour_cell_3.live!
      neighbour_cell_4.live!

      @space.create_next_generation

      cell = @space.cell_at [1, 1]

      expect(cell.is_dead?).to be true
    end

    it "Live cell, 5 live neighbour cells" do
      cell = @space.cell_at [1, 1]
      neighbour_cell_1 = @space.cell_at [1, 2]
      neighbour_cell_2 = @space.cell_at [1, 0]
      neighbour_cell_3 = @space.cell_at [2, 1]
      neighbour_cell_4 = @space.cell_at [0, 1]
      neighbour_cell_5 = @space.cell_at [0, 0]

      cell.live!
      neighbour_cell_1.live!
      neighbour_cell_2.live!
      neighbour_cell_3.live!
      neighbour_cell_4.live!
      neighbour_cell_5.live!

      @space.create_next_generation

      cell = @space.cell_at [1, 1]

      expect(cell.is_dead?).to be true
    end
  end

  describe "pattern match after next generation" do
    it "Pattern 1" do
=begin
  Input

  ......
  ..**..
  .**...
  ....*.
  ..*...
  ......

  Output

  ......
  .***..
  .**...
  ..**..
  ......
  ......
=end
      @space.set_cell_val([1, 2], 1)
      @space.set_cell_val([1, 3], 1)
      @space.set_cell_val([2, 1], 1)
      @space.set_cell_val([2, 2], 1)
      @space.set_cell_val([3, 4], 1)
      @space.set_cell_val([4, 2], 1)

      @space.create_next_generation

      expect(@space.cell_at([1, 1]).is_live?).to be true
      expect(@space.cell_at([1, 2]).is_live?).to be true
      expect(@space.cell_at([1, 3]).is_live?).to be true
      expect(@space.cell_at([2, 1]).is_live?).to be true
      expect(@space.cell_at([2, 2]).is_live?).to be true
      expect(@space.cell_at([3, 2]).is_live?).to be true
      expect(@space.cell_at([3, 3]).is_live?).to be true
    end

    it "Pattern 2" do
=begin
  Input

  .....
  ..*..
  ...*.
  .***.
  .....


  Output

  .....
  .....
  .*.*.
  ..**.
  ..*..
=end
      @space.set_cell_val([1, 2], 1)
      @space.set_cell_val([2, 3], 1)
      @space.set_cell_val([3, 1], 1)
      @space.set_cell_val([3, 2], 1)
      @space.set_cell_val([3, 3], 1)

      @space.create_next_generation

      expect(@space.cell_at([2, 1]).is_live?).to be true
      expect(@space.cell_at([2, 3]).is_live?).to be true
      expect(@space.cell_at([3, 2]).is_live?).to be true
      expect(@space.cell_at([3, 3]).is_live?).to be true
      expect(@space.cell_at([4, 2]).is_live?).to be true
    end
  end
end
