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

	# def evaluate(mln)
	# 	return "0.0" if is_false
	# 	return "#{@weight}" if self.psize == "1"
	# 	return "(#{@weight}*#{self.psize})"
	# end

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
		@logvars.each_with_index {|logvar, i| @logvars[i] = new_term if logvar.is_same_as(old_lv) and logvar.name == old_lv.name}
		@constraints.each {|constraint| constraint.replace_terms(old_lv, new_term)}
	end

	def change_prv_names(lv, str)
		@literals.each {|literal| literal.prv.full_name += str if literal.prv.has_lv_with_name(lv.name)}
	end

	def my2string
		str = "<{" + @logvars.inject(""){|result, lv| result << (lv.name + ",")}.chop + "},"
		str += (@literals.size == 0 ? "False" : @literals.inject(""){|result, lit| result << (lit.my2string + "v")}.chop) + ","
		@constraints.each {|constraint| str += constraint.my2string + "v"} 
		return str.chop + ">" + (@is_true ? "(TRUE)" : "")
	end

	def duplicate
		Marshal::load(Marshal.dump(self))
	end
end
