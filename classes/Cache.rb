#Copyright (C) 2016  Seyed Mehran Kazemi, Licensed under the GPL V3; see: <https://www.gnu.org/licenses/gpl-3.0.en.html>

class Cache
	attr_accessor :memory, :counter, :queues

	def initialize()
		@memory = Hash.new
		@counter = 0
	end

	def queues_declaration
		return "" if queues.empty?
		str = "queue<double> "
		str += queues.join(",") + ";\n"
		return str
	end

	def get(cnf)
		identifier = cnf.unique_identifier
		return nil if @memory[identifier].nil?
		@memory[identifier][0] += 1 #counts the number of times it has ben used
		return @memory[identifier][1][1..-2] #[1..-2] is because there is an extra " at the beginning and the end of the string
	end

	def add(cnf, value)
		return "" if cnf.has_no_lvs
		identifier = cnf.unique_identifier
		@counter += 1
		@memory[identifier] = [0, "\"#{@counter}:#{str_inspect(identifier)}\""] #0 indicates it has not been used yet.
		return "q#{@counter}.push(#{value});\n"
	end

	def str_inspect(str) #gets a cnf identifier and removes the parts that are not necessary for the c++ program
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
		@queues = Array.new
		new_prog = ""
		q_usage = Hash.new
		c_prog.each_line do |line|
			if line.include? ".push("
				q_number = line[line.index("q")..line.index(".")-1]
				used_count = c_prog.scan(/#{q_number}.front()/).count
				new_push = ""
				used_count.times.each do |i|
					new_push += line.gsub("#{q_number}", "#{q_number}_#{i+1}")
					@queues |= ["#{q_number}_#{i+1}"]
				end
				c_prog.gsub(line, "")
				new_prog += new_push
			elsif line.include? ".front("
				q_number = line[line.index("q")..line.index(".")-1]
				q_usage[q_number] = q_usage[q_number].to_i + 1
				new_prog += line.gsub("#{q_number}.front(); #{q_number}.pop();", "#{q_number}_#{q_usage[q_number]}.front(); #{q_number}_#{q_usage[q_number]}.pop();")
			else
				new_prog += line
			end
		end
		return new_prog
	end

	def duplicate
		Marshal::load(Marshal.dump(self))
	end
end

