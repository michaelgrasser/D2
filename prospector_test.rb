# Simulator Test
require 'minitest/autorun'
require_relative 'rr_prospector'
require_relative 'rr_map'

class ProspectorTest < Minitest::Test
  # UNIT TESTS FOR METHOD prospect_turn
  # Equivalence classes:
  # map.mine finds rubies -> continues looping
  # map.mine finds 0 rubies and 0 fake rubies -> returns rubies found that turns
  # Tests that loop stops when 0 rubies and 0 fake rubies are found
  def test_prospect_turn
    mock_map = Minitest::Mock.new("map")
    def mock_map.mine(a); [0,0]; end
    pros = Prospector.new(0,mock_map,0)
    assert pros.prospect_turn == [0,0]
  end

  # UNIT TESTS FOR METHOD turn_putter(real, fake)
  # Equivalence classes:
  # real, fake both == 0 returns "\tFound no rubies or fake rubies in <location>
  # real == 0, fake > 0 returns "\tFound <fake> fake rubies in <location>"
  # fake == 0, real > 0 returns "\tFound <real> rubies in <location>"
  # real, fake > 0 returns "\tFound <real> ruby/rubies and <fake> fake ruby/rubies in <location>"
  # Tests that turn_putter returns correct on 0,0
  def test_turn_putter_none
    pros = Prospector.new(0,0,0)
    assert pros.turn_putter(0,0).eql? "\tFound no rubies or fake rubies in Enumerable Canyon"
  end
  # Tests that turn_putter return correctly on 0 real 1 fake
  def test_turn_putter_fake
    pros = Prospector.new(0,0,0)
    assert pros.turn_putter(0,1).eql? "\tFound 1 fake ruby in Enumerable Canyon"
  end
  # Tests that turn_putter return correctly on 1 real 0 fake
  def test_turn_putter_real
    pros = Prospector.new(0,0,0)
    assert pros.turn_putter(1,0).eql? "\tFound 1 ruby in Enumerable Canyon"
  end
  # Tests that turn_putter return correctly on 1 real 1 fake
  def test_turn_putter_both
    pros = Prospector.new(0,0,0)
    assert pros.turn_putter(1,1).eql? "\tFound 1 ruby and 1 fake ruby in Enumerable Canyon"
  end

  # UNIT TESTS FOR METHOD ruby_string(rubies)
  # Equivalence classes:
  # rubies == 0 returns empty string
  # rubies == 1 returns '1 ruby'
  # rubies > 1 returns '<number_of_rubies> rubies'
  # Tests that ruby_string returns empty string on 0
  def test_ruby_string_0
    pros = Prospector.new(0,0,0)
    assert pros.ruby_string(0).eql? ''
  end
  # Tests that ruby_string returns '1 ruby' string on 1
  def test_ruby_string_1
    pros = Prospector.new(0,0,0)
    assert pros.ruby_string(1).eql? '1 ruby'
  end
  # Tests that ruby_string returns '<number_of_rubies> rubies' on input > 1
  def test_ruby_string_big
    pros = Prospector.new(0,0,0)
    assert pros.ruby_string(2).eql? '2 rubies'
  end

  # UNIT TESTS FOR METHOD fake_string(rubies)
  # Equivalence classes:
  # rubies == 0 returns empty string
  # rubies == 1 returns '1 fake ruby'
  # rubies > 1 returns '<number_of_rubies> fake rubies'
  # Tests that ruby_string returns empty string on 0
  def test_fake_string_0
    pros = Prospector.new(0,0,0)
    assert pros.fake_string(0).eql? ''
  end
  # Tests that ruby_string returns '1 ruby' string on 1
  def test_fake_string_1
    pros = Prospector.new(0,0,0)
    assert pros.fake_string(1).eql? '1 fake ruby'
  end
  # Tests that ruby_string returns '<number_of_rubies> rubies' on input > 1
  def test_fake_string_big
    pros = Prospector.new(0,0,0)
    assert pros.fake_string(2).eql? '2 fake rubies'
  end

  # UNIT TESTS FOR METHOD ruby_count
  # Equivalence classes:
  # 0 real and 0 fake returns "After <num> days, Rubyist #<id> found:\n\t0 rubies.\n0 fake rubies.\n"
  # All other behavior managed by ruby_string and fake_string
  # Tests that ruby_count returns correct count with 0 rubies and 0 fake rubies
  def test_ruby_count_zeros
    pros = Prospector.new(0,0,0)
    assert pros.ruby_count.eql? "After 0 days, Rubyist #0 found:\n\t0 rubies.\n\t0 fake rubies.\n"
  end

  # UNIT TESTS FOR METHOD end_string
  # rubies == 0 returns string "Going home empty handed."
  # rubies 1..9 returns string "Going home sad."
  # rubies > 9 returns string "Going home victorious!"
  # Tests end_string with 0 rubies
  def test_end_string_zero
    pros = Prospector.new(0,0,0)
    assert pros.end_string.eql? 'Going home empty handed.'
  end
  # Tests end_string with 1 ruby
  def test_end_string_one
    pros = Prospector.new(0,0,0)
    pros.instance_variable_set(:@real, 1)
    assert pros.end_string.eql? 'Going home sad.'
  end
  # Tests end_string with 10 rubies
  # EDGE CASE
  def test_end_string_ten
    pros = Prospector.new(0,0,0)
    pros.instance_variable_set(:@real, 10)
    assert pros.end_string.eql? 'Going home victorious!'
  end
  # Tests end_string with 20 rubies
  def test_end_string_twenty
    pros = Prospector.new(0,0,0)
    pros.instance_variable_set(:@real, 20)
    assert pros.end_string.eql? 'Going home victorious!'
  end

  # UNIT TESTS FOR start_string
  # Equivalence classes: none
  def test_start_string
    pros = Prospector.new(0,0,0)
    assert pros.start_string.eql? 'Rubyist #0 starting in Enumerable Canyon.'
  end

  # UNIT TESTS FOR moving_string(pos, new_pos)
  # Equivalence classes: none
  def test_moving_string
    pros = Prospector.new(0,0,0)
    assert pros.moving_string(0,0).eql? 'Heading from Enumerable Canyon to Enumerable Canyon.'
  end

    # UNIT TESTS FOR add_to_rubies(rubies)
    # Equivalence classes: none
    def test_add_to_rubies
      pros = Prospector.new(0,0,0)
      pros.add_to_rubies([1,1])
      assert pros.real == 1 && pros.fake == 1
    end

    # UNIT TESTS FOR check_end_of_rubyist(turn, new_pos)
    # Equivalence classes:
    # Turn == number of turns -> return ruby_count and end_string
    # Turn != number of turns -> return moving_string
    # Test to check if it returns correctly when turn == number of turns
    def test_check_end_of_rubyist_end
      pros = Prospector.new(0,0,0)
      def pros.ruby_count; "ruby_count"; end
      def pros.end_string; "end_string"; end
      assert pros.check_end_of_rubyist(0,0).eql? 'ruby_countend_string'
    end
    # Test to check if it returns correctly when turn == number of turns
    def test_check_end_of_rubyist_not_end
      pros = Prospector.new(3,0,0)
      def pros.moving_string(a,b); "moving"; end
      assert pros.check_end_of_rubyist(0,0).eql? 'moving'
    end
end
