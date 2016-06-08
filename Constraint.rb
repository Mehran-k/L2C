class Constraint
	attr_accessor :term1, :term2, :constraint

	def initialize(term1, term2, constraint)
		@term1 = term1.duplicate
		@term2 = term2.duplicate
		@constraint = constraint
	end

	def replace_terms(old_lv, new_term)
		@term1 = new_term.duplicate if @term1.class == LogVar and @term1.name == old_lv.name
		@term2 = new_term.duplicate if @term2.class == LogVar and @term2.name == old_lv.name
	end

	def my2string
		return @term1.my2string + constraint + @term2.my2string
	end
end