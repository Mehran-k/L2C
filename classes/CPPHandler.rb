#Copyright (C) 2016  Seyed Mehran Kazemi, all rights reserved. See the full notice in LICENSE or at https://www.gnu.org/licenses/gpl-3.0.en.html

class CPPHandler
	attr_accessor :core, :doubles, :queues

	def initialize(core, doubles, queues)
		@core = core.gsub("+0;", ";").gsub("*1;", ";")
		@doubles = doubles
		@queues = queues
	end

	def add_indent
		new_core = ""
		num_indent = 1
		@core.each_line do |line|
			if(line.start_with? "if" or line.start_with? "for" or line.start_with? "else")
				new_core += Helper.indent(num_indent) + line
				num_indent += 1
			elsif line.start_with? "}"
				num_indent -= 1
				new_core += Helper.indent(num_indent) + line
			else
				new_core += Helper.indent(num_indent) + line
			end
		end
		@core = new_core
	end

	def execute(filename, max_pop_size)
		logs_loop = "double logs[MAX+1]; for(int i = 0; i <= MAX; i++) logs[i] = log(i);\n"
		File.open(filename + ".cpp", 'w') { |file| file.write("#include <iostream>\n#include <string>\n#include <queue>\n#include <cmath>\n#define MAX #{max_pop_size+1}\nusing namespace std;double sum(double a, double b){return max(a,b)+log1p(exp(-abs(a-b)));}#{@new_line}double sum_arr(double array[], int n){double max = *std::max_element(array, array + n + 1);double sum = 0;for(int i = 0; i <= n; i++)sum += exp(array[i] - max);return max + log(sum);}#{@new_line}#{@doubles};\n#{queues}\nint main(){\n" + logs_loop + core + "#{Helper.indent(1)}cout << \"exp(\" << v1 << \") = \" << exp(v1) << endl;\n#{Helper.indent(1)}return 0;\n}") }
		%x( g++ -O3 #{filename}.cpp -o #{filename} )
		puts "Z(Theory) = " + %x( ./#{filename} )
	end
end