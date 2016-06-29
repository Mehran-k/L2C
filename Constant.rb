#Copyright (C) 2016  Seyed Mehran Kazemi, all rights reserved. See the full notice in LICENSE or at https://www.gnu.org/licenses/gpl-3.0.en.html

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
