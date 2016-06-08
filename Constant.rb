class Constant
	attr_accessor :name

	def initialize(name)
		@name = name
	end

	def psize
		return "1"
	end

	def is_same_as(constant)
		@name == constant.name ? true : false
	end

	def my2string
		return name
	end

	def duplicate
		Marshal::load(Marshal.dump(self))
	end
end
