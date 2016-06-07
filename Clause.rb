class Clause
	attr_accessor :logvars, :literals, :is_true, :equalities

	def initialize(logvars, literals, equalities)
		@logvars = logvars.map{|lv| lv.duplicate}
		@literals = literals.map{|lit| lit.duplicate}
		@is_true = false
		@equalities = equalities
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
			if  literal.prv.name == prv_name
				@is_true = true if literal.value == value 
				@literals -= [literal] if literal.value != value
			end
		end
	end

	def replace_all_lvs(old_lv, new_term)
		@literals.each {|literal| literal.prv.replace_all_lvs(old_lv, new_term)}
		@logvars.each_with_index {|logvar, i| @logvars[i] = new_term if logvar.is_same_as(old_lv) and logvar.name == old_lv.name}
	end

	def change_prv_names(lv, str)
		@literals.each {|literal| literal.prv.name += str if literal.prv.has_lv_with_name(lv.name)}
	end

	def my_to_string
		str = "<{" + @logvars.inject(""){|result, lv| result << (lv.name + ",")}.chop + "},"
		str += (@literals.size == 0 ? "False" : @literals.inject(""){|result, lit| result << (lit.my_to_string + "v")}.chop) + ","
		@equalities.each {|lv1, lv2| str += lv1.name + "!=" + lv2.name + "v"} 
		return str.chop + ">"
	end

	def duplicate
		Marshal::load(Marshal.dump(self))
	end
end
