require './app/space'

describe Space do
  before(:each) do
    @space = Space.new([5, 5])
  end

  describe "Space specs" do
    it "Cell present check" do
      expect(@space.check_coords [0, 0]).to be true
    end

    it "Space boundary check" do
      expect(@space.check_coords [5, 5]).to be false
      expect(@space.check_coords [-1, 0]).to be false
      expect(@space.check_coords [0, -1]).to be false
      expect(@space.check_coords [-1, -1]).to be false
    end
  end
end
