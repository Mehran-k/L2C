class Domain
	attr_accessor :name, :psize, :individuals

	def initialize(name, psize, individuals)
		@name = name
		@psize = psize
		@individuals = individuals
	end
end