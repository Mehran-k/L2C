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

	def self.is_float(str)
		str.to_i.to_s == str || str.to_f.to_s == str
	end
end