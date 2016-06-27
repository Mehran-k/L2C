require './parser'
require './domain'
require './Helper'
require './constant'
require './logvar'
require './prv'
require './literal'
require './clause'
require './cache'
require './wfomc'
require './cnf'
require './constraint'
require './cpphandler'
require './branchingorder'

#parameters
order_heuristic = "MNL"
num_sls = 50
max_pop_size = 100

#arguments
arguments = Hash.new
(0..ARGV.size / 2).each do |i|
	arguments[ARGV[2 * i]] = ARGV[2 * i + 1]
end

if arguments["-f"].nil?
	Helper.error("Please specify the input file")
elsif !File.file?(arguments["-f"])
	Helper.error("No such file found!")
end
if !arguments["-h"].nil?
	if arguments["-h"] != "MTS" or arguments["-h"] != "MNL"
		Helper.error("Invalid elimination ordering heuristic")
	else
		order_heuristic = arguments["-h"]
	end
end
if !arguments["-k"].nil?
	if !Helper.all_digit(arguments["-k"])
		Helper.error("Invalid number of stochastic local search iterations for elimination order optimization.")
	else
		num_sls = arguments["-k"].to_i
	end
end

content = File.read(arguments["-f"])
parser = Parser.new(content)
parser.produce_cnf
cnf = CNF.new(parser.formulae)
cnf.remove_all_lv_neq_constant_constraints(true)
cnf.preemptive_shatter
puts "Initial theory after shattering:"
puts cnf.my2string
puts "~~~~~~~~~~~~~~~~"
puts "Finding the branching order"
bo = BranchingOrder.new(cnf)
order = bo.min_nested_loop_order(num_sls)
weight_function = cnf.adjust_weights(parser.weights)
wfomc = WFOMC.new(weight_function, max_pop_size)
wfomc.set_order(order)
puts "Starting to compile"
cpp_core = wfomc.compile(cnf)
cpp_core = wfomc.cache.remove_inserts(cpp_core)
doubles = wfomc.get_doubles
queues = wfomc.cache.queues_declaration
cpp_handler = CPPHandler.new(cpp_core, doubles, queues)
cpp_handler.execute(arguments["-f"].gsub(".wmc", ""), max_pop_size)
