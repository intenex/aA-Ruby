class Cat < ActiveRecord::Base
	belongs_to :house,
		primary_key: :id,
		foreign_key: :house_id,
		class_name: 'House'

	has_many :toys,
		primary_key: :id,
		foreign_key: :cat_id,
		class_name: 'Toy'
end

class House < ActiveRecord::Base
	has_many :cats
		primary_key: :id,
		foreign_key: :house_id,
		class_name: 'Cat'

	has_many :toys,
		through: :cats, # the name of the association through this class - the association that takes us to our destination, dope, this references the has_many :cats method
		source: :toys # name of the association in the cat class ah dope this makes total sense this just says get the :toys association method from the :cats association method in this class, that's the association to go through fucking amazing, since has_many :cats will return all the cats in that house, and then this will return all the :toys for each cat that was found there, so amazing SQL is crazy powerfula nd great to learn

	# the has_many through: as above kind of works like this so cool and great
	# def toys
	# 	toys = []
	# 	self.cats.each do |cat|
	# 		toys += cat.toys
	# 	end
	# 	toys
	# end
end

# So great to be getting through these lectures just push through and make them happen when you can so lucky today to be like that

# there is only has_many through: or has_one through:, no belongs_to or any of that

class Toy < ActiveRecord::Base
	belongs_to :cat,
		primary_key: :id,
		foreign_key: :cat_id,
		class_name: 'Cat'

	has_one :house, # the only difference between has_one versus has_many is has_one returns just one element (uses a SQL LIMIT 1 possibly) versus has_many which returns an array of elements, even if there's just one or possibly none?
		through: :cat, # this gets us an association through the cat that this belongs to, the has_one, it doesn't technically 'belong_to' the house though I suppose it does
		source: :house # fucking dope, this then calls the :house association for the :cat that this toy belongs to and passes that result to the :toy as consequently what this toy also is associated with dope

	def house
		execute(<<-SQL)
		SELECT *
		FROM cats
		JOIN houses
		ON cats.house_id = houses.id
		WHERE id = #{self.cat_id}
		LIMIT 1 # basically for a has_one this is the code that's run to give you just one return
		SQL
end

# Must actively learn and do your best to totally learn everything man not easy

# So great to know what associations are now definitely sleep on it and percolate and get so much better at all of it and push through the rest of the material too

# Super lucky to have gotten through so much of it keep pushing for sure








