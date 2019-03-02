# Map class; contains the prng
# and determines movement and number of
# rubies found as a specific place
# mapping (ha)
# 0 Enumerable Canyon
# 1 Duck Type Beach
# 2 Monkey Patch City
# 3 Nil Town
# 4 Matzburg
# 5 Hash Crossing
# 6 Dynamic Palisades
class Map
  attr_reader :prng
  def initialize(seed)
    init_generator(seed)
    @moves = [[1, 2], [0, 4], [0, 3, 4], [2, 5],
              [1, 2, 5, 6], [3, 4, 6], [4, 5]]
    @rubies = [[1, 1], [2, 2], [1, 1], [0, 3],
               [3, 0], [2, 2], [2, 2]]
  end

  def init_generator(seed)
    @prng = Random.new(seed)
  end

  def move(pos)
    @moves.at(pos).at(@prng.rand(0...@moves.at(pos).size))
  end

  # Returns number of rubies found [real, fake]
  def mine(pos)
    rubies = @rubies.at(pos)
    [rubies.at(0).zero? ? 0 : @prng.rand(0..rubies.at(0)),
     rubies.at(1).zero? ? 0 : @prng.rand(0..rubies.at(1))]
  end
end
