# all complete in like 40 minutes or so longer than it needed to take but wanted to get the protected methods right and all that and getting the bonuses right took some time awesome
class Employee    
    def initialize(name, title, salary, boss) # only managers don't have bosses by default, employees do normally love it so require it normally, but if it's a manager class then it will automatically pass on the nil boss value love it
        @name = name
        @title = title
        @salary = salary
        @boss = boss
        boss.employees << self if !boss.nil? # add yourself to the boss/manager instance's array of employees awesome if there is any boss, if not, don't do this of course otherwise it'll return an error lol
    end

    def bonus(multiplier)
        @salary * multiplier
    end

    protected # omfg this works LOL because Employee is the parent class of Manager manager can access this :employees reader method AND it doesn't throw an error despite the fact that there's no @employees attribute defined at all in the parent class Employee, you just need it like this so that normal Employees that aren't part of the subclass Manager can still call the boss.employees method this is so fucking nuts lmao https://rubyplus.com/articles/2701-Basics-of-Protected-Methods-in-Ruby-2-2-3 "A subclass can call the protected methods defined in its parent from a public method. Protected methods can also be called from other instances of the class defining the protected method." so nuts lmao
    attr_reader :employees, :salary # don't need an accessor because only modifying this with a shovel, not reassigning it, awesome shit to know lol. In fact you could make this a protected class since employees are of a superclass so it should work just fine let's try that hmm --> damn nvm the protected worked fine for the Manager subclass but not for the Employee superclass very interesting
end