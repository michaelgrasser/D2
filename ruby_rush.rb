# ruby_rush.rb Michael Grasser
require_relative 'rr_simulator.rb'
args = ARGV
sim = Simulator.new
sim.run(args)
