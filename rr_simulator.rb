# This class runs
class Simulator
  @@usage = "Usage: \nruby ruby_rush.rb *seed* *num_prospectors* *num_turns*
*seed* should be an integer \n*num_prospectors* should be a non-negative integer
*num_turns* should be a non-negative integer" 
  def run(args) 
    parseargs(args)
  end

  def parseargs(args)
    if args.size != 3 || !match_all_args(args)
      puts @@usage
    else
      setargs(args)
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
    @seed = args.at(0)
    @num_prospectors = args.at(1)
    @num_turns = args.at(2)
  end
end
