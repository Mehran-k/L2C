class WFOMC
	attr_accessor :weights, :order, :counter, :noeffect_vars, :indent, :num_iterate, :doubles

	def initialize(weights)
		@weights = weights
		@counter = 1
		@noeffect_vars = Array.new
		@indent = "    "
		@num_iterate = 0
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
						str += "0.693147*#{literal.prv.psize}+"
					else
						str += "sum(#{@weights[literal.prv.core_name][0]}, #{@weights[literal.prv.core_name][1]})*#{literal.prv.psize}+"
					end
					already_counted << literal.name
				end
			end
		end
		# to_evaluate_clauses.each do |clause| 
		# 	e = clause.evaluate(cnf)
		# 	str += (e + "+") if e != "0.0"
		# end
		(@noeffect_vars.include? v) ? (return "0") : (return v) if str == ""
		(@noeffect_vars.include? v) ? (return "(" + str.chop + ")") : (return v + "+(" + str.chop + ")")
	end

	def compile(cnf, cache)

		puts "vvvvvvvvvvvvvvvv"
		puts cnf.my2string
		puts "^^^^^^^^^^^^^^^"

		# @num_iterate += 1
		# exit if @num_iterate > 5

		cnf_dup = cnf.duplicate
		str = ""
		save_counter = @counter
		@counter += 1

		if  cnf_dup.clauses.size == 0
			@noeffect_vars << "v#{save_counter}"
			return "\n"
		end

		# cache_value = cache.get(cnf_dup)
		# if not cache_value.nil?
		# 	q_number = cache_value[0..cache_value.index(":")-1]
		# 	return "v#{save_counter}=q#{q_number}.front(); q#{q_number}.pop();\n" 
		# end
		# return "v#{save_counter}=cache.at(\"#{cache_value}\");\n" if not cache_value.nil?

		#unit propagation
		unit_clauses = cnf_dup.unit_clauses
		if  unit_clauses.size > 0
			puts "Unit Propagation"
			str = "v#{save_counter}="
			unit_clauses.each do |unit_clause|
				literal = unit_clause.literals[0]
				str += (literal.value == "true" ? @weights[literal.prv.core_name][0].to_s : @weights[literal.prv.core_name][1].to_s) + "*" + literal.prv.psize + "+"
				cnf_dup.propagate(unit_clause)
				puts cnf_dup.my2string
				cnf_dup.remove_resolved_constraints
			end
			str += "v#{save_counter+1};\n"

			@counter += 1
			to_evaluate = cnf_dup.clauses.select{|clause| clause.can_be_evaluated}
			cnf_dup.clauses -= to_evaluate
			str2 = ""
			compile(cnf_dup, cache).each_line {|line| str2 += line}
			str2 += "v#{save_counter+1}=#{eval_str(cnf_dup, to_evaluate, 'v' + (save_counter+2).to_s)};\n"
			str2 += str;
			return str2
		end

		cc = cnf_dup.connected_components
		if  cc.size != 1
			puts "the network is disconnected!"
			product = ""#this is the product of all connected components
			cc.each do |cc_cnf|
				puts "Connected component"
				puts cc_cnf.my2string
				puts "$$$$$$$$"
				product += "v#{@counter}+"
				compile(cc_cnf, cache).each_line {|line| str += line}
			end
			return str << "v#{save_counter}=#{product.chop};\n" #<< cache.add(cnf, "v#{save_counter}")
		end

		pop_size, decomposer_lv_pos, prv_pos = cnf_dup.get_decomposer_lv
		if not decomposer_lv_pos.nil?
			puts "Grounding is disconnected with positions: #{decomposer_lv_pos}"
			cnf_dup.decompose(decomposer_lv_pos, prv_pos)
			cnf_dup.shatter
			compile(cnf_dup, cache).each_line {|line| str += line}
			str += "v#{save_counter}=v#{save_counter + 1}*(#{pop_size});\n"
			return str #+ cache.add(cnf, "v#{save_counter}")
		end

		# puts "branching on #{branch_prv.my_to_string}"
		puts "~~~~~~~"
		branch_prv = cnf_dup.next_prv(@order)
		puts "branching on: " + branch_prv.my2string

		if  branch_prv.num_lvs == 0
			cnf_dup.update(branch_prv.full_name, "true")
			to_evaluate = cnf_dup.clauses.select{|clause| clause.can_be_evaluated}
			cnf_dup.clauses -= to_evaluate

			cnf_dup2 = cnf.duplicate
			cnf_dup2.update(branch_prv.full_name, "false")
			to_evaluate2 = cnf_dup2.clauses.select{|clause| clause.can_be_evaluated}
			cnf_dup2.clauses -= to_evaluate2

			compile(cnf_dup, cache).each_line {|line| str += line}
			save_counter2 = @counter
			compile(cnf_dup2, cache).each_line {|line| str += line}

			str += "v#{save_counter}=sum(#{@weights[branch_prv.core_name][0]}+#{eval_str(cnf_dup, to_evaluate, 'v' + (save_counter+1).to_s)},#{@weights[branch_prv.core_name][1]}+#{eval_str(cnf_dup2, to_evaluate2, 'v' + (save_counter2).to_s)});\n"
			# str += cache.add(cnf, "v#{save_counter}")
			return str

		elsif branch_prv.num_lvs == 1
			loop_iterator = "i_" + branch_prv.full_name + "_i"
			str += "C_#{loop_iterator}=0;#{@new_line}"
			@doubles |= ["C_#{loop_iterator}"]
			branch_lv = branch_prv.first_lv
			cnf_dup.branch(branch_prv, "#{loop_iterator}")
			cnf_dup.apply_branch_observation(branch_prv)
			cnf_dup.remove_resolved_constraints
			to_evaluate = cnf_dup.clauses.select{|clause| clause.can_be_evaluated}
			cnf_dup.clauses -= to_evaluate

			str += "double v#{save_counter}_arr[#{@maxPopSize}];\nfor(int #{loop_iterator}=0;#{loop_iterator}<=#{branch_lv.psize};#{loop_iterator}++){\n"
			compile(cnf_dup, cache).each_line {|line| str += @indent + line}
			str += @indent + "v#{save_counter}_arr[#{loop_iterator}]=C_#{loop_iterator}+(#{@weights[branch_prv.core_name][0]}*#{loop_iterator}+#{@weights[branch_prv.core_name][1]}*(#{branch_lv.psize}-#{loop_iterator}))+#{eval_str(cnf_dup, to_evaluate, 'v' + (save_counter+1).to_s)};\n" + @indent + "C_#{loop_iterator}=(C_#{loop_iterator}-logs[#{loop_iterator}+1])+logs[(#{branch_lv.psize})-#{loop_iterator}];#{@new_line}"
			#str += @indent + "v#{save_counter}=sum(v#{save_counter},C_#{loop_iterator}+#{eval_str(cnf_dup, to_evaluate, 'v' + (save_counter+1).to_s)});\n" + @indent + "C_#{loop_iterator}=(C_#{loop_iterator}-log(#{loop_iterator}+1))+log((#{branch_lv.psize})-#{loop_iterator});#{@new_line}"
			return str + "}\n" + "v#{save_counter}=sum_arr(v#{save_counter}_arr, #{branch_lv.psize});" + "\n" + cache.add(cnf, "v#{save_counter}")
		else
			puts cnf_dup.my2string
			return "(Two lvs)\n"
			# puts "*******************@@@@@@@@@@@@@@@@@*******************@@@@@@@@@@@@@@@@@**************************@@@@@@@@@@@@@@@@@@@***************"
			# cnf_dup.ground(branch_prv.first_lv)
			# return lrc(next_prv(cnf_dup), cnf_dup, cache)
		end
	end
end