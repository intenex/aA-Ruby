require_relative 'employee'

class Manager < Employee # manager extends employee
    def initialize(name, title, salary, boss = nil)
        super # runs the employee superclass initialize method with all the arguments passed to initialize here by default --> could also do super(name, title, salary, boss) to pass them explicitly if you wanted to pass different arguments or a subset or something
        @employees = Array.new
    end

    def bonus(multiplier) # overriding a parent class's method
        subemployee_salary = @employees.inject(0) do |sum, employee|
            if employee.is_a?(Manager)
                sum + employee.bonus(1) + employee.salary # the bonus will get the sum of all the sub-employee salaries, plus the salary of the manager themselves since the bonus thing doesn't include their own salary
            else
                sum + employee.salary # otherwise just get the employee's salary directly if they're just a normal employee
            end
        end
        subemployee_salary * multiplier # return the whole thing times the multiplier
    end
end