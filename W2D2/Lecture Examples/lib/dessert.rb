class Dessert
	attr_reader :type, :amount

	def initialize(type, amount)
		@amount = amount
		raise 'Amount must be a number' unless amount.is_a?(Integer)

		@type = amount > 100 ? "giant #{type}" : type # holy fuck learning better syntax over time is SO much better there are obviously better ways to write things this syntactic sugar for assigning things is nuts --> so you can just assign a variable in the beginning holy jesus fuck
	end

	def eat(drink)
		drink.dip(self)
	end
end