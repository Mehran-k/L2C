class Literal
	attr_accessor :prv, :value

	def initialize(prv, value)
		@prv = prv.duplicate
		@value = value
	end

	def my2string
		value == "true" ? @prv.my2string : "~" << @prv.my2string
	end

	def duplicate
		Marshal::load(Marshal.dump(self))
	end
end
