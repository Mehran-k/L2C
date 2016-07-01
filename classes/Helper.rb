#Copyright (C) 2016  Seyed Mehran Kazemi, Licensed under the GPL V3; see: <https://www.gnu.org/licenses/gpl-3.0.en.html>

class Helper
	def self.error(msg)
		puts "Critical Error: " + msg + "... Terminating the program."
		exit
	end

	def self.valid_name(str)
		return false if str.size == 0 or (str[0] =~ /[A-Za-z]/).nil?
		str.each_char {|c| return false if (c =~ /[A-Za-z0-9]/).nil?}
		return true
	end

	def self.all_digit(str)
		str.to_i.to_s == str
	end

	def self.num_value(str)
		begin
			eval(str)
		rescue
			nil
		end
	end

	def self.num_value_or_itself(str)
		begin
			eval(str)
		rescue
			str
		end
	end

	def self.is_float(str)
		str.to_i.to_s == str || str.to_f.to_s == str
	end

	def self.indent(num)
		return "\t" * num
	end
end