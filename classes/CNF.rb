#Copyright (C) 2016  Seyed Mehran Kazemi, Licensed under the GPL V3; see: <https://www.gnu.org/licenses/gpl-3.0.en.html>

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

	def get_all_prvs
		prvs = Hash.new
		@clauses.each {|clause| clause.literals.each {|literal| prvs[literal.name] = literal.prv if prvs[literal.name].nil?}}
		return prvs.values
	end

	def max_pop_size
		return @clauses.map{|clause| clause.get_all_distinct_lvs.map{|lv| lv.psize.to_i}}.flatten.max.to_i
	end

	def has_prv_with_core_name?(core_name)
		get_all_prvs.map{|prv| prv.core_name}.include? core_name
	end

	def literals
		@clauses.map{|clause| clause.literals}.flatten
	end

	def has_false_clause
		@clauses.each {|clause| return true if clause.is_false}
		return false
	end

	def replace_parameters(param, number)
		@clauses.each {|clause| clause.replace_parameters(param, number)}
	end

	def unit_clauses
		@clauses.select{|clause| clause.literals.size == 1}
	end

	def propagate(unit_clause)
		literal = unit_clause.literals[0]
		update_with_identifier(literal.prv, literal.value)
	end

	def adjust_weights(weight_function) #I add _r0-9 to the PRVs having two LVs with same name and remove one of the LVs. These PRVs must have the same weight.
		new_function = weight_function
		literals.each {|literal| new_function[literal.prv.core_name] = weight_function[literal.prv.core_name[0..literal.prv.core_name.index("_r")-1]] if !literal.prv.full_name.index("_r").nil?}
		return new_function
	end

	def replace_all_lvs_with_type(old_type, new_term)
		@Clauses.each{|clause| clause.replace_all_lvs_with_type(old_type, new_term)}
	end

	def remove_pop1_constraints(lv)
		@clauses.each do |clause|
			clause.constraints.each do |constraint|
				if constraint.match_type2?(lv.type, "!=")
					clause.constraints -= [constraint]
					clause.is_true = true
				end
			end
		end
	end

	def remove_clauses_having_logvar(lv)
		@clauses.select!{|clause| not (clause.has_lv_with_type? (lv.type))}
	end

	def preemptive_shatter
		@clauses.each do |clause|
			all_lvs = clause.get_all_distinct_lvs
			(0..all_lvs.size-1).each do |i|
				(i+1..all_lvs.size-1).each do |j|
					if(all_lvs[i].type == all_lvs[j].type and not clause.has_constraint_with_name?(all_lvs[i], all_lvs[j], "!="))
						clause_dup = clause.duplicate
						clause.add_constraint(all_lvs[i], all_lvs[j], "!=")
						clause_dup.replace_all_lvs(all_lvs[j], all_lvs[i])
						@clauses << clause_dup
					elsif(all_lvs[i].type == all_lvs[j].type and clause.has_constraint_with_name?(all_lvs[i], all_lvs[j], "!="))
						clause.literals.each do |literal|
							index1 = literal.prv.index_lv_with_name(all_lvs[i].name)
							index2 = literal.prv.index_lv_with_name(all_lvs[j].name)
							if index1 != -1 and index2 != -1
								literal_prv = literal.prv.duplicate
								literal_prv.replace_all_lvs(all_lvs[j], all_lvs[i])
								@clauses << Clause.new([literal_prv.lit("true"), literal_prv.lit("false")], Array.new)
							end
						end
					end
				end
			end
		end
		@clauses.each {|clause| clause.literals.each_with_index {|literal, i| clause.literals[i].prv = literal.prv.remove_same_lvs}}
	end

	def replace_prvs_having_same_lv
		literals.select{|literal| }.each do |literal|
			if(literal.prv.num_lvs != literal.prv.num_distinct_lvs)
				new_prv = literal.prv.remove_same_lvs
				replace_all_prvs(literal.prv, new_prv)
			end
		end
	end

	def replace_all_prvs(prv1, prv2)
		@clauses.each {|clause| clause.replace_all_prvs(prv1, prv2)}
	end

	def connected_components
		return [] if @clauses.empty?
		cnf_dup = self.duplicate
		cc = Array.new
		cc << cnf_dup.clauses.shift
		prv_names = cc.first.all_prv_names.uniq
		
		something_changed = true
		while something_changed
			something_changed = false
			cnf_dup.clauses.each_with_index do |clause, i|
				clause_prv_names = clause.all_prv_names.uniq
				if  (prv_names & clause_prv_names).size != 0
					cc << clause
					cnf_dup.clauses -= [clause]
					something_changed = true if (clause_prv_names - prv_names).size != 0
					prv_names |= clause_prv_names
				end
			end
		end
		return (cnf_dup.clauses.size == 0) ? [CNF.new(cc)] : [CNF.new(cc)] + CNF.new(cnf_dup.clauses).connected_components
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

		@clauses.each {|clause| clause.literals.each {|literal| literal.prv.confirm_name_addendum}}
	end

	def apply_branch_observation(branch_prv)
		update(branch_prv.full_name + "1", "true")
		update(branch_prv.full_name + "2", "false")
	end

	def remove_resolved_constraints
		@clauses.each {|clause| clause.constraints.select!{|constraint| !constraint.is_resolved?}}
	end

	def ignore_all_constraints
		@clauses.each {|clause| clause.constraints = Array.new}
	end

	def replace_all_lvs_with_type(old_type, new_term)
		@clauses.each {|clause| clause.replace_all_lvs_with_type(old_type, new_term)}
	end

	def fo2
		@clauses.each do |clause|
			return false if clause.num_distinct_lvs != 2
			clause.literals.each {|literal| return false if literal.prv.num_distinct_lvs != 2}
		end
		return true
	end

	def replace_individuals_for_fo2
		const1 = Constant.new("FO2_1")
		const2 = Constant.new("FO2_2")
		new_clauses = Array.new
		@clauses.each do |clause|
			lv1 = clause.get_all_distinct_lvs[0]
			lv2 = clause.get_all_distinct_lvs[1]
			clause_dup = clause.duplicate
			clause.replace_all_lvs(lv1, const1)
			clause.replace_all_lvs(lv2, const2)
			clause_dup.replace_all_lvs(lv2, const1)
			clause_dup.replace_all_lvs(lv1, const2)
			new_clauses << clause_dup
		end
		@clauses += new_clauses
	end

	def replace_no_lv_prvs_with_rvs
		literals.each do |literal|
			if literal.prv.num_lvs == 0
				new_prv = literal.prv.duplicate
				new_prv.full_name = literal.prv.my2string.gsub("(", "_").gsub(")", "_").gsub(",", "_")
				new_prv.terms = Array.new
				replace_all_prvs(literal.prv, new_prv)
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
			clause.literals.each {|literal| literal.prv.terms.each_with_index {|term, i| literal.prv.terms[i] = const if literal.prv.terms[i].class == LogVar and literal.prv.terms[i].name == lv.name}}
			clause.literals.each {|literal| literal.prv.terms[lv_positions[prv_positions[literal.name]]-1] = const}
			clause.constraints.each {|constraint| constraint.replace_terms(lv, const)}
		end
	end

	def adjust_after_decomposition(type)
		@clauses.each {|clause| clause.constraints.select!{|constraint| not constraint.lv_neq_const?}}
		@clauses.each {|clause| clause.literals.each {|literal| literal.prv.logvars.each {|lv| lv.decrement_psize if lv.type == type}}}
	end

	def next_prv(order)
		order.each {|prv_name| @clauses.each {|clause| clause.literals.each {|literal| return literal.prv if literal.prv.core_name == prv_name}}}
		return nil
	end

	def has_no_lvs
		@clauses.each {|clause| clause.literals.each {|literal| return false if literal.prv.num_lvs > 0}}
		return true
	end

	def has_lv_neq_lv_constraint_with_type? (lv)
		@clauses.each {|clause| return true if clause.has_lv_neq_lv_constraint_with_type? (lv)}
		return false
	end

	def break_lv_neq_lv_to_lv_neq_constant(type, constant)
		@clauses.each {|clause| clause.break_lv_neq_lv_to_lv_neq_constant(type, constant)}
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
			clause_strings << clause.my2string
		end
		return clause_strings.sort.join
	end

	def apply_unit_propagation(unit_clauses, weights)
		unit_weights = ""
		unit_clauses.each do |unit_clause|
			if(unit_clause.literals.size > 0) #previous unit clauses may make others disapper
				literal = unit_clause.literals[0]
				value = literal.value
				if(value == "true" and weights[literal.prv.core_name][0] != 0.0)
					unit_weights << weights[literal.prv.core_name][0].to_s + "*" + literal.prv.psize(unit_clause.constraints).to_s + "+"
				elsif(value == "false" and weights[literal.prv.core_name][1] != 0.0) 
					unit_weights << weights[literal.prv.core_name][1].to_s + "*" + literal.prv.psize(unit_clause.constraints).to_s + "+"
				end
				self.propagate(unit_clause)
				self.remove_resolved_constraints
			end
		end
		return ["false", nil] if self.has_false_clause
		
		to_evaluate = self.clauses.select{|clause| clause.can_be_evaluated?}
		self.clauses -= to_evaluate
		
		return ["#{unit_weights}", to_evaluate]
	end

	def my2string
		return "The CNF has no Clauses\n" if @clauses.size == 0
		return @clauses.map{|clause| clause.my2string + "\n"}.join("")
	end

	def duplicate
		Marshal::load(Marshal.dump(self))
	end
end
