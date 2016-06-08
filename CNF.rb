class CNF
	attr_accessor :clauses

	def initialize(clauses)
		@clauses = clauses
	end

	def get_all_prv_names
		return @clauses.inject(Array.new){|result, clause| result |= clause.literals.map{|literal| literal.name}.uniq}
	end

	def get_all_prv_sizes #returns a hash: the keys are prv_names and the values are [num_lvs, psize]
		return @clauses.inject(Array.new){|result, clause| result += clause.literals.map{|literal| [literal.name, [literal.prv.num_lvs, literal.prv.num_psize]]}}.uniq.to_h
	end

	def connected_components
		return [] if @clauses.empty?
		cnf_dup = self.duplicate
		cc = Array.new
		cc << cnf_dup.clauses.shift
		prv_names = cc.first.literals.map{|literal| literal.name}.uniq
		
		something_changed = true
		while something_changed
			something_changed = false
			cnf_dup.clauses.each_with_index do |clause, i|
				clause_prv_names = clause.literals.map{|literal| literal.name}.uniq
				if  (prv_names & clause_prv_names).size != 0
					cc << clause
					cnf_dup.clauses -= [clause]
					something_changed = true if (clause_prv_names - prv_names).size != 0
					prv_names |= clause_prv_names
				end
			end
		end
		return (@clauses.size == cc.size) ? [CNF.new(cc)] : [CNF.new(cc)] + CNF.new(cnf_dup.clauses).connected_components
	end

	def update(prv_name, value)
		@clauses.each do |clause|
			clause.literals.each do |literal|
				if  literal.name == prv_name
					if literal.value != value
						clause.literals -= [literal] 
					else
						clause.is_true = true 
					end
				end
			end
		end
	end

	def branch(branch_prv, num_true)
		lv = branch_prv.first_lv

		something_changed = true
		while something_changed
			something_changed = false
			@clauses.each do |clause|
				clause.literals.each do |literal|
					lit_lv = literal.prv.first_lv_with_type(lv.type)
					if  not lit_lv.nil?
						something_changed = true
						new_lv1 = LogVar.new(lit_lv.name + "1", lit_lv.domain, num_true, lit_lv.type + "1")
						new_lv2 = LogVar.new(lit_lv.name + "2", lit_lv.domain, lv.psize.to_s +  "-" + num_true, lit_lv.type + "2")
						clause1 = clause.duplicate
						clause1.change_prv_names(lit_lv, "1")
						clause1.replace_all_lvs(lit_lv, new_lv1)
						clause2 = clause.duplicate
						clause2.change_prv_names(lit_lv, "2")
						clause2.replace_all_lvs(lit_lv, new_lv2)
						@clauses += [clause1, clause2]
						@clauses -= [clause]
						break
					end
				end
			end
		end
	end

	def apply_branch_observation(branch_prv)
		update(branch_prv.full_name + "1", "true")
		update(branch_prv.full_name + "2", "false")
	end

	def remove_resolved_constraints
		@clauses.each do |clause|
			clause.constraints.select!{|constraint| !constraint.is_resolved}
		end
	end

	def ground(logvar)
		something_changed = true
		while something_changed
			something_changed = false
			@clauses.each do |clause|
				clause.literals.each do |literal|
					lit_lv = literal.prv.first_lv_with_type(logvar.type)
					if  not lit_lv.nil?
						something_changed = true
						(1..lit_lv.num_psize).each do |i|
							new_const = Constant.new(logvar.name.upcase + i.to_s)
							new_clause = clause.duplicate
							new_clause.change_prv_names(lit_lv, i.to_s)
							new_clause.replace_all_lvs(lit_lv, new_const)
							@clauses << new_clause
						end
						@clauses -= [clause]
						break
					end
				end
			end
		end
	end

	def get_decomposer_lv
		possible_positions = Array.new #represents which lv of prvs can be potentially replaced by a constant
		num_loop_itr = 1
		prvs = Array.new
		position = Hash.new
		
		@clauses.each do |clause|
			prv_names = prvs.map{|prv| prv.name}
			(clause.literals.select{|literal| not prv_names.include? literal.name}).each do |new_literal|
				prvs << new_literal.prv
				position[new_literal.name] = prvs.size - 1
			end
		end

		prvs.each_with_index do |prv, i|
			return [nil, nil, nil] if prv.num_lvs == 0
			possible_positions[i] = prv.terms.size
			num_loop_itr *= possible_positions[i]
		end
		current_position = Array.new(prvs.size, 1)
		num_loop_itr.times do 
			iteration_failed = false
			@clauses.each do |clause|
				dec_lv = clause.literals[0].prv.terms[current_position[position[clause.literals[0].name]]-1]
				clause.literals.each {|literal| iteration_failed = true if literal.prv.terms[current_position[position[literal.name]]-1].class != LogVar or literal.prv.terms[current_position[position[literal.name]]-1].name != dec_lv.name}
				break if iteration_failed
			end
			return [@clauses[0].literals[0].prv.terms[current_position[position[@clauses[0].literals[0].name]]-1].psize, current_position, position] if not iteration_failed

			#current position +1
			current_position.each_with_index do |entry, i|
				current_position[i] += 1
				break if current_position[i] <= possible_positions[i]
				current_position[i] = 1
			end
		end
		return [nil, nil, nil]
	end

	def decompose(lv_positions, prv_positions) 
		const = Constant.new(@clauses[0].literals[0].prv.terms[lv_positions[prv_positions[@clauses[0].literals[0].name]]-1].name.upcase + "1")
		@clauses.each do |clause| 
			lv = clause.literals[0].prv.terms[lv_positions[prv_positions[clause.literals[0].name]]-1]
			clause.logvars.each_with_index {|logvar, i| clause.logvars[i] = const if logvar.name == lv.name}
			clause.literals.each {|literal| literal.prv.terms[lv_positions[prv_positions[literal.name]]-1] = const}
		end
	end

	def next_prv(order)
		order.each {|prv_name| @clauses.each {|clause| clause.literals.each {|literal| return literal.prv if literal.name.start_with? prv_name}}}
	end

	def min_nested_loop_order(num_iterations)#does hill climbing on the minTableSize order to minimize the number of nested loops
		if  (num_iterations > (1..self.get_all_prv_names.size-1).reduce(1, :*)) #in the number of iterations is more than the maximum number of permutations, we can simply test all permutations
			min_nested_loops = 9999
			order = []
			(get_all_prv_names).permutation.each do |new_order|
				num_nested_loops = self.duplicate.num_nested_loops(new_order, min_nested_loops, 0)
				if  num_nested_loops < min_nested_loops
					min_nested_loops = num_nested_loops
					order = new_order.dup
				end
			end
		else #else we should do hill climbing num_iteration times
			order = self.duplicate.min_table_size_order
			# min_nested_loops = self.duplicate.num_nested_loops(order, 9999, 0) 
			num_iterations.times do |i|
				new_order = order.dup
				r1 = rand(order.size-1) + 1
				r2 = rand(order.size-1) + 1
				r2 = rand(order.size-1) + 1 while(r2 == r1)
				new_order[r1], new_order[r2] = new_order[r2], new_order[r1]
				num_nested_loops = self.duplicate.num_nested_loops(new_order, min_nested_loops, 0)
				if  num_nested_loops < min_nested_loops
					min_nested_loops = num_nested_loops
					order = new_order.dup
				end
			end	
		end
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
		self.duplicate.clauses.each do |clause|
			clause_prv_names = clause.literals.map{|literal| literal.name}
			clause.literals.each {|literal| parfactors[literal.name] = parfactors[literal.name].to_a | (clause_prv_names - [literal.name])}
		end
		return min_table_size(parfactors, get_all_prv_sizes)
	end

	def num_nested_loops(order, best_global, num_local_loops)
		return 0 if @clauses.size == 0
		@clauses.select!{|clause| not clause.can_be_evaluated}
		cc = connected_components
		return cc.inject(0){|result, cc_cnf| result = [result, cc_cnf.num_nested_loops(order, best_global, num_local_loops)].max} if cc.size != 1
		pop_size, decomposer_lv_pos, prv_pos = get_decomposer_lv
		if not decomposer_lv_pos.nil?
			decompose(decomposer_lv_pos, prv_pos)
			return num_nested_loops(order, best_global, num_local_loops) 
		end
		branch_prv = next_prv(order)
		if branch_prv.num_lvs == 0
			cnf_dup1 = duplicate
			cnf_dup1.update(branch_prv.name, "true")
			nnl1 = cnf_dup1.num_nested_loops(order, best_global, num_local_loops)
			return 1000 if nnl1 >= 1000
			cnf_dup2 = duplicate
			cnf_dup2.update(branch_prv.name, "false")
			nnl2 = cnf_dup2.num_nested_loops(order, best_global, num_local_loops)
			return [nnl1, nnl2].max
		elsif branch_prv.num_lvs == 1
			return 1000 if (1 + num_local_loops) >= best_global
			branch_lv = branch_prv.first_lv
			branch(branch_prv, "0")
			apply_branch_observation(branch_prv)
			return 1 + num_nested_loops(order, best_global, 1 + num_local_loops)
		end
		return 1000
	end

	def has_no_lvs
		@clauses.each {|clause| clause.literals.each {|literal| return false if literal.prv.num_lvs > 0}}
		return true
	end

	def unique_identifier
		cnf_dup = self.duplicate

		clause_strings = Array.new
		cnf_dup.clauses.each do |clause|
			clause_type_counts = Hash.new
			clause.literals.each do |literal|
				literal.prv.logvars.each do |lv|
					const = Constant.new((clause_type_counts[lv.type].to_i + 1).to_s << ":" << lv.type << ":" << lv.psize.to_s)
					clause_type_counts[lv.type] = clause_type_counts[lv.type].to_i + 1
					clause.replace_all_lvs(lv, const)
				end
			end
			clause.logvars.select{|lv| lv.class == LogVar}.each do |lv| #some lvs might be already replaced
				const = Constant.new((clause_type_counts[lv.type].to_i + 1).to_s << ":" << lv.type << ":" << lv.psize.to_s)
				clause_type_counts[lv.type] = clause_type_counts[lv.type].to_i + 1
				clause.replace_all_lvs(lv, const)
			end
			clause_strings << clause.my_to_string
		end
		return clause_strings.sort.join
	end

	def my2string
		str = ""
		@clauses.each do |clause|
			str += clause.my2string + "\n"
		end
		return str
	end

	def duplicate
		Marshal::load(Marshal.dump(self))
	end
end
