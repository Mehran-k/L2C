class Literal
	attr_accessor :prv, :value

	def initialize(prv, value)
		@prv = prv.duplicate
		@value = value
	end

	def my_to_string
		value == "true" ? @prv.my_to_string : "~" << @prv.my_to_string
	end

	def duplicate
		Marshal::load(Marshal.dump(self))
	end
end
