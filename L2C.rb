#Copyright (C) 2016  Seyed Mehran Kazemi, Licensed under the GPL V3; see: <https://www.gnu.org/licenses/gpl-3.0.en.html>

require './classes/parser'
require './classes/domain'
require './classes/Helper'
require './classes/constant'
require './classes/logvar'
require './classes/prv'
require './classes/literal'
require './classes/clause'
require './classes/cache'
require './classes/wfomc'
require './classes/cnf'
require './classes/constraint'
require './classes/cpphandler'
require './classes/branchingorder'

#parameters
order_heuristic = "MNL"
num_sls = 25
readable = false

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
if !arguments["-r"].nil?
	if arguments["-r"] != "true" and arguments["-r"] != "false"
		Helper.error("The readability command specified using '-r' must be either true or false.")
	elsif arguments["-r"] == "true"
		readable = true
	end
end

content = File.read(arguments["-f"])
parser = Parser.new(content)
parser.produce_cnf
cnf = CNF.new(parser.formulae)
cnf.preemptive_shatter
puts "Initial theory after shattering:"
puts cnf.my2string + "\n"
puts "Finding the branching order"
t_start = Time.now
bo = BranchingOrder.new(cnf)
order = bo.min_nested_loop_order(num_sls)
puts "The branching Order is: " + order.join(", ")
puts "Finding the branching order took " + (Time.now - t_start).to_s + " seconds.\n\n"
weight_function = cnf.adjust_weights(parser.weights)
wfomc = WFOMC.new(weight_function)
wfomc.set_order(order)
puts "Starting to compile"
t_start = Time.now
cpp_core = wfomc.compile(cnf, true)
cpp_core = wfomc.cache.remove_inserts(cpp_core)
puts "The compilation is done!"
puts "Compilation took " + (Time.now - t_start).to_s + " seconds.\n\n"
doubles = wfomc.get_doubles
queues = wfomc.cache.queues_declaration
puts "Compiling and executing the C++ program"
t_start = Time.now
cpp_handler = CPPHandler.new(cpp_core, doubles, queues, weight_function)
cpp_handler.polish_code
cpp_handler.add_indent if readable
cpp_handler.execute(arguments["-f"].gsub(".wmc", ""), cnf.max_pop_size)
puts "Compiling and executing the C++ program took " + (Time.now - t_start).to_s + " seconds."

