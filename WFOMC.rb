class WFOMC
	attr_accessor :weights, :order, :counter, :noeffect_vars, :indent, :doubles, :max_pop_size, :num_iterate, :new_line

	def initialize(weights, max_pop_size)
		@weights = weights
		@counter = 1
		@noeffect_vars = Array.new
		@indent = "    "
		@doubles = Array.new
		@max_pop_size = max_pop_size
		@num_iterate = 0
		@new_line = "\n"
	end

	def set_order(order)
		@order = order
	end

	def get_doubles
		doubles = "double "
		doubles += @doubles.join(",") + "," if not @doubles.empty?
		@counter.times {|i| doubles << "v#{i+1}," if not @noeffect_vars.include? "v#{i+1}"}
		return doubles.chop
	end

	def eval_str(cnf, to_evaluate_clauses, v) #evaluates clauses that can be evaluated and generates appropriate string
		(@noeffect_vars.include? v) ? (return "0") : (return v) if to_evaluate_clauses.empty?
		str = ""
		all_prvs = cnf.get_all_prv_names
		already_counted = Array.new
		to_evaluate_clauses.each do |clause| 
			clause.literals.each do |literal|
				if not all_prvs.include? literal.name and not already_counted.include? literal.name
					if(@weights[literal.prv.core_name] == [0.0, 0.0])
						str += "0.6931471805*#{literal.prv.psize(clause.constraints)}+"
					else
						str += "sum(#{@weights[literal.prv.core_name][0]}, #{@weights[literal.prv.core_name][1]})*#{literal.prv.psize(clause.constraints)}+"
					end
					already_counted << literal.name
				end
			end
		end
		(@noeffect_vars.include? v) ? (return "0") : (return v) if str == ""
		(@noeffect_vars.include? v) ? (return "(" + str.chop + ")") : (return v + "+(" + str.chop + ")")
	end

	def after_branch_cpp_string(core_name, array_counter, loop_iterator, unit_prop_string, cnf, cache, to_evaluate, save_counter, branch_lv)
		str = ""
		compile(cnf, cache).each_line {|line| str << Helper.indent(3) + line}
		if(@weights[core_name] == [0, 0])
			str << Helper.indent(3) + "v#{array_counter}_arr[#{loop_iterator}]=C_#{loop_iterator}+#{unit_prop_string}#{eval_str(cnf, to_evaluate, 'v' + (save_counter).to_s)};\n"
		else
			str << Helper.indent(3) + "v#{array_counter}_arr[#{loop_iterator}]=C_#{loop_iterator}+#{unit_prop_string}(#{@weights[core_name][0]}*#{loop_iterator}+#{@weights[core_name][1]}*(#{branch_lv.psize}-#{loop_iterator}))+#{eval_str(cnf, to_evaluate, 'v' + (save_counter).to_s)};\n"
		end
		str << Helper.indent(2) + "}\n"
	end

	def compile(cnf, cache)

		# @num_iterate += 1
		# exit if @num_iterate > 60

		cnf_dup = cnf.duplicate
		str = ""
		save_counter = @counter
		@counter += 1

		if  cnf_dup.clauses.size == 0
			@noeffect_vars << "v#{save_counter}"
			return ""
		end

		cache_value = cache.get(cnf_dup)
		if not cache_value.nil?
			q_number = cache_value[0..cache_value.index(":")-1]
			return "v#{save_counter}=q#{q_number}.front(); q#{q_number}.pop();\n" 
		end
		return "v#{save_counter}=cache.at(\"#{cache_value}\");\n" if not cache_value.nil?

		#unit propagation
		unit_clauses = cnf_dup.unit_clauses
		if  unit_clauses.size > 0
			unit_prop_string, to_evaluate = cnf_dup.apply_unit_propagation(unit_clauses, @weights)
			return "v#{save_counter}=-2000;\n" if(unit_prop_string == "false")
			
			compile(cnf_dup, cache).each_line {|line| str << line}
			to_eval_string = eval_str(cnf_dup, to_evaluate, "v#{save_counter+1}")

			# if(save_counter != 1 and to_eval_string == "0" and unit_prop_string == "")
			if(to_eval_string == "0" and unit_prop_string == "")
				@noeffect_vars << "v#{save_counter}"
			elsif(to_eval_string == "v#{save_counter+1}" and unit_prop_string == "")
				str.gsub!("v#{save_counter+1}=", "v#{save_counter}=")
			else
				str += "v#{save_counter}=#{unit_prop_string}#{to_eval_string};\n"
			end
			return str
		end

		cc = cnf_dup.connected_components
		if  cc.size != 1
			product = ""#this is the product of all connected components
			cc.each_with_index do |cc_cnf, i|
				product += "v#{@counter}+"
				compile(cc_cnf, cache).each_line {|line| str += line}
			end
			return str << "v#{save_counter}=#{product.chop};\n" << cache.add(cnf, "v#{save_counter}")
		end

		pop_size, decomposer_lv_pos, prv_pos = cnf_dup.get_decomposer_lv
		if not decomposer_lv_pos.nil?
			decomposer_lv_type = cnf_dup.clauses[0].literals[0].prv.terms[decomposer_lv_pos[prv_pos[cnf_dup.clauses[0].literals[0].name]]-1].type
			cnf_dup.decompose(decomposer_lv_pos, prv_pos)
			# cnf_dup.remove_all_lv_neq_constant_constraints(false)
			cnf_dup.adjust_after_decomposition(decomposer_lv_type)
			cnf_dup.replace_no_lv_prvs_with_rvs
			compile(cnf_dup, cache).each_line {|line| str += line}
			str += "v#{save_counter}=v#{save_counter + 1}*(#{pop_size});\n"
			return str + cache.add(cnf, "v#{save_counter}")
		end

		if cnf_dup.fo2
			# puts "There are only 2lv logvars and the grounding is disconnected"
			has_neq_constraint = (cnf_dup.clauses[0].constraints.size > 0 ? true : false)
			psize = cnf_dup.clauses[0].logvars[0].psize
			cnf_dup.replace_individuals_for_fo2
			# cnf_dup.remove_all_lv_neq_constant_constraints(false)
			cnf_dup.replace_no_lv_prvs_with_rvs
			str = ""
			compile(cnf_dup, cache).each_line {|line| str += line}
			str += "v#{save_counter}=v#{save_counter+1}*(#{psize} * (#{psize} - 1) / 2.0);\n"
			return str + cache.add(cnf, "v#{save_counter}")
		end

		branch_prv = cnf_dup.next_prv(@order)
		# puts "Order: " + @order.join(",")
		# puts "No rules can be applied. Branching on: " + branch_prv.my2string

		if  branch_prv.num_distinct_lvs == 0
			cnf_dup.update(branch_prv.full_name, "true")
			to_evaluate = cnf_dup.clauses.select{|clause| clause.can_be_evaluated?}
			cnf_dup.clauses -= to_evaluate

			cnf_dup2 = cnf.duplicate
			cnf_dup2.update(branch_prv.full_name, "false")
			to_evaluate2 = cnf_dup2.clauses.select{|clause| clause.can_be_evaluated?}
			cnf_dup2.clauses -= to_evaluate2
			compile(cnf_dup, cache).each_line {|line| str << line}
			save_counter2 = @counter
			compile(cnf_dup2, cache).each_line {|line| str << line}

			str << "v#{save_counter}=sum(#{@weights[branch_prv.core_name][0]}+#{eval_str(cnf_dup, to_evaluate, 'v' + (save_counter+1).to_s)},#{@weights[branch_prv.core_name][1]}+#{eval_str(cnf_dup2, to_evaluate2, 'v' + (save_counter2).to_s)});\n"
			str << cache.add(cnf, "v#{save_counter}")
			return str

		elsif branch_prv.num_distinct_lvs == 1
			array_counter = save_counter
			save_counter = @counter
			branch_lv = branch_prv.first_lv
			str << "if(#{branch_lv.psize}==0){\n"
			cnf_dup_00 = cnf.duplicate
			cnf_dup_00.remove_clauses_having_logvar(branch_lv)

			compile(cnf_dup_00, cache.duplicate).each_line {|line| str << Helper.indent(1) + line}
			str << Helper.indent(1) + "v#{array_counter}=#{eval_str(cnf_dup_00, Array.new, 'v' + (save_counter).to_s)};\n"
			str << "}\n"

			if(cnf_dup.has_lv_neq_lv_constraint_with_type? (branch_lv.type))
				save_counter = @counter
				str << "if(#{branch_lv.psize}==1){\n"
				cnf_dup_1 = cnf.duplicate
				cnf_dup_1.remove_pop1_constraints(branch_lv)
				to_evaluate = cnf_dup_1.clauses.select{|clause| clause.can_be_evaluated?}
				cnf_dup_1.clauses -= to_evaluate

				compile(cnf_dup_1, cache.duplicate).each_line {|line| str << Helper.indent(1) + line}
				str << Helper.indent(1) + "v#{array_counter}=#{eval_str(cnf_dup_1, to_evaluate, 'v' + (save_counter).to_s)};\n"
				str << "}\n"
			end

			save_counter = @counter
			str << "else{\n"
			str << Helper.indent(1) + "double v#{array_counter}_arr[MAX];\n"
			loop_iterator = "i_" + branch_prv.full_name + "_i"
			str << Helper.indent(1) + "C_#{loop_iterator}=0;#{@new_line}"
			@doubles |= ["C_#{loop_iterator}"]
			str << Helper.indent(1) + "for(int #{loop_iterator}=0;#{loop_iterator}<=#{branch_lv.psize};#{loop_iterator}++){\n"			
			
			str << Helper.indent(2) + "if(#{loop_iterator}==0){\n"
			cnf_dup_0 = cnf.duplicate
			clause_0 = Clause.new([branch_prv.lit("false")], Array.new)
			cnf_dup_0.clauses << clause_0

			compile(cnf_dup_0, cache.duplicate).each_line {|line| str << Helper.indent(3) + line}
			if(@noeffect_vars.include? "v#{save_counter}")
				str << Helper.indent(3) + "v#{array_counter}_arr[#{loop_iterator}]=0;\n"
			else
				str.gsub!("v#{save_counter}=", "v#{array_counter}_arr[#{loop_iterator}]=")
			end
			# str << Helper.indent(3) + "v#{array_counter}_arr[#{loop_iterator}]=" + ((@noeffect_vars.include? "v#{save_counter}") ? "0" : "v#{save_counter}") + ";\n"
			save_counter = @counter
			str << Helper.indent(2) + "}\n"
			str << Helper.indent(2) + "else if(#{loop_iterator}==#{branch_lv.psize}){\n"
			cnf_dup_n = cnf.duplicate
			clause_n = Clause.new([branch_prv.lit("true")], Array.new)
			cnf_dup_n.clauses << clause_n

			compile(cnf_dup_n, cache.duplicate).each_line {|line| str << Helper.indent(3) + line}
			if(@noeffect_vars.include? "v#{save_counter}")
				str << Helper.indent(3) + "v#{array_counter}_arr[#{loop_iterator}]=0;\n"
			else
				str.gsub!("v#{save_counter}=", "v#{array_counter}_arr[#{loop_iterator}]=")
			end
			# str << Helper.indent(3) + "v#{array_counter}_arr[#{loop_iterator}]=" + ((@noeffect_vars.include? "v#{save_counter}") ? "0" : "v#{save_counter}") + ";\n"
			str << Helper.indent(2) + "}\n"
			
			cnf_dup_loop = cnf.duplicate
			cnf_dup_loop.branch(branch_prv, "#{loop_iterator}")
			cnf_dup_loop.apply_branch_observation(branch_prv)
			cnf_dup_loop.remove_resolved_constraints
			to_evaluate = cnf_dup_loop.clauses.select{|clause| clause.can_be_evaluated?}
			cnf_dup_loop.clauses -= to_evaluate

			#~~~~ Unit propagation before going to each case. Note we do unit propagation only on clauses with no constraints because the ones having constraints may be changed during special cases.~~~~#
			unit_prop_string = ""
			unit_clauses = cnf_dup_loop.unit_clauses.select{|clause| clause.constraints.empty?}
			if  unit_clauses.size > 0
				unit_prop_string, to_evaluate = cnf_dup_loop.apply_unit_propagation(unit_clauses, @weights)
				if(unit_prop_string == "false")
					str << Helper.indent(2) + "else{\n"
					str << Helper.indent(3) + "v#{array_counter}_arr[#{loop_iterator}]=-2000;\n"
					str << Helper.indent(2) + "}\n"
					str << Helper.indent(1) + "}\n"
					str << Helper.indent(1) + "v#{array_counter}=sum_arr(v#{array_counter}_arr, #{branch_lv.psize});" + "\n" + cache.add(cnf, "v#{array_counter}")
					str << "}\n"
					return str
				end
				to_evaluate2 = cnf_dup_loop.clauses.select{|clause| clause.can_be_evaluated?}
				cnf_dup_loop.clauses -= to_evaluate2.to_a

				to_evaluate = to_evaluate.to_a + to_evaluate2.to_a
				to_evaluate = nil if to_evaluate.empty?
			end

			if(cnf_dup_loop.has_lv_neq_lv_constraint_with_type? (branch_lv.type + "1") and cnf_dup_loop.has_lv_neq_lv_constraint_with_type? (branch_lv.type + "2"))
				save_counter = @counter
				str += Helper.indent(2) + "else if(#{loop_iterator}==1 && #{branch_lv.psize}==2){\n"
				cnf_dup_loop_11 = cnf_dup_loop.duplicate
				cnf_dup_loop_11.clauses.each {|clause| clause.is_true = true if clause.has_lv_neq_lv_constraint_with_type?(branch_lv.type + "1")}
				cnf_dup_loop_11.clauses.each {|clause| clause.is_true = true if clause.has_lv_neq_lv_constraint_with_type?(branch_lv.type + "2")}
				to_evaluate2 = cnf_dup_loop_11.clauses.select{|clause| clause.can_be_evaluated?}
				cnf_dup_loop_11.clauses -= to_evaluate2
				str << after_branch_cpp_string(branch_prv.core_name, array_counter, loop_iterator, unit_prop_string, cnf_dup_loop_11, cache.duplicate, to_evaluate + to_evaluate2, save_counter, branch_lv)
			end
			if(cnf_dup_loop.has_lv_neq_lv_constraint_with_type? (branch_lv.type + "1"))
				save_counter = @counter
				str << Helper.indent(2) + "else if(#{loop_iterator}==1){\n"
				cnf_dup_loop_1n = cnf_dup_loop.duplicate
				cnf_dup_loop_1n.clauses.each {|clause| clause.is_true = true if clause.has_lv_neq_lv_constraint_with_type?(branch_lv.type + "1")}
				to_evaluate2 = cnf_dup_loop_1n.clauses.select{|clause| clause.can_be_evaluated?}
				cnf_dup_loop_1n.clauses -= to_evaluate2
				if(branch_prv.core_name == "G")
					puts cnf_dup_loop_1n.my2string
				end
				str << after_branch_cpp_string(branch_prv.core_name, array_counter, loop_iterator, unit_prop_string, cnf_dup_loop_1n, cache.duplicate, to_evaluate + to_evaluate2, save_counter, branch_lv)
			end
			if(cnf_dup_loop.has_lv_neq_lv_constraint_with_type? (branch_lv.type + "2"))
				save_counter = counter
				str << Helper.indent(2) + "else if(#{loop_iterator}==#{branch_lv.psize}-1){\n"
				cnf_dup_loop_n1 = cnf_dup_loop.duplicate
				cnf_dup_loop_n1 = cnf_dup_loop.duplicate
				cnf_dup_loop_n1.clauses.each {|clause| clause.is_true = true if clause.has_lv_neq_lv_constraint_with_type?(branch_lv.type + "2")}
				to_evaluate2 = cnf_dup_loop_n1.clauses.select{|clause| clause.can_be_evaluated?}
				cnf_dup_loop_n1.clauses -= to_evaluate2
				str << after_branch_cpp_string(branch_prv.core_name, array_counter, loop_iterator, unit_prop_string, cnf_dup_loop_n1, cache.duplicate, to_evaluate + to_evaluate2, save_counter, branch_lv)
			end
			save_counter = counter
			str << Helper.indent(2) + "else{\n"
			cnf_dup_loop.remove_resolved_constraints
			str << after_branch_cpp_string(branch_prv.core_name, array_counter, loop_iterator, unit_prop_string, cnf_dup_loop, cache.duplicate, to_evaluate, save_counter, branch_lv)
			
			str << Helper.indent(2) + "C_#{loop_iterator}=(C_#{loop_iterator}-logs[#{loop_iterator}+1])+logs[(#{branch_lv.psize})-#{loop_iterator}];#{@new_line}"
			str << Helper.indent(1) + "}\n"
			str << Helper.indent(1) + "v#{array_counter}=sum_arr(v#{array_counter}_arr, #{branch_lv.psize});" + "\n" + cache.add(cnf, "v#{array_counter}")
			str << "}\n"
			return str
		else
			puts cnf_dup.my2string
			Helper.error("The input theory is not liftable")
		end
	end
end