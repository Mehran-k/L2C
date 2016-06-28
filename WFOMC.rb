class WFOMC
	attr_accessor :weights, :order, :counter, :noeffect_vars, :doubles, :cache

	def initialize(weights)
		@cache = Cache.new
		@weights = weights
		@counter = 1
		@noeffect_vars = Array.new
		@doubles = Array.new
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

	def after_branch_cpp_string(core_name, array_counter, loop_iterator, cnf, to_evaluate, save_counter, branch_lv, with_cache)
		str = ""
		compile(cnf, with_cache).each_line {|line| str << Helper.indent(3) + line}
		if(@weights[core_name] == [0, 0])
			str << Helper.indent(3) + "v#{array_counter}_arr[#{loop_iterator}]=C_#{loop_iterator}+#{eval_str(cnf, to_evaluate, 'v' + (save_counter).to_s)};\n"
		else
			str << Helper.indent(3) + "v#{array_counter}_arr[#{loop_iterator}]=C_#{loop_iterator}+(#{@weights[core_name][0]}*#{loop_iterator}+#{@weights[core_name][1]}*(#{branch_lv.psize}-#{loop_iterator}))+#{eval_str(cnf, to_evaluate, 'v' + (save_counter).to_s)};\n"
		end
		return str
	end

	def branching_for_psize_0_string(cnf, branch_lv, array_counter, save_counter, with_cache)
		str = ""
		cnf_dup_00 = cnf.duplicate
		cnf_dup_00.remove_clauses_having_logvar(branch_lv)
		compile(cnf_dup_00, with_cache).each_line {|line| str << Helper.indent(1) + line}
		str << Helper.indent(1) + "v#{array_counter}=#{eval_str(cnf_dup_00, Array.new, 'v' + (save_counter).to_s)};\n"
		return str
	end

	def branching_for_psize_1_string(cnf, branch_lv, array_counter, save_counter, with_cache)
		str = ""
		cnf_dup_1 = cnf.duplicate
		cnf_dup_1.remove_pop1_constraints(branch_lv)
		to_evaluate = cnf_dup_1.clauses.select{|clause| clause.can_be_evaluated?}
		cnf_dup_1.clauses -= to_evaluate

		constant = Constant.new(branch_lv.type.upcase + "_P1")
		cnf_dup_1.replace_all_lvs_with_type(branch_lv.type, constant)

		compile(cnf_dup_1, with_cache).each_line {|line| str << Helper.indent(1) + line}
		str << Helper.indent(1) + "v#{array_counter}=#{eval_str(cnf_dup_1, to_evaluate, 'v' + (save_counter).to_s)};\n"
		return str
	end

	def branching_for_boundaries(cnf, loop_iterator, array_counter, save_counter, branch_prv, boundary, with_cache)
		str = ""
		cnf_dup = cnf.duplicate
		clause = Clause.new([branch_prv.lit((boundary == "0" ? "false" : "true"))], Array.new)
		cnf_dup.clauses << clause

		compile(cnf_dup, false).each_line {|line| str << Helper.indent(3) + line}
		if(@noeffect_vars.include? "v#{save_counter}")
			str << Helper.indent(3) + "v#{array_counter}_arr[#{loop_iterator}]=0;\n"
		else
			str.gsub!("v#{save_counter}=", "v#{array_counter}_arr[#{loop_iterator}]=")
		end
		return str
	end

	def branching_for_11(cnf, branch_prv, array_counter, loop_iterator, to_evaluate, save_counter, branch_lv, first_is_1, second_is_1, with_cache)
		str = ""
		cnf_dup_loop_11 = cnf.duplicate
		to_evaluate2 = Array.new
		#Note: to_evaluate must be determined before replacing the logvars with constants. Otherwise, literals such as F(const, const) are generated even though there is a x != y constraint
		if first_is_1
			cnf_dup_loop_11.clauses.each {|clause| clause.is_true = true if clause.has_lv_neq_lv_constraint_with_type?(branch_lv.type + "1")} 
			to_evaluate2 = cnf_dup_loop_11.clauses.select{|clause| clause.can_be_evaluated?}
			cnf_dup_loop_11.clauses -= to_evaluate2
			constant = Constant.new(branch_lv.type.upcase + "1" + "_P1")
			cnf_dup_loop_11.replace_all_lvs_with_type(branch_lv.type + "1", constant)
			cnf_dup_loop_11.replace_parameters(loop_iterator, "1")
		end
		if second_is_1
			cnf_dup_loop_11.clauses.each {|clause| clause.is_true = true if clause.has_lv_neq_lv_constraint_with_type?(branch_lv.type + "2")} 
			to_evaluate2 = cnf_dup_loop_11.clauses.select{|clause| clause.can_be_evaluated?}
			cnf_dup_loop_11.clauses -= to_evaluate2
			constant = Constant.new(branch_lv.type.upcase + "2" + "_P1")
			cnf_dup_loop_11.replace_all_lvs_with_type(branch_lv.type + "2", constant)
			cnf_dup_loop_11.replace_parameters(branch_lv.psize + "-" + loop_iterator, "1")
			cnf_dup_loop_11.replace_parameters(loop_iterator, (Helper.num_value(branch_lv.psize + "-1").to_s)) if(not Helper.num_value(branch_lv.psize + "-1").nil?)			
		end

		str << after_branch_cpp_string(branch_prv.core_name, array_counter, loop_iterator, cnf_dup_loop_11, to_evaluate + to_evaluate2, save_counter, branch_lv, with_cache)
		return str
	end

	def loop_string(array_counter, branch_prv, branch_lv, cnf, branch_lv_num_psize, with_cache)
		str = ""
		cnf_dup = cnf.duplicate
		save_counter = @counter
		str << Helper.indent(1) + "double v#{array_counter}_arr[MAX];\n"
		loop_iterator = "i_" + branch_prv.full_name + "_i"
		str << Helper.indent(1) + "C_#{loop_iterator}=0;\n"
		@doubles |= ["C_#{loop_iterator}"]
		str << Helper.indent(1) + "for(int #{loop_iterator}=0;#{loop_iterator}<=#{branch_lv.psize};#{loop_iterator}++){\n"			
		
		str << Helper.indent(2) + "if(#{loop_iterator}==0){\n"
		str << branching_for_boundaries(cnf_dup, loop_iterator, array_counter, save_counter, branch_prv, "0", with_cache)
		str << Helper.indent(2) + "}\n"
		
		cnf_dup_loop = cnf.duplicate
		cnf_dup_loop.branch(branch_prv, "#{loop_iterator}")
		cnf_dup_loop.apply_branch_observation(branch_prv)
		cnf_dup_loop.remove_resolved_constraints
		to_evaluate = cnf_dup_loop.clauses.select{|clause| clause.can_be_evaluated?}
		cnf_dup_loop.clauses -= to_evaluate

		if(cnf_dup_loop.has_lv_neq_lv_constraint_with_type? (branch_lv.type + "1") and cnf_dup_loop.has_lv_neq_lv_constraint_with_type? (branch_lv.type + "2") and (branch_lv_num_psize == 2 or branch_lv_num_psize.nil?))
			save_counter = @counter
			str << Helper.indent(2) + "else if(#{loop_iterator}==1 && #{branch_lv.psize}==2){\n"
			str << branching_for_11(cnf_dup_loop, branch_prv, array_counter, loop_iterator, to_evaluate, save_counter, branch_lv, true, true, false)
			str << Helper.indent(2) + "}\n"
		end
		if(cnf_dup_loop.has_lv_neq_lv_constraint_with_type? (branch_lv.type + "1"))
			save_counter = @counter
			str << Helper.indent(2) + "else if(#{loop_iterator}==1){\n"
			str << branching_for_11(cnf_dup_loop, branch_prv, array_counter, loop_iterator, to_evaluate, save_counter, branch_lv, true, false, false)
			str << Helper.indent(2) + "}\n"
		end
		if(cnf_dup_loop.has_lv_neq_lv_constraint_with_type? (branch_lv.type + "2"))
			save_counter = counter
			num_val = Helper.num_value("#{branch_lv.psize}-1")
			if(!num_val.nil?)
				str << Helper.indent(2) + "else if(#{loop_iterator}==#{num_val}){\n"
			else
				str << Helper.indent(2) + "else if(#{loop_iterator}==#{branch_lv.psize}-1){\n"
			end
			str << branching_for_11(cnf_dup_loop, branch_prv, array_counter, loop_iterator, to_evaluate, save_counter, branch_lv, false, true, false)
			str << Helper.indent(2) + "}\n"
		end
		save_counter = counter
		str << Helper.indent(2) + "else if(#{loop_iterator}!=#{branch_lv.psize}){\n"
		cnf_dup_loop.remove_resolved_constraints
		str << after_branch_cpp_string(branch_prv.core_name, array_counter, loop_iterator, cnf_dup_loop, to_evaluate, save_counter, branch_lv, with_cache)
		str << Helper.indent(2) + "}\n"

		save_counter = @counter
		str << Helper.indent(2) + "else{\n"
		str << branching_for_boundaries(cnf_dup, loop_iterator, array_counter, save_counter, branch_prv, "n", with_cache)
		str << Helper.indent(2) + "}\n"

		str << Helper.indent(2) + "C_#{loop_iterator}=(C_#{loop_iterator}-logs[#{loop_iterator}+1])+logs[(#{branch_lv.psize})-#{loop_iterator}];\n"
		str << Helper.indent(1) + "}\n"
		str << Helper.indent(1) + "v#{array_counter}=sum_arr(v#{array_counter}_arr, #{branch_lv.psize});\n"
		str << @cache.add(cnf, "v#{array_counter}") if with_cache

		return str
	end

	def compile(cnf, with_cache)
		cnf_dup = cnf.duplicate
		str = ""
		save_counter = @counter
		@counter += 1

		if  cnf_dup.clauses.size == 0
			@noeffect_vars << "v#{save_counter}"
			return ""
		end

		if(with_cache)
			cache_value = @cache.get(cnf_dup)
			if not cache_value.nil?
				q_number = cache_value[0..cache_value.index(":")-1]
				return "v#{save_counter}=q#{q_number}.front(); q#{q_number}.pop();\n" 
			end
		end

		unit_clauses = cnf_dup.unit_clauses
		if  unit_clauses.size > 0
			unit_prop_string, to_evaluate = cnf_dup.apply_unit_propagation(unit_clauses, @weights)
			return "v#{save_counter}=-2000;\n" if(unit_prop_string == "false")
			
			compile(cnf_dup, with_cache).each_line {|line| str << line}
			to_eval_string = eval_str(cnf_dup, to_evaluate, "v#{save_counter+1}")

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
			product = ""
			cc.each_with_index do |cc_cnf, i|
				product += "v#{@counter}+"
				compile(cc_cnf, with_cache).each_line {|line| str << line}
			end
			str << "v#{save_counter}=#{product.chop};\n"
			str << @cache.add(cnf, "v#{save_counter}") if with_cache
			return str
		end

		pop_size, decomposer_lv_pos, prv_pos = cnf_dup.get_decomposer_lv
		if not decomposer_lv_pos.nil?
			decomposer_lv_type = cnf_dup.clauses[0].literals[0].prv.terms[decomposer_lv_pos[prv_pos[cnf_dup.clauses[0].literals[0].name]]-1].type
			cnf_dup.decompose(decomposer_lv_pos, prv_pos)
			cnf_dup.adjust_after_decomposition(decomposer_lv_type)
			cnf_dup.replace_no_lv_prvs_with_rvs
			compile(cnf_dup, with_cache).each_line {|line| str << line}
			str << "v#{save_counter}=v#{save_counter + 1}*(#{pop_size});\n"
			str << @cache.add(cnf, "v#{save_counter}") if with_cache
			return str
		end

		if cnf_dup.fo2
			has_neq_constraint = (cnf_dup.clauses[0].constraints.size > 0 ? true : false)
			psize = cnf_dup.clauses[0].get_all_distinct_lvs[0].psize
			cnf_dup.replace_individuals_for_fo2
			cnf_dup.remove_resolved_constraints
			cnf_dup.replace_no_lv_prvs_with_rvs
			str = ""
			compile(cnf_dup, with_cache).each_line {|line| str << line}
			str << "v#{save_counter}=v#{save_counter+1}*(((#{psize})*(#{psize} - 1)) / 2.0);\n"
			str << @cache.add(cnf, "v#{save_counter}") if with_cache
			return str
		end

		branch_prv = cnf_dup.next_prv(@order)
		if  branch_prv.num_distinct_lvs == 0
			cnf_dup.update(branch_prv.full_name, "true")
			to_evaluate = cnf_dup.clauses.select{|clause| clause.can_be_evaluated?}
			cnf_dup.clauses -= to_evaluate

			cnf_dup2 = cnf.duplicate
			cnf_dup2.update(branch_prv.full_name, "false")
			to_evaluate2 = cnf_dup2.clauses.select{|clause| clause.can_be_evaluated?}
			cnf_dup2.clauses -= to_evaluate2
			compile(cnf_dup, with_cache).each_line {|line| str << line}
			save_counter2 = @counter
			compile(cnf_dup2, with_cache).each_line {|line| str << line}

			str << "v#{save_counter}=sum(#{@weights[branch_prv.core_name][0]}+#{eval_str(cnf_dup, to_evaluate, 'v' + (save_counter+1).to_s)},#{@weights[branch_prv.core_name][1]}+#{eval_str(cnf_dup2, to_evaluate2, 'v' + (save_counter2).to_s)});\n"
			str << @cache.add(cnf, "v#{save_counter}") if with_cache
			return str

		elsif branch_prv.num_distinct_lvs == 1
			array_counter = save_counter
			save_counter = @counter
			branch_lv = branch_prv.first_lv

			branch_lv_num_psize = Helper.num_value(branch_lv.psize)

			if(branch_lv_num_psize == 0)
				str << branching_for_psize_0_string(cnf_dup, branch_lv, array_counter, save_counter, with_cache)
			elsif(branch_lv_num_psize == 1 and cnf_dup.has_lv_neq_lv_constraint_with_type? (branch_lv.type))
				str << branching_for_psize_1_string(cnf_dup, branch_lv, array_counter, save_counter, with_cache)
			elsif(not branch_lv_num_psize.nil?)
				str << loop_string(array_counter, branch_prv, branch_lv, cnf_dup, branch_lv_num_psize, with_cache)
			else
				str << "if(#{branch_lv.psize}==0){\n"

				str << branching_for_psize_0_string(cnf_dup, branch_lv, array_counter, save_counter, false)
				str << "}\n"

				if(cnf_dup.has_lv_neq_lv_constraint_with_type? (branch_lv.type))
					save_counter = @counter
					str << "if(#{branch_lv.psize}==1){\n"
					str << branching_for_psize_1_string(cnf_dup, branch_lv, array_counter, save_counter, false)
					str << "}\n"
				end

				str << "else{\n"
				str << loop_string(array_counter, branch_prv, branch_lv, cnf_dup, branch_lv_num_psize, with_cache)
				str << "}\n"
			end
			return str
		else
			puts cnf_dup.my2string
			Helper.error("The input theory is not liftable")
		end
	end
end