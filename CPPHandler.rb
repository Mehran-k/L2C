class CPPHandler
	attr_accessor :core, :doubles

	def initialize(core, doubles)
		@core = core
		@doubles = doubles
	end

	def execute(filename, max_pop_size)
		logs_loop = "double logs[MAX+1]; for(int i = 0; i <= MAX; i++) logs[i] = log(i);\n"
		File.open(filename + ".cpp", 'w') { |file| file.write("#include <iostream>
			#include <string>\n#include <queue>\n#include <cmath>\n#define MAX #{max_pop_size+1}\nusing namespace std;double sum(double a, double b){return max(a,b)+log1p(exp(-abs(a-b)));}#{@new_line}double sum_arr(double array[], int n){double max = *std::max_element(array, array + n + 1);double sum = 0;for(int i = 0; i <= n; i++)sum += exp(array[i] - max);return max + log(sum);}#{@new_line}#{@doubles};\nint main(){\n" + logs_loop + core + "\ncout << exp(v1) << endl;\nreturn 0;}") }
		%x( g++ -O3 #{filename}.cpp -o #{filename} )
		puts %x( ./#{filename} )
	end
end