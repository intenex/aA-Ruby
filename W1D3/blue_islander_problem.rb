# A group of people with assorted eye colors live on an island. They are all perfect logicians -- if a conclusion can be logically deduced, they will do it instantly. No one knows the color of their eyes. Every night at midnight, a ferry stops at the island. Any islanders who have figured out the color of their own eyes then leave the island, and the rest stay. Everyone can see everyone else at all times and keeps a count of the number of people they see with each eye color (excluding themselves), but they cannot otherwise communicate. Everyone on the island knows all the rules in this paragraph.
# On this island there are 100 blue-eyed people, 100 brown-eyed people, and the Guru (she happens to have green eyes). So any given blue-eyed person can see 100 people with brown eyes and 99 people with blue eyes (and one with green), but that does not tell him his own eye color; as far as he knows the totals could be 101 brown and 99 blue. Or 100 brown, 99 blue, and he could have red eyes.
# The Guru is allowed to speak once (let's say at noon), on one day in all their endless years on the island. Standing before the islanders, she says the following:
# "I can see someone who has blue eyes."
# Who leaves the island, and on what night?

# start on day one, input the number of people with blue eyes, and see what happens. This gives the right answer with a variable # of people with blue eyes
def result(blue_eyes)
    return 1 if blue_eyes == 1 # since the guru says they see at least one person with blue eyes, the base case is 1
    result(blue_eyes-1) + 1 # if there are two people with blue eyes, then if they see the other person doesn't leave on day one, then they know they must see someone else with blue eyes, hence two people, hence they both leave on day 2, same with 3, etc., all the way through
end