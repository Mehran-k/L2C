class BranchingOrder
	attr_accessor :cnf, :order_cache, :counter

	def initialize(cnf)
		@cnf = cnf.duplicate
		@cnf.ignore_all_constraints
		@order_cache = Hash.new
		@counter = 0
	end

	# def branch_and_bound_order
	# 	order = min_table_size_order
	# 	min_nested_loops = num_nested_loops(@cnf, order, 9999, 0) 
	# 	prv_names = @cnf.get_all_prvs.sort!{|a, b| a.logvars.size <=> b.logvars.psize}.map{|prv| prv.core_name}

	# end	

	# def branch_and_bound_search(cnf, prv_core_name)
	# 	cnf_dup = cnf.duplicate
	# 	return [0, cnf_dup] if cnf_dup.clauses.size == 0 or not cnf_dup.has_prv_with_core_name?(prv_core_name)

	# 	cnf_dup.clauses.select!{|clause| not clause.can_be_evaluated?}

	# 	unit_clauses = cnf_dup.unit_clauses
	# 	if not unit_clauses.empty?
	# 		unit_clauses.each do |unit_clause|                  
	# 			cnf_dup.propagate(unit_clause) if(unit_clause.literals.size > 0) #previous unit clauses may make others disapper
	# 		end
	# 		return branch_and_bound_search(cnf_dup, prv_core_name)
	# 	end

	# 	cc = cnf_dup.connected_components
	# 	if cc.size != 1
	# 		nnl = Array.new(cc.size)
	# 		new_cnfs = Array.new(cc.size)
	# 		cc.each_with_index do |cc_cnf, i|
	# 			nnl[i], new_cnfs[i] = branch_and_bound_search(cc_cnf, prv_core_name)
	# 		end
	# 		return [nnl.max, CNF.new(new_cnfs.map{|cnf| cnf.clauses}.flatten)]
	# 	end
		
	# 	pop_size, decomposer_lv_pos, prv_pos = cnf_dup.get_decomposer_lv
	# 	if not decomposer_lv_pos.nil?
	# 		cnf_dup.decompose(decomposer_lv_pos, prv_pos)
	# 		cnf_dup.replace_no_lv_prvs_with_rvs
	# 		return branch_and_bound_search(cnf_dup, prv_core_name)
	# 	end

	# 	if cnf_dup.fo2
	# 		cnf_dup.replace_individuals_for_fo2
	# 		cnf_dup.replace_no_lv_prvs_with_rvs
	# 		return branch_and_bound_search(cnf_dup, prv_core_name)
	# 	end

	# 	branch_prv = cnf_dup.next_prv([prv_core_name])
	# 	return [0, cnf_dup] if branch_prv.nil?

	# 	if  branch_prv.num_lvs == 0
	# 		cnf_dup1 = cnf_dup.duplicate
	# 		cnf_dup1.update(branch_prv.full_name, "true")
	# 		nnl1, cnf1 = branch_and_bound_search(cnf_dup1, prv_core_name)

	# 		cnf_dup2 = cnf_dup.duplicate
	# 		cnf_dup2.update(branch_prv.full_name, "false")
	# 		nnl2, cnf2 = branch_and_bound_search(cnf_dup2, prv_core_name)
	# 		#hmmmmm
	# 		return [nnl1, nnl2].max
	# 	elsif branch_prv.num_lvs == 1
	# 		return 1000 if (1 + num_local_loops) >= best_global
	# 		cnf_dup.branch(branch_prv, "0")
	# 		cnf_dup.apply_branch_observation(branch_prv)
	# 		return 1 + num_nested_loops(cnf_dup, order, best_global, 1 + num_local_loops)
	# 	end
	# 	return 1000
	# end

	def min_nested_loop_order(num_iterations)#does hill climbing on the minTableSize order to minimize the number of nested loops
		all_prvs = @cnf.get_all_prvs
		no_lvs = all_prvs.select{|prv| prv.logvars.size == 0}.map{|prv| prv.core_name}
		morethan_one_lvs = all_prvs.select{|prv| prv.logvars.size > 1}.map{|prv| prv.core_name}
		removed_double_rvs = all_prvs.select{|prv| not prv.core_name.index("_r").nil?}.map{|prv| prv.core_name}
		prvs_other = all_prvs.map{|prv| prv.core_name} - no_lvs - morethan_one_lvs - removed_double_rvs

		return no_lvs + removed_double_rvs + morethan_one_lvs if prvs_other.size == 0

		if(num_iterations > (1..prvs_other.size).reduce(:*))
			min_nested_loops = 9999
			order = []
			prvs_other.permutation.each do |new_order|
				num_nested_loops = num_nested_loops(@cnf, no_lvs + new_order + removed_double_rvs + morethan_one_lvs, min_nested_loops, 0) 
				if  num_nested_loops < min_nested_loops
					min_nested_loops = num_nested_loops
					order = no_lvs + new_order + removed_double_rvs + morethan_one_lvs
				end
			end
		else
			order = min_table_size_order
			min_nested_loops = num_nested_loops(@cnf, order, 9999, 0) 
			order_cache[order.join(",")] = min_nested_loops

			num_iterations.times do |i|
				new_order = order.dup
				r1 = rand(order.size-1) + 1
				r2 = rand(order.size-1) + 1
				r2 = rand(order.size-1) + 1 while(r2 == r1)
				new_order[r1], new_order[r2] = new_order[r2], new_order[r1]
				
				if(@order_cache[new_order.join(",")].nil?)
					num_nested_loops = num_nested_loops(@cnf, new_order, min_nested_loops, 0)
					@order_cache[new_order.join(",")] = num_nested_loops

					if  num_nested_loops < min_nested_loops
						min_nested_loops = num_nested_loops
						order = new_order.dup
					end
				end
			end	
		end

		# if  (num_iterations > (1..@cnf.get_all_prv_names.size-1).reduce(1, :*)) #in the number of iterations is more than the maximum number of permutations, we can simply test all permutations
		# 	min_nested_loops = 9999
		# 	order = []
		# 	(@cnf.get_all_prv_names).permutation.each do |new_order|
		# 		puts "Calculating num_nested_loops for #{new_order.join(',')}"
		# 		num_nested_loops = num_nested_loops(@cnf, new_order, min_nested_loops, 0)
		# 		if  num_nested_loops < min_nested_loops
		# 			min_nested_loops = num_nested_loops
		# 			order = new_order.dup
		# 		end
		# 	end
		# else #else we should do hill climbing num_iteration times
		# 	order = min_table_size_order
		# 	min_nested_loops = num_nested_loops(@cnf, order, 9999, 0) 
		# 	num_iterations.times do |i|
		# 		new_order = order.dup
		# 		r1 = rand(order.size-1) + 1
		# 		r2 = rand(order.size-1) + 1
		# 		r2 = rand(order.size-1) + 1 while(r2 == r1)
		# 		new_order[r1], new_order[r2] = new_order[r2], new_order[r1]
		# 		puts "Calculating num_nested_loops for #{new_order.join(',')}"
		# 		num_nested_loops = num_nested_loops(@cnf, new_order, min_nested_loops, 0)
		# 		if  num_nested_loops < min_nested_loops
		# 			min_nested_loops = num_nested_loops
		# 			order = new_order.dup
		# 		end
		# 	end	
		# end
		return order
	end

	def min_table_size(parfactors, prv_sizes) #see Kazemi and Poole 2014 for full description
		return [] if parfactors.keys.size == 0
		#selecting nodes with more than 1 logical variables
		to_elim_prv = nil
		max_cfbf = 0
		max_num_log_vars = 2
		parfactors.keys.each do |prv_name|
			if  prv_sizes[prv_name][0] > max_num_log_vars or (prv_sizes[prv_name][0] == max_num_log_vars and prv_sizes[prv_name][1] + 1 > max_cfbf)
				max_num_log_vars = prv_sizes[prv_name][0]
				max_cfbf = prv_sizes[prv_name][1] + 1
				to_elim_prv = prv_name
			end
		end
		#selecting the node with minimum CFBF
		min_size = 999999999
		if to_elim_prv.nil?
			parfactors.keys.each do |prv_name|
				prv_cfbf = parfactors[prv_name].inject(1){|result, neighbor| result *= (prv_sizes[neighbor][1] + 1)}
				if  prv_cfbf < min_size or (prv_cfbf == min_size and prv_sizes[prv_name][1] > prv_sizes[to_elim_prv][1])
					to_elim_prv = prv_name
					min_size = prv_cfbf
				end
			end
		end
		new_parfactor = parfactors.delete(to_elim_prv)
		new_parfactor.each {|prv_name| parfactors[prv_name] = (parfactors[prv_name] - [to_elim_prv]) | (new_parfactor - [prv_name])}
		return min_table_size(parfactors, prv_sizes) + [to_elim_prv]
	end

	def min_table_size_order
		parfactors = Hash.new #parfactor[prv] shows the factor that will be generated if we remove prv
		@cnf.duplicate.clauses.each do |clause|
			clause_prv_names = clause.literals.map{|literal| literal.name}
			clause.literals.each {|literal| parfactors[literal.name] = parfactors[literal.name].to_a | (clause_prv_names - [literal.name])}
		end
		return min_table_size(parfactors, @cnf.get_all_prv_sizes)
	end

	def num_nested_loops(cnf, order, best_global, num_local_loops)
		# puts cnf.my2string
		# puts "!~~~~~~~~~~~!"
		# puts order.join(", ")
		# puts "!!!!!!!!~~~~~~~!!!!!!!!"

		# @counter += 1
		# exit if @counter > 5

		cnf_dup = cnf.duplicate
		return 0 if cnf_dup.clauses.size == 0
		cnf_dup.clauses.select!{|clause| not clause.can_be_evaluated?}

		unit_clauses = cnf_dup.unit_clauses
		if not unit_clauses.empty?
			unit_clauses.each do |unit_clause|
				cnf_dup.propagate(unit_clause) if(unit_clause.literals.size > 0) #previous unit clauses may make others disapper
			end
			return num_nested_loops(cnf_dup, order, best_global, num_local_loops)
		end

		cc = cnf_dup.connected_components
		if cc.size != 1
			# puts "The network is disconnected"
			return cc.inject(0){|result, cc_cnf| result = [result, num_nested_loops(cc_cnf, order, best_global, num_local_loops)].max} 
		end
		
		pop_size, decomposer_lv_pos, prv_pos = cnf_dup.get_decomposer_lv
		if not decomposer_lv_pos.nil?
			# puts "The grounding is disconnected"
			cnf_dup.decompose(decomposer_lv_pos, prv_pos)
			cnf_dup.replace_no_lv_prvs_with_rvs
			return num_nested_loops(cnf_dup, order, best_global, num_local_loops) 
		end

		if cnf_dup.fo2
			# puts "FO2"
			cnf_dup.replace_individuals_for_fo2
			# cnf_dup.remove_all_lv_neq_constant_constraints(false)
			cnf_dup.replace_no_lv_prvs_with_rvs
			return num_nested_loops(cnf_dup, order, best_global, num_local_loops)
		end

		branch_prv = cnf_dup.next_prv(order)
		# puts "Branching on #{branch_prv.my2string}"
		# puts "Branching on: " + branch_prv.my2string
		if  branch_prv.num_lvs == 0
			cnf_dup1 = cnf_dup.duplicate
			cnf_dup1.update(branch_prv.full_name, "true")
			nnl1 = num_nested_loops(cnf_dup1, order, best_global, num_local_loops)
			return 1000 if nnl1 >= 1000
			cnf_dup2 = cnf_dup.duplicate
			cnf_dup2.update(branch_prv.full_name, "false")
			nnl2 = num_nested_loops(cnf_dup2, order, best_global, num_local_loops)
			return [nnl1, nnl2].max
		elsif branch_prv.num_lvs == 1
			return 1000 if (1 + num_local_loops) >= best_global
			cnf_dup.branch(branch_prv, "0")
			cnf_dup.apply_branch_observation(branch_prv)
			return 1 + num_nested_loops(cnf_dup, order, best_global, 1 + num_local_loops)
		end
		return 1000
	end
end