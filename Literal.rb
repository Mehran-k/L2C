class Literal
	attr_accessor :prv, :value

	def initialize(prv, value)
		@prv = prv.duplicate
		@value = value
	end

	def name
		@prv.full_name
	end

	def my2string
		value == "true" ? @prv.my2string : "~" << @prv.my2string
	end

	def flip_value
		return Literal.new(@prv.duplicate, "false") if @value == "true"
		return Literal.new(@prv.duplicate, "true")
	end

	def duplicate
		Marshal::load(Marshal.dump(self))
	end
end
