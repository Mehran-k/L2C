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

	def unit_clauses
		@clauses.select{|clause| clause.literals.size == 1}
	end

	def propagate(unit_clause)
		puts unit_clause.my2string
		puts "~~~~"
		puts self.my2string
		puts "~~~~~~~~~~~~~~~~~~"
		literal = unit_clause.literals[0]
		update_with_identifier(literal.prv, literal.value)
	end

	def adjust_weights(weight_function)
		new_function = weight_function
		@clauses.each do |clause|
			clause.literals.each do |literal|
				if !literal.prv.full_name.index("_r").nil?
					new_function[literal.prv.core_name] = weight_function[literal.prv.core_name[0..literal.prv.core_name.index("_r")-1]]
				end
			end
		end
		return new_function
	end

	def shatter #all changes are done together. I may have to do one shattering, then call shatter again. Or even do it a few times until nothing changes
		@clauses.each do |clause|
			clause.constraints.each do |constraint|
				remove_lv_neq_const(constraint.term1, constraint.term2) if constraint.lv_neq_const
			end
		end
		@clauses.each do |clause|
			clause.constraints.each do |constraint|
				if constraint.lv_neq_lv
					clause.literals.each do |literal|
						if literal.prv.logvars.size >= 2
							lv1_index = literal.prv.index_lv_with_name(constraint.term1.name)
							lv2_index = literal.prv.index_lv_with_name(constraint.term2.name)
							split(literal.prv, lv1_index, lv2_index) if lv1_index != -1 and lv2_index != -1 
						end
					end
				end
			end
		end
		@clauses.each do |clause|
			clause.literals.each do |literal|
				if literal.prv.num_lvs == 2 and literal.prv.num_distinct_lvs == 1
					split(literal.prv, 0, 1)
				end
			end
		end
		# @clauses.each {|clause| clause.remove_duplicate_lvs}
	end

	def remove_lv_neq_const(lv, const)
		@clauses.each {|clause| clause.remove_lv_neq_const(lv, const)}
	end

	def split(prv, lv1_index, lv2_index)
		@clauses.each do |clause|
			clause.literals.each do |literal|
				# if literal.prv.unique_identifier == prv.unique_identifier 
				if literal.name == prv.full_name
					if  literal.prv.logvars[lv1_index].name != literal.prv.logvars[lv2_index].name and !clause.has_constraint(literal.prv.logvars[lv1_index], literal.prv.logvars[lv2_index], "!=")
						clause_dup = clause.duplicate
						clause.add_constraint(literal.prv.logvars[lv1_index], literal.prv.logvars[lv2_index], "!=")
						# literal.prv.full_name = literal.prv.full_name + "_neq"
						clause_dup.replace_all_lvs(literal.prv.logvars[lv2_index], literal.prv.logvars[lv1_index])
						@clauses << clause_dup
					end
				end
			end
		end
	end

	def replace_prvs_having_same_lv
		@clauses.each do |clause|
			clause.literals.each do |literal|
				if(literal.prv.num_lvs != literal.prv.num_distinct_lvs)
					new_prv = literal.prv.remove_same_lvs
					replace_all_prvs(literal.prv, new_prv)
				end
			end
		end
	end

	def replace_all_prvs(prv1, prv2)
		@clauses.each do |clause|
			clause.replace_all_prvs(prv1, prv2)
		end
	end

	def connected_components #"friend(x,x)" and "friend(x,y), x!= y" are also disconnected. I should add this.
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

	def update_with_identifier(prv, value)
		@clauses.each do |clause|
			clause.literals.each do |literal|
				if  literal.prv.unique_identifier == prv.unique_identifier
					clause.is_true = true if literal.value == value

					clause.literals -= [literal] 
				end
			end
		end
	end

	def update(prv_name, value)
		@clauses.each do |clause|
			clause.literals.each do |literal|
				if  literal.name == prv_name
					clause.is_true = true  if literal.value == value
					clause.literals -= [literal] 
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
						clause1.add_to_prvs_name_addendum(lit_lv, "1")
						clause1.replace_all_lvs(lit_lv, new_lv1)
						clause2 = clause.duplicate
						clause2.add_to_prvs_name_addendum(lit_lv, "2")
						clause2.replace_all_lvs(lit_lv, new_lv2)
						@clauses += [clause1, clause2]
						@clauses -= [clause]
						break
					end
				end
			end
		end

		@clauses.each do |clause|
			clause.literals.each do |literal|
				literal.prv.confirm_name_addendum
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

	def ignore_all_constraints
		@clauses.each do |clause|
			clause.constraints = Array.new
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

	def fo2
		@clauses.each do |clause|
			return false if clause.num_distinct_lvs != 2
			clause.literals.each do |literal|
				return false if literal.prv.num_distinct_lvs != 2
			end
		end
		return true
	end

	def replace_individuals_for_fo2
		const1 = Constant.new("FO2_1")
		const2 = Constant.new("FO2_2")
		@clauses.each do |clause|
			lv1 = clause.logvars[0]
			lv2 = clause.logvars[1]
			clause.replace_all_lvs(lv1, const1)
			clause.replace_all_lvs(lv2, const2)
		end
		return true
	end

	def replace_no_lv_prvs_with_rvs
		@clauses.each do |clause|
			clause.literals.each do |literal|
				if literal.prv.num_lvs == 0
					new_prv = literal.prv.duplicate
					new_prv.full_name = literal.prv.my2string.gsub("(", "_").gsub(")", "_").gsub(",", "_")
					new_prv.terms = Array.new
					replace_all_prvs(literal.prv, new_prv)
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
			prv_names = prvs.map{|prv| prv.full_name}
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

	def decompose(lv_positions, prv_positions) #the constant names can be equal
		const = Constant.new("NC_" + @clauses[0].literals[0].prv.terms[lv_positions[prv_positions[@clauses[0].literals[0].name]]-1].name.upcase + "1")
		@clauses.each do |clause| 
			lv = clause.literals[0].prv.terms[lv_positions[prv_positions[clause.literals[0].name]]-1]
			clause.logvars.each_with_index {|logvar, i| clause.logvars[i] = const if logvar.name == lv.name}
			clause.literals.each {|literal| literal.prv.terms.each_with_index {|term, i| literal.prv.terms[i] = const if literal.prv.terms[i].class == LogVar and literal.prv.terms[i].name == lv.name}}
			clause.literals.each {|literal| literal.prv.terms[lv_positions[prv_positions[literal.name]]-1] = const}
			clause.constraints.each do |constraint|
				constraint.replace_terms(lv, const)
			end
		end
	end

	def next_prv(order)
		order.each {|prv_name| @clauses.each {|clause| clause.literals.each {|literal| return literal.prv if literal.prv.core_name == prv_name}}}
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
			# clause.logvars.select{|lv| lv.class == LogVar}.each do |lv| #some lvs might be already replaced
			# 	const = Constant.new((clause_type_counts[lv.type].to_i + 1).to_s << ":" << lv.type << ":" << lv.psize.to_s)
			# 	clause_type_counts[lv.type] = clause_type_counts[lv.type].to_i + 1
			# 	clause.replace_all_lvs(lv, const)
			# end
			clause_strings << clause.my2string
		end
		return clause_strings.sort.join
	end

	def my2string
		return "The CNF has no Clauses\n" if @clauses.size == 0
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
