# PHASE 2
def convert_to_int(str)
  Integer(str) # this only converts str if it is completely a correct Integer, unlike .to_i. .to_i will try to convert as much as it can and return 0 if it can't convert anything
rescue ArgumentError # should be a type error...nope nevermind it's an ArgumentError hmm --> ah right because the argument for Integer, which is a method it appears, though weird that it's a method that begins with a capital letter to signify that it's a ::constant? Hmm. So the argument for Integer is what's throwing the error love it
  nil
end

# wow if you catch Exception it'll ignore even system errors? amazing might be able to do that for stack overflows look into it more hmm
# 

# PHASE 3
FRUITS = ["apple", "banana", "orange"]

def reaction(maybe_fruit)
  if FRUITS.include? maybe_fruit
    puts "OMG, thanks so much for the #{maybe_fruit}!"
  elsif maybe_fruit.downcase == "coffee"
    raise TypeError
  else
    raise StandardError
  end
end

def feed_me_a_fruit
  puts "Hello, I am a friendly monster. :)"

  puts "Feed me a fruit! (Enter the name of a fruit:)"
  maybe_fruit = gets.chomp
  reaction(maybe_fruit) 
  # remember that you can just put rescues here in the code amazing
rescue TypeError # amazing the error bubbles up from the method being called below into here and you can just rescue here and retry here --> if you rescued and retried in the submethod #reaction it would have caused an infinite loop as you found out since you never altered the fruit argument being passed in (and it was indeed just passed in again as you found out too since the method just reruns from the beginning of the block I suppose which makes sense so amazing)
  puts "Sorry, that was coffee, not a fruit. Please try again."
  retry
rescue StandardError
  puts "That wasn't a fruit :(.\nPeople like you are why monsters aren't friendly :(."
end  

# PHASE 4
class BestFriend
  def initialize(name, yrs_known, fav_pastime)
    @name = name
    @yrs_known = yrs_known
    @fav_pastime = fav_pastime
  end

  def talk_about_friendship
    puts "Wowza, we've been friends for #{@yrs_known}. Let's be friends for another #{1000 * @yrs_known}."
  end

  def do_friendstuff
    puts "Hey bestie, let's go #{@fav_pastime}. Wait, why don't you choose. 😄"
  end

  def give_friendship_bracelet
    puts "Hey bestie, I made you a friendship bracelet. It says my name, #{@name}, so you never forget me." 
  end
end


