# ruby_rush.rb Michael Grasser
require_relative 'rr_simulator.rb'
@usage = "Usage: \nruby ruby_rush.rb *seed* *num_prospectors* *num_turns*
*seed* should be an integer \n*num_prospectors* should be a non-negative integer
*num_turns* should be a non-negative integer"
args = ARGV
sim = Simulator.new
sim.parseargs(args) ? sim.run : (puts @usage; exit 1)
exit 0
