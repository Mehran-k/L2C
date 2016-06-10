class Clause
	attr_accessor :logvars, :literals, :is_true, :constraints

	def initialize(logvars, literals, constraints)
		@logvars = logvars.map{|lv| lv.duplicate}
		@literals = literals.map{|lit| lit.duplicate}
		@is_true = false
		@constraints = constraints
	end

	def is_false
		not @is_true and @literals.size == 0
	end

	def psize
		@logvars.select{|lv| lv.class == LogVar}.size == 0 ? "1" : (@logvars.select{|lv| lv.class == LogVar}.inject("(") {|result, lv| result += lv.psize + "*"}.chop + ")")
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
		@logvars.each_with_index do |clause_lv, i|
			logvars[i].decrement_psize if clause_lv.is_same_as(lv)
		end
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

	def remove_duplicate_lvs
		lv_hash = Hash.new
		new_logvars = Array.new
		@logvars.each do |lv|
			if lv_hash[lv.name].nil?
				new_logvars << lv
				lv_hash[lv.name] = true
			end
		end
		@logvars = new_logvars
	end

	def replace_all_lvs(old_lv, new_term)
		@literals.each {|literal| literal.prv.replace_all_lvs(old_lv, new_term)}
		@logvars.each_with_index {|logvar, i| @logvars[i] = new_term if logvar.is_same_as(old_lv) and logvar.name == old_lv.name}
		@constraints.each {|constraint| constraint.replace_terms(old_lv, new_term)}
	end

	def replace_all_prvs(prv1, prv2)
		@literals.each_with_index do |literal, i|
			@literals[i].prv = prv2.duplicate if literal.prv.unique_identifier == prv1.unique_identifier
		end
	end

	def change_prv_names(lv, str)
		@literals.each {|literal| literal.prv.full_name += str if literal.prv.has_lv_with_name(lv.name)}
	end

	def my2string
		str = "<{" + @logvars.inject(""){|result, lv| result << (lv.name + ",")}.chop + "},"
		if @literals.size == 0 and @is_true 
			str += "True,"
		elsif @literals.size == 0
			str += "False,"
		else
			str += @literals.inject(""){|result, lit| result << (lit.my2string + "v")}.chop + ","
		end
		@constraints.each {|constraint| str += constraint.my2string + "v"} 
		return str.chop + ">" + (@is_true ? "(TRUE)" : "")
	end

	def duplicate
		Marshal::load(Marshal.dump(self))
	end
end
