#ruby_rush.rb Michael Grasser

args = ARGV
usage = "Usage: \nruby ruby_rush.rb *seed* *num_prospectors* *num_turns* \n*seed* should be an integer \n*num_prospectors* should be a non-negative integer \n*num_turns* should be a non-negative integer"
if args.size != 3 || !/\A[-+]?\d+\z/.match(args.at(0)) || !/\A\d+\z/.match(args.at(1)) || !/\A\d+\z/.match(args.at(2))
	puts usage
else
end


