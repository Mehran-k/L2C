class PRV
	attr_accessor :core_name, :full_name, :terms

	def initialize(core_name, full_name, terms)
		@core_name = core_name
		@full_name = full_name
		@terms = terms.map{|term| term.duplicate}
	end

	def initialize(name, terms)
		@core_name = name
		@full_name = name
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

	def num_distinct_lvs #returns number of lvs with different names
		return @terms.select{|term| term.class == LogVar}.map{|lv| lv.name}.uniq.size
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

	def index_lv_with_name(name)
		@terms.each_with_index do |term, i|
			return i if term.class == LogVar and term.name == name
		end
		return -1
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

	def remove_same_lvs
		return duplicate if num_distinct_lvs == num_lvs
		term_visited = Hash.new
		prv = self.duplicate
		prv.terms = Array.new
		prv.full_name += "_r"

		@terms.each_with_index do |term, i|
			if term_visited[term.name].nil?
				term_visited[term.name] = true
				prv.terms << term
			else
				prv.full_name += i.to_s
			end
		end
		return prv
	end

	def unique_identifier
		return @full_name if @terms.size == 0
	 	types_count = Hash.new
	 	name2id = Hash.new
	 	id = @full_name + "("
	 	@terms.each do |term|
	 		if term.class == Constant
	 			id += term.name 
	 		elsif !name2id[term.name].nil?
	 			id += name2id[term.name]
	 		else
	 			types_count[term.type] = types_count[term.type].to_i + 1
	 			name2id[term.name] = term.type + types_count[term.type].to_s
	 			id += name2id[term.name]
	 		end
	 		id += ","
	 	end
	 	return id.chop + ")"
	end

	def my2string
		@terms.size == 0 ? @full_name : (@terms.inject(@full_name + "("){|result, term| result << (term.name + ",")}).chop + ")"
	end

	def duplicate
		Marshal::load(Marshal.dump(self))
	end
end
