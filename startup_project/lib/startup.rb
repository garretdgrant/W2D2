require "employee"

class Startup
    attr_reader :name, :funding, :salaries, :employees
    def initialize(name, funding, salaries)
        @name = name
        @funding = funding
        @salaries = salaries
        @employees = []
    end

    def valid_title?(title)
        @salaries.has_key?(title)
    end

    def >(other_startup)
        self.funding > other_startup.funding
    end

    def hire(employee_name, title)
        if self.valid_title?(title)
            @employees << Employee.new(employee_name, title)
        else
            raise ArgumentError.new "not a valid title"
        end
    end

    def size
        @employees.length
    end

    def pay_employee(employee)
        salary = salaries[employee.title]
        if @funding > salary
           employee.pay(salary)
           @funding -= salary
        else
            raise ArgumentError.new "not enough funding"
        end
    end 

    def payday
        @employees.each do |employee|
            self.pay_employee(employee)
        end
    end

    def average_salary
        salary_sum = 0
        @employees.each do |employee|
            salary_sum += salaries[employee.title]
        end
        salary_sum/@employees.length
    end

    def close
        @employees = []
        @funding = 0
    end

    def acquire(other_startup)
        @funding += other_startup.funding
        other_startup.salaries.each do |title, salary|
            if !@salaries.has_key?(title)
                @salaries[title] = salary
            end
        end
        @employees += other_startup.employees
        other_startup.close
    end
end
