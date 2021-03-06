require_relative 'rr_map'
require_relative 'rr_prospector'
# This class runs
class Simulator
  attr_reader :seed
  attr_reader :num_prospectors
  attr_reader :num_turns
  attr_reader :map

  def run
    create_map
    prospect
  end

  def parseargs(args)
    if args.size != 3 || !match_all_args(args)
      false
    else
      setargs(args)
      true
    end
  end

  def match_all_args(args)
    seed = args.at(0)
    prospectors = args.at(1)
    turns = args.at(2)
    if match_seed(seed) && match_args(prospectors) && match_args(turns)
      true
    else
      false
    end
  end

  def match_seed(input)
    /\A[-+]?\d+\z/ =~ input ? true : false
  end

  def match_args(input)
    /\A\d+\z/ =~ input ? true : false
  end

  def setargs(args)
    @seed = args.at(0).to_i
    @num_prospectors = args.at(1).to_i
    @num_turns = args.at(2).to_i
  end

  def create_map
    @map = Map.new(@seed)
  end

  def prospect
    (1..num_prospectors).each do |i|
      prospector = Prospector.new(@num_turns, @map, i)
      prospector.prospect
    end
  end
end
