class Cache
	attr_accessor :memory, :counter

	def initialize()
		@memory = Hash.new
		@counter = 0
	end

	def queues
		str = "queue<double> "
		@counter.times.each {|i| str += "q#{i+1},"}
		str = str.chop + ";"
	end

	def get(mln)
		identifier = mln.unique_identifier
		return nil if @memory[identifier].nil?
		@memory[identifier][0] = "true"
		return @memory[identifier][1][1..-2] #[1..-2] is because there is an extra " at the beginning and the end of the string
	end

	def add(mln, value)
		return "" if mln.has_no_lvs
		identifier = mln.unique_identifier
		@counter += 1
		@memory[identifier] = ["false", "\"#{@counter}:#{str_inspect(identifier)}\""]
		return "q#{@counter}.push(#{value});\n"
		# return "hit_#{@counter}:cache.insert(pair<string, double>(" + @memory[identifier][1] + ",#{value}));\n"
	end

	def str_inspect(str) #gets an MLN identifier and removes the parts that are not necessary for the c++ program
		new_str = ""
		i_i_list = Array.new #we keep the list of i_..._i variables, because we only need to know their value once.
		while str.include? "_i"
			index1 = str.index("i_")
			index2 = str.index("_i") + 2
			new_i_i_variable = str[index1..index2-1]
			if not i_i_list.include? new_i_i_variable #otherwise, we have already included the value of this i_..._i variable
				new_str += "_" if i_i_list.size > 0
				new_str += "\"+to_string(" + new_i_i_variable + ")+\""
				i_i_list << new_i_i_variable
			end
			str = str[index2, str.size]
		end
		return new_str
	end

	def remove_inserts(c_prog)
		new_prog = ""
		c_prog.each_line do |line|
			if line.include? ".push("
				q_number = line[line.index("q")..line.index(".")-1]
				new_prog += line if c_prog.include? "#{q_number}.front()"
			else
				new_prog += line
			end
		end
		return new_prog
	end
end

