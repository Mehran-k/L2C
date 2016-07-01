#Copyright (C) 2016  Seyed Mehran Kazemi, Licensed under the GPL V3; see: <https://www.gnu.org/licenses/gpl-3.0.en.html>

class Domain
	attr_accessor :name, :psize, :individuals

	def initialize(name, psize, individuals)
		@name = name
		@psize = psize
		@individuals = individuals
	end
end