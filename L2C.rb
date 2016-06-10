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

#parameters
order_heuristic = "MNL"
num_sls = 0
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
cnf.shatter
puts cnf.my2string
puts "~~~~~"
cnf.replace_prvs_having_same_lv
puts cnf.my2string

# wfomc = WFOMC.new(parser.weights, max_pop_size)
# wfomc.set_order(cnf.min_nested_loop_order(num_sls))
# cache = Cache.new
# cpp_core = wfomc.compile(cnf, cache)
# doubles = wfomc.get_doubles
# puts cpp_core
# cpp_handler = CPPHandler.new(cpp_core, doubles)
# cpp_handler.execute(arguments["-f"].gsub(".wmc", ""), max_pop_size)


# pop_size, decomposer_lv_pos, prv_pos = cnf.get_decomposer_lv
# # puts pop_size.inspect
# # puts decomposer_lv_pos.inspect
# # puts prv_pos.inspect
# puts "~~~~~~~~~~"
# cnf.decompose(decomposer_lv_pos, prv_pos)
# puts cnf.my2string
# cnf.shatter
# puts "~~~~~~~~"
# puts cnf.my2string

# puts "~~~~~~~~~~~~~~~~"
# prv = cnf.clauses[0].literals[0].prv
# cnf.branch(prv, "3")
# cnf.apply_branch_observation(prv)
# puts cnf.my2string
# puts "~~~~~~~~~~~~~~~~"
# cnf.remove_resolved_constraints
# puts cnf.my2string

