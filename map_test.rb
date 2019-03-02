# Map tests
require 'minitest/autorun'
require_relative 'rr_map'

class MapTest < Minitest::Test
  # UNIT TESTS FOR METHOD init_generator(seed)
  # Equivalence classes: none
  # Tests that @prng is set correctly with the seed when initialized
  def test_init_generator
    map = Map.new(1234)
    map.init_generator(1234)
    assert Random.new(1234) == map.prng
  end

  # UNIT TESTS FOR METHOD move(pos)
  # With seed set to 1234 ------
  # Equivalence classes:
  # 0 -> returns 1 or 2 (seeded: 2)
  # 1 -> returns 0 or 4 (seeded: 4)
  # 2 -> returns 0, 3, or 4 (seeded: 4)
  # 3 -> returns 2 or 5 (seeded: 5)
  # 4 -> returns 1, 2, 5, or 6 (seeded: 6)
  # 5 -> returns 3, 4, or 6 (seeded: 6)
  # 6 -> returns 4 or 5 (seeded: 5)
  #
  # Tests that move(0) returns 2
  def test_move_0
    map = Map.new(1234)
    assert map.move(0) == 2
  end

  # Tests that move(1) returns 4
  def test_move_1
    map = Map.new(1234)
    assert map.move(1) == 4
  end

  # Tests that move(2) returns 4
  def test_move_2
    map = Map.new(1234)
    assert map.move(2) == 4
  end

  # Tests that move(3) returns 5
  def test_move_3
    map = Map.new(1234)
    assert map.move(3) == 5
  end

  # Tests that move(4) returns 6
  def test_move_4
    map = Map.new(1234)
    assert map.move(4) == 6
  end
  
  # Tests that move(5) returns 6
  def test_move_5
    map = Map.new(1234)
    assert map.move(5) == 6
  end
  
  # Tests that move(6) returns 5
  def test_move_6
    map = Map.new(1234)
    assert map.move(6) == 5
  end
  
  # UNIT TESTS FOR METHOD mine(pos)
  # With seed set to 1234 ------
  # Equivalence classes:
  # 0 -> returns up to 1 real and 1 fake (seeded: 0 and 0)
  # 1 -> returns up to 2 real and 2 fake (seeded: 2 fake)
  # 2 -> returns up to 1 real and 1 fake (seeded: 1 fake)
  # 3 -> returns up to 0 real and 3 fake (seeded: 3 fake)
  # 4 -> returns up to 3 real and 0 fake (seeded: 0 fake)
  # 5 -> returns up to 2 real and 2 fake (seeded: 2 fake)
  # 6 -> returns up to 2 real and 2 fake (seeded: 2 fake)
  #
  # Tests that mine(0) returns [0, 0]
  def test_mine_0
    map = Map.new(1234)
    assert map.mine(0) == [0, 0]
  end

  # Tests that mine(1) returns [1, 1]
  def test_mine_1
    map = Map.new(1234)
    assert map.mine(1) == [1, 1]
  end

  # Tests that mine(2) returns [0, 0]
  def test_mine_2
    map = Map.new(1234)
    assert map.mine(2) == [0, 0]
  end

  # Tests that mine(3) returns [0, 2]
  def test_mine_3
    map = Map.new(1234)
    assert map.mine(3) == [0, 2]
  end

  # Tests that mine(4) returns [2, 0]
  def test_mine_4
    map = Map.new(1234)
    assert map.mine(4) == [2, 0]
  end
  
  # Tests that mine(5) returns [1, 1]
  def test_mine_5
    map = Map.new(1234)
    assert map.mine(5) == [1, 1]
  end
  
  # Tests that mine(6) returns [1, 1]
  def test_mine_6
    map = Map.new(1234)
    assert map.mine(6) == [1, 1]
  end

end
