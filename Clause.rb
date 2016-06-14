class Clause
	attr_accessor :literals, :is_true, :constraints

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

	def can_be_evaluated
		@is_true or @literals.size == 0
	end

	def has_constraint(term1, term2, constraint)
		@constraints.each do |clause_constraint|
			return true if clause_constraint.match(term1, term2, constraint)
		end
		return false
	end

	def add_constraint(term1, term2, constraint)
		@constraints << Constraint.new(term1, term2, constraint)
	end

	def remove_lv_neq_const(lv, const)
		@literals.each do |literal|
			literal.prv.logvars.each_with_index do |prv_lv, i|
				literal.prv.logvars[i].decrement_psize if prv_lv.is_same_as(lv)	
			end
		end
		@constraints.select!{|constraint| !constraint.is_resolved_after_removing_constant(lv, const)}
	end

	def update(prv_name, value) #note that update only drops literals from the clause. It does not (and should not) change L
		@literals.each do |literal|
			if  literal.name == prv_name
				@is_true = true if literal.value == value 
				@literals -= [literal] if literal.value != value
			end
		end
	end

	def replace_all_lvs(old_lv, new_term)
		@literals.each {|literal| literal.prv.replace_all_lvs(old_lv, new_term)}
		@constraints.each {|constraint| constraint.replace_terms(old_lv, new_term)}
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

	def my2string
		str = "<"
		if @is_true 
			str += "True"
		elsif is_false == 0
			str += "False"
		else
			str += @literals.map{|lit| lit.my2string}.join("v")
		end
		if(@constraints.size != 0)
			str << "," + @constraints.map{|constraint| constraint.my2string}.join("v")
		end
		return str + ">" + (@is_true ? "(TRUE)" : "")
	end

	def duplicate
		Marshal::load(Marshal.dump(self))
	end
end
