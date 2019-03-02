# Simulator Test
require 'minitest/autorun'
require_relative 'rr_simulator'

class SimulatorTest < Minitest::Test
  # UNIT TESTS FOR METHOD parseargs(args)
  # Equivalence classes:
  # args.size < 3 -> returns false
  # args.size > 3 -> returns false
  # args.size == 3 and args are not of correct form -> returns false
  # args.size == 3 and args are of correct form -> returns true
  # Tests that parseargs returns false on args < 3
  def test_parseargs_less_than_3
    sim = Simulator.new
    refute sim.parseargs(['1','2'])
  end

  # Tests that parseargs returns false on args > 3
  def test_parseargs_more_than_3
    sim = Simulator.new
    refute sim.parseargs(['1','2','3','4'])
  end

  # Test parseargs with 3 params assuming bad args
  def test_parseargs_3_and_bad_args
    sim_stubbed = Simulator.new
    def sim_stubbed.match_all_args(args) false end
    refute sim_stubbed.parseargs(['a','b','c'])
  end

  # Test parseargs with 3 params assuming good args
  def test_parseargs_3_and_good_args
    sim_stubbed = Simulator.new
    def sim_stubbed.match_all_args(args) true end
    assert sim_stubbed.parseargs(['1','2','3'])
  end

  # UNIT TESTS FOR METHOD match_all_args(args)
  # Equivalence classes:
  # all args are valid -> returns true
  # one or more args are invalid -> returns false
  #
  # Tests match_all_args on all valid args
  def test_match_all_args_valid
    sim_stubbed = Simulator.new
    def sim_stubbed.match_seed(input) true end
    def sim_stubbed.match_args(input) true end
    assert sim_stubbed.match_all_args(['1','2','3'])
  end

  # Tests match_all_args with invalid input
  def test_match_all_args_invalid
    sim_stubbed = Simulator.new
    def sim_stubbed.match_seed(input) false end
    def sim_stubbed.match_args(input) true end
    refute sim_stubbed.match_all_args(['1','2','3'])
  end

  # UNIT TESTS FOR METHOD match_seed(input)
  # Equivalence classes
  # input is integer -> true
  # input is string -> false
  #
  # Tests match_seed on valid input
  def test_match_seed_valid
    sim = Simulator.new
    assert sim.match_seed('1')
  end

  # Tests mach_seed on invalid input
  def test_match_seed_invalid
    sim = Simulator.new
    refute sim.match_seed('laboon')
  end

  # UNIT TESTS FOR METHOD match_args(input)
  # Equivalence classes
  # input is string -> returns false
  # input < 0 -> returns false
  # input >=0 -> returns true
  #
  # Tests match_args with non-integer
  def test_match_args_string
    sim = Simulator.new
    refute sim.match_args('laboon')
  end

  # Tests match_args with input < 0
  def test_match_args_less_zero
    sim = Simulator.new
    refute sim.match_args('-1')
  end

  # Tests match_args with input >= 0
  def test_match_args_valid
    sim = Simulator.new
    assert sim.match_args('1')
  end

  # UNIT TESTS FOR setargs(args)
  # Equivalence classes
  # valid input -> instance variables set
  #
  # Tests that instance variables are set correctly
  def test_setargs
    sim = Simulator.new
    sim.setargs(['1','2','3'])
    assert sim.seed == 1
    assert sim.num_prospectors == 2
    assert sim.num_turns == 3
  end

  # UNIT TESTS FOR create_map
  # Tests that map is created correctly
  def test_create_map
    sim = Simulator.new
    sim.instance_variable_set(:@seed, 1234)
    sim.create_map
    assert sim.map
  end
end
