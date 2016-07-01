#Copyright (C) 2016  Seyed Mehran Kazemi, Licensed under the GPL V3; see: <https://www.gnu.org/licenses/gpl-3.0.en.html>

class PRV
	attr_accessor :core_name, :full_name, :terms, :name_addendum

	def initialize(name, terms)
		@core_name = name.dup
		@full_name = name.dup
		@terms = terms.map{|term| term.duplicate}
		@name_addendum = Hash.new
	end

	def confirm_name_addendum
		@name_addendum.keys.sort.each {|key| @full_name << @name_addendum[key]}
		@name_addendum = Hash.new
	end

	def num_terms
		return @terms.size
	end

	def lit(value)
		return Literal.new(self, value)
	end

	def replace_parameters(param, number)
		@terms.each {|term| term.replace_parameters(param, number) if term.class == LogVar}
	end

	def num_lvs #returns the number of lvs: F(x,x) has two lvs
		return @terms.select{|term| term.class == LogVar}.size
	end

	def num_distinct_lvs #returns number of lvs with different names: F(x,x) has one distinct lv
		return logvars.map{|lv| lv.name}.uniq.size
	end

	def logvars
		return @terms.select{|term| term.class == LogVar}
	end

	def first_lv
		return logvars.first
	end

	def first_lv_with_type(type)
		@terms.each {|term| return term if term.class == LogVar and term.type == type}
		return nil
	end

	def has_lv_with_type?(type)
		@terms.each {|term| return true if term.class == LogVar and term.type == type}
		return false
	end

	def index_lv_with_name(name)
		@terms.each_with_index {|term, i| return i if term.class == LogVar and term.name == name}
		return -1
	end

	def num_psize
		return @terms.inject(1) {|result, term| result * term.psize.to_i}
	end

	def psize(constraints)
		return "1" if logvars.size == 0
		all_num = true
		@terms.each {|term| all_num = false if term.psize.to_i.to_s != term.psize}
		if(num_distinct_lvs < 2)
			return eval(@terms.inject(""){|result, term| result += term.psize + "*"}.chop).to_s if all_num
			return (@terms.inject("(") {|result, term| result += ("(" + term.psize + ")*")}.chop + ")")
		else
			size = ""
			lv_hash = Hash.new
			@terms.each do |term|
				if lv_hash[term.type].nil?
					size += "(" + term.psize + ")*"
					lv_hash[term.type] = 1
				else
					size += "(" + term.psize + "-#{lv_hash[term.type]})*"
					lv_hash[term.type] += 1
				end
			end
			return eval(size.chop) if all_num
			return "(" + size.chop + ")"
		end
	end

	def cfbf
		num_lvs == 0 ? 2 : logvars.inject(1) {|result, lv| result * (lv.psize.to_i + 1)}
	end

	def replace_all_lvs(old_lv, new_term)
		@terms.each_with_index  {|term, i| @terms[i] = new_term.duplicate if term.class == LogVar and term.is_same_as(old_lv) and term.name == old_lv.name}
	end

	def replace_all_lvs_with_type(old_type, new_term)
		@terms.each_with_index {|term, i| @terms[i] = new_term.duplicate if term.class == LogVar and term.type == old_type}
	end

	def replace_all_lvs_and_prv_names(old_lv, new_term)
		@terms.each_with_index do |term, i|
			if term.class == LogVar and term.is_same_as(old_lv) and term.name == old_lv.name
				@terms[i] = new_term.duplicate
				@name_addendum[i] = "c#{i}" + new_term.name
			end
		end
	end

	def remove_same_lvs
		return self.duplicate if num_distinct_lvs == num_lvs
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
		prv.core_name = prv.full_name.dup
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
