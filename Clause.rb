class Clause
	attr_accessor :literals, :constraints, :is_true

	def initialize(literals, constraints)
		@literals = literals.map{|lit| lit.duplicate}
		@is_true = false
		@constraints = constraints
	end

	def is_false
		not @is_true and @literals.size == 0
	end

	def num_distinct_lvs
		lv_hash = Hash.new
		@literals.each do |literal|
			literal.prv.logvars.each do |lv|
				lv_hash[lv.name] = "true"
			end
		end
		return lv_hash.keys.size
	end

	def can_be_evaluated?
		@is_true or @literals.size == 0
	end

	def break_lv_neq_lv_to_lv_neq_constant(type, constant)
		@constraints.each do |constraint|
			if constraint.lv_neq_lv? and constraint.term1.type == type and constraint.term2.type == type
				new_constraint1 = Constraint.new(constraint.term1.duplicate, constant.duplicate, "!=")
				new_constraint2 = Constraint.new(constraint.term2.duplicate, constant.duplicate, "!=")
				@constraints -= [constraint]
				@constraints += [new_constraint1, new_constraint2]
			end
		end
	end

	def has_lv_with_type? (type)
		@literals.each {|literal| return true if literal.prv.has_lv_with_type?(type)}
		return false
	end

	def has_constraint_with_name? (term1, term2, constraint)
		@constraints.each {|clause_constraint| return true if clause_constraint.match_name?(term1, term2, constraint)}
		return false
	end

	def has_constraint_with_type? (term1, term2, constraint)
		@constraints.each {|clause_constraint| return true if clause_constraint.match_type?(term1, term2, constraint)}
		return false
	end

	def has_lv_neq_lv_constraint_with_type? (type)
		@constraints.each {|constraint| return true if constraint.match_type2?(type, "!=") }
		return false
	end

	def has_contradictory_constraint?
		@constraints.each {|constraint| return true if constraint.contradicts?}
		return false
	end

	def add_constraint(term1, term2, constraint)
		@constraints << Constraint.new(term1, term2, constraint)
	end

	def decrement_lv_size(lv)
		@literals.each do |literal|
			literal.prv.logvars.each_with_index do |prv_lv, i|
				literal.prv.logvars[i].decrement_psize if prv_lv.is_same_as(lv)	
			end
		end
	end

	def update(prv_name, value) #note that update only drops literals from the clause. It does not (and should not) change L
		@literals.each do |literal|
			if  literal.name == prv_name
				@is_true = true if literal.value == value 
				@literals -= [literal] if literal.value != value
			end
		end
	end

	def get_all_lvs
		@literals.map{|literal| literal.prv.logvars}.flatten
	end

	def get_all_distinct_lvs
		lv_hash = Hash.new
		lvs = Array.new
		@literals.each do |literal|
			literal.prv.logvars.each do |lv|
				lvs << lv if lv_hash[lv.name].nil?
				lv_hash[lv.name] = "true"
			end
		end
		return lvs
	end

	def replace_all_lvs(old_lv, new_term)
		@literals.each {|literal| literal.prv.replace_all_lvs(old_lv, new_term)}
		@constraints.each {|constraint| constraint.replace_terms(old_lv, new_term)}
	end

	def replace_all_lvs_and_prv_names(old_lv, new_term)
		@literals.each {|literal| literal.prv.replace_all_lvs_and_prv_names(old_lv, new_term)}
		@constraints.each {|constraint| constraint.replace_terms(old_lv, new_term)}
	end

	def replace_all_lvs_with_type(old_type, new_term)
		@literals.each {|literal| literal.prv.replace_all_lvs_with_type(old_type, new_term)}
		@constraints.each {|constraint| constraint.replace_terms_with_type(old_type, new_term)}
	end

	def replace_parameters(param, number)
		@constraints.each {|constraint| constraint.replace_parameters(param, number)}
		@literals.each {|literal| literal.prv.replace_parameters(param, number)}
	end

	def replace_all_prvs(prv1, prv2)
		@literals.each_with_index do |literal, i|
			@literals[i].prv = prv2.duplicate if literal.prv.unique_identifier == prv1.unique_identifier
		end
	end

	def add_to_prvs_name_addendum(lv, str) #keep the indexes and update at the last
		@literals.each do |literal|
			lv_index = literal.prv.index_lv_with_name(lv.name)
			literal.prv.name_addendum[lv_index] = str if lv_index != -1 #i.e. the literal has the input lv
		end
	end

	def all_prv_names
		@literals.map{|literal| literal.name}
	end

	def my2string
		str = "<"
		if is_false == 0
			str += "False"
		else
			str += @literals.map{|lit| lit.my2string}.join("v")
		end
		if(@constraints.size != 0)
			str << "," + @constraints.map{|constraint| constraint.my2string}.join(" ^ ")
		end
		return str + ">" + (@is_true ? "(TRUE)" : "")
	end

	def duplicate
		Marshal::load(Marshal.dump(self))
	end
end
