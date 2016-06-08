class PRV
	attr_accessor :name, :terms

	def initialize(name, terms)
		@name = name
		@terms = terms.map{|term| term.duplicate}
	end

	def num_terms
		return @terms.size
	end

	def lit(value)
		return Literal.new(self, value)
	end

	def num_lvs
		return @terms.select{|term| term.class == LogVar}.size
	end

	def logvars
		return @terms.select{|term| term.class == LogVar}
	end

	def first_lv
		return logvars.first
	end

	def first_lv_with_type(type)
		return @terms.select{|term| term.class == LogVar and term.type == type}.first
	end

	def has_lv_with_name(name)
		@terms.select{|term| term.class == LogVar and term.name == name}.empty? ? false : true
	end

	def num_psize
		return @terms.inject(1) {|result, term| result * term.psize.to_i}
	end

	def psize
		return "1" if logvars.size == 0
		all_num = true
		@terms.each {|term| all_num = false if term.psize.to_i.to_s != term.psize}
		return eval(@terms.inject(""){|result, term| result += term.psize + "*"}.chop).to_s if all_num
		return (@terms.inject("(") {|result, term| result += ("(" + term.psize + ")*")}.chop + ")")
	end

	def cfbf
		num_lvs == 0 ? 2 : logvars.inject(1) {|result, lv| result * (lv.psize.to_i + 1)}
	end

	def replace_all_lvs(old_lv, new_term)
		@terms.each_with_index  {|term, i| @terms[i] = new_term.duplicate if term.class == LogVar and term.is_same_as(old_lv) and term.name == old_lv.name}
	end

	def my2string
		@terms.size == 0 ? @name : (@terms.inject(@name + "("){|result, term| result << (term.name + ",")}).chop + ")"
	end

	def duplicate
		Marshal::load(Marshal.dump(self))
	end
end
