#Copyright (C) 2016  Seyed Mehran Kazemi, Licensed under the GPL V3; see: <https://www.gnu.org/licenses/gpl-3.0.en.html>

class Constraint
	attr_accessor :term1, :term2, :constraint

	def initialize(term1, term2, constraint) #if there is a logvar, it's always the first term
		@term1 = term1.duplicate
		@term2 = term2.duplicate
		swap_terms if(@term1.class == Constant and @term2.class == LogVar)
		@constraint = constraint
	end

	def replace_terms(old_lv, new_term)
		@term1 = new_term.duplicate if @term1.class == LogVar and @term1.name == old_lv.name
		@term2 = new_term.duplicate if @term2.class == LogVar and @term2.name == old_lv.name
		swap_terms if(@term1.class == Constant and @term2.class == LogVar)
	end

	def replace_terms_with_type(old_type, new_term)
		@term1 = new_term.duplicate if @term1.class == LogVar and @term1.type == old_type
		@term2 = new_term.duplicate if @term2.class == LogVar and @term2.type == old_type
		swap_terms if(@term1.class == Constant and @term2.class == LogVar)
	end

	def swap_terms
		temp = @term1.duplicate
		@term1 = @term2
		@term2 = temp
	end

	def match_name?(term1, term2, constraint)
		return false if @constraint != constraint
		return false if @term1.class != term1.class or @term2.class != @term2.class
		return true if @term1.name == term1.name and @term2.name == term2.name
		return true if @term1.name == term2.name and @term2.name == term1.name
		return false
	end

	def match_type?(term1, term2, constraint)
		return false if @constraint != constraint
		return false if @term1.class != term1.class or @term2.class != @term2.class
		return false if @term1.class == Constant and @term1.name != term1.name
		return false if @term2.class == Constant and @term2.name != term2.name
		return false if @term1.class == LogVar and @term1.type != term1.type
		return false if @term2.class == LogVar and @term2.type != term2.type
		return true
	end

	def match_type2? (type, constraint)
		return false if @constraint != constraint
		return false if @term1.class != LogVar or @term1.type != type
		return false if @term2.class != LogVar or @term2.type != type
		return true
	end

	def replace_parameters(param, number)
		@term1.replace_parameters(param, number) if @term1.class == LogVar
		@term2.replace_parameters(param, number) if @term2.class == LogVar
	end

	def is_resolved?
		return true if @term1.class == Constant and @term2.class == Constant and !@term1.is_same_as(@term2)
		return true	if @term1.class == LogVar and @term2.class == LogVar and term1.type != term2.type
		return false
	end

	def contradicts?
		return true if (@term1.name == @term2.name) ? true : false
	end

	def lv_neq_const?
		(@term1.class == LogVar and @term2.class == Constant) ? true : false
	end

	def lv_neq_lv?
		(@term1.class == LogVar and @term2.class == LogVar) ? true : false
	end

	def is_resolved_after_removing_constant?(lv, const)
		(lv_neq_const? and @term1.is_same_as(lv) and @term2.is_same_as(const)) ? true : false
	end

	def my2string
		return @term1.my2string + constraint + @term2.my2string + (is_resolved? ? "(RESOLVED)" : "")
	end
end