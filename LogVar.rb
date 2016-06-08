class LogVar
	attr_accessor :name, :domain, :psize, :type

	def initialize(name, domain, psize, type)
		@name = name
		@domain = []
		@psize = psize
		@type = type
	end

	def is_same_as lv
		return true if (@type == lv.type and @psize == lv.psize) ? true : false
	end

	def my2string
		return name
	end

	def duplicate
		Marshal::load(Marshal.dump(self))
	end
end
