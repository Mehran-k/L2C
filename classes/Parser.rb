#Copyright (C) 2016  Seyed Mehran Kazemi, Licensed under the GPL V3; see: <https://www.gnu.org/licenses/gpl-3.0.en.html>

class Parser
	attr_accessor :content, :domains, :predicates, :weights, :formulae

	def initialize(content)
		@content = content
		@domains = Hash.new
		@predicates = Hash.new
		@weights = Hash.new
		@formulae = Array.new
	end

	def produce_cnf
		content.each_line.with_index do |line, i|
			line = line.strip
			if  line.start_with? "domain"
				check_domain_syntax(line, i + 1)
				spl = line.gsub("{", "").gsub("}", "").split(/[" |,|\t"]/).select{|x| x.size > 0}
				domain_name = spl[1]
				domain_size = spl[2].to_i
				individuals = spl[3..spl.size]
				domain = Domain.new(domain_name, domain_size, individuals)
				@domains[domain.name] = domain

			elsif line.start_with? "predicate"
				check_predicate_syntax(line, i + 1)
				spl = line.split(/[" |,|\t"]/).select{|x| x.size > 0}
				spl = spl[1..spl.size] #removing 'predicate'
				if  Helper.is_float(spl.last)
					predicate = spl[0..spl.size - 3].join(",")
					pos_weight = spl[spl.size - 2].to_f
					neg_weight = spl[spl.size - 1].to_f
					spl = predicate.split(/["(|)|,| "]/).select{|x| x.size > 0}
					predicate_name = spl[0]
					domains = spl[1..spl.size]
				else
					predicate = spl[0..spl.size].join(",")
					spl = predicate.split(/["(|)|,| "]/).select{|x| x.size > 0}
					predicate_name = spl[0]
					domains = spl[1..spl.size]
					pos_weight = 1
					neg_weight = 1
				end
				@predicates[predicate_name] = domains.map{|d| @domains[d]}
				@weights[predicate_name] = [Math.log(pos_weight).round(8), Math.log(neg_weight).round(8), Math.log(pos_weight + neg_weight).round(8), Math.log(1 + pos_weight + neg_weight).round(8)]

			elsif line.gsub(" ", "").size == 0 or line.gsub(" ", "").start_with? "//"
				#this is an empty or a comment line

			else #formula
				nospace_line = line.gsub(" ", "").gsub("\t", "")
				check_formula_syntax(nospace_line, i + 1)
				if line.index("=").nil? 
					literals_string = nospace_line.split(/["v|V|\|"]/)
					constraints_string = nil
				else
					literals_string = nospace_line[0..nospace_line.rindex(",")-1].split(/["v|V|\|"]/)
					constraints_string = nospace_line[nospace_line.rindex(",")+1..nospace_line.size].split("^")
				end
				literals = Array.new
				all_logvars = Hash.new
				literals_string.each do |literal_string|
					value = "true"
					if  literal_string.start_with? "!" or literal_string.start_with? "~"
						literal_string = literal_string[1..literal_string.size]
						value = "false"
					end
					spl = literal_string.split(/["(|)|,"]/)
					if spl.size == 1 #no logvars
						prv = PRV.new(spl[0], [])
						literals << prv.lit(value)
					else
						prv_name = spl[0]
						logvars = Array.new
						spl[1..spl.size].each_with_index do |lv_name, i|
							domain = @predicates[prv_name][i]
							new_logvar = LogVar.new(lv_name, domain.individuals, domain.psize.to_s, domain.name)
							logvars << new_logvar
							if  all_logvars[lv_name].nil?
								all_logvars[lv_name] = new_logvar
							end
						end
						prv = PRV.new(prv_name, logvars)
						literals << prv.lit(value)
					end
				end
				constraints = Array.new
				if(!constraints_string.nil?)
					constraints_string.each do |constraint|
						spl = constraint.split("!=")
						constraints << Constraint.new(all_logvars[spl[0]], all_logvars[spl[1]], "!=")
					end
				end
				clause = Clause.new(literals, constraints)
				@formulae << clause
			end	
		end
	end

	private

	def check_formula_syntax(line, i)
		if line.index("!=").nil? 
			literals = line.split(/["v|V|\|"]/)
			constraints = nil
		else
			literals = line[0..line.rindex(",")-1].split(/["v|V|\|"]/)
			constraints = line[line.rindex(",")+1..line.size].split("^")
		end
		literals.each do |literal|
			literal = literal[1..literal.size] if literal.start_with? "!" or literal.start_with? "~"
			check_predicate_used(literal, i)
		end
		if(!constraints.nil?)
			constraints.each do |constraint|
				check_constraint_syntax(constraint, literals.join("v"), i)
			end
		end
	end

	def check_constraint_syntax(constraint, formula, i)
		if(constraint.index("!=").nil?)
			Helper.error("Invalid equality syntax in line #{i}")
		else
			spl = constraint.split("!=")
			if(formula.index(spl[0]).nil? or formula.index(spl[1]).nil?) #for now the only type of allowed constraint is x != y
				Helper.error("Logical variables used in the equality statement in line #{i} are not used in the clause")
			end
		end
	end

	def check_predicate_syntax(line, i)
		if !line.start_with? "predicate "
			Helper.error("A predicate specification must start with 'predicate' in line #{i}")
		else
			spl = line.split(/[" |,|\t"]/).select{|x| x.size > 0}
			spl = spl[1..spl.size] #removing 'predicate'
			if Helper.is_float(spl.last)
				Helper.error("Invalid predicate specifaction in line #{i}") if spl.size < 3
				predicate  = spl[0..spl.size - 3].join(",")
				pos_weight = spl[spl.size - 2]
				neg_weight = spl[spl.size - 1]
				check_predicate_definition(predicate, i)
				Helper.error("Invalid positive weight at line #{i}") if !Helper.is_float(pos_weight)
				Helper.error("Invalid negative weight at line #{i}") if !Helper.is_float(neg_weight)
			else
				check_predicate_definition(spl.join(","), i)
			end
		end
	end

	def check_predicate_definition(predicate, i)
		if predicate.count("(") == 0 and predicate.count(")") == 0
			Helper.error("Invalid or duplicate predicate name in line #{i}") if !Helper.valid_name(predicate) or !@predicates[predicate].nil?
		elsif predicate.count("(") != 1 or predicate.count(")") != 1 or predicate.index("(") > predicate.index(")")
			Helper.error("Invalid predicate format in line #{i}")
		else
			spl = predicate.split(/["(|)|,| "]/).select{|x| x.size > 0}
			if !Helper.valid_name(spl[0]) or !@predicates[spl[0]].nil?
				Helper.error("Invalid or duplicate predicate name in line #{i}")
			elsif spl.size == 1
				Helper.error("Invalid inputs for the predicate in line #{i}")
			else
				spl[1..spl.size].each do |domain_name|
					if(@domains[domain_name].nil?)
						Helper.error("Invalid domain name for the predicate in line #{i}")
					end
				end
			end
		end
	end

	def check_predicate_used(predicate, i)
		if predicate.count("(") == 0 and predicate.count(")") == 0
			Helper.error("Invalid or non-existing predicate name in line #{i}") if !Helper.valid_name(predicate) or @predicates[predicate].nil? or @predicates[predicate].size > 0
		elsif predicate.count("(") != 1 or predicate.count(")") != 1 or predicate.index("(") > predicate.index(")")
			Helper.error("Invalid predicate format in line #{i}")
		else
			spl = predicate.split(/["(|)|,| "]/).select{|x| x.size > 0}
			if !Helper.valid_name(spl[0]) or @predicates[spl[0]].nil?
				Helper.error("Invalid or non-existing predicate name in line #{i}")
			elsif spl.size == 1 or spl.size - 1 != @predicates[spl[0]].size
				Helper.error("Invalid inputs for the predicate in line #{i}")
			else
				spl[1..spl.size].each do |lv_name|
					if !Helper.valid_name(lv_name)
						Helper.error("Invalid logical variable name for the predicate in line #{i}")
					end
				end
			end
		end
	end

	def check_domain_syntax(line, i)
		if !line.start_with? "domain "
			Helper.error("A domain specification must start with 'domain' in line #{i}")
		elsif line.count(" ") < 3
			Helper.error("Syntax error! Not enough spaces! in line #{i}")
		elsif line.count("{") != 1 or line.count("}") != 1 or line.index("{") > line.index("}")
			Helper.error("Check your { and } in line #{i}")
		else
			spl = line.gsub("{", "").gsub("}", "").split(/[" |,|\t"]/).select{|x| x.size > 0}
			check_domain_name(spl[1], i)
			check_domain_size(spl[2], i)
			check_individuals(spl[3..spl.size], i, spl[2])
		end
	end

	def check_domain_name(name, i)
		if name.size == 0
			Helper.error("Invalid domain name in line #{i}")
		elsif !Helper.valid_name(name)
			Helper.error("Invalid domain name in line #{i}: a domain name may only contain letters.")
		elsif !@domains[name].nil?
			Helper.error("Repeated domain name in line #{i}")
		end
	end

	def check_domain_size(dsize, i)
		if !Helper.all_digit(dsize)
			Helper.error("Invalid domain size in line #{i}")
		elsif dsize.to_i == 0
			Helper.error("Invalid domain size in line #{i}: domain size cannot be zero")
		end
	end

	def check_individuals(individuals, i, dsize)
		if individuals.size != dsize.to_i
			Helper.error("The number of individuals does not match the domain size in line #{i}")
		end
		individuals.each do |individual|
			if !Helper.valid_name(individual)
				Helper.error("Invalid individual name in line #{i}")
			end
		end
	end
end