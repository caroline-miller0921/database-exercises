
-- CASE STATEMENTS EXERCISES

-- Note to self:  this exercise is complete and accurate.

/*
1. Write a query that returns all employees, their department number, their start date, their end date, and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not.
*/

show databases;
USE employees;

select * from departments;
select * from employees limit 100;
select * from dept_emp limit 100; 

select concat(first_name, " ", last_name) as full_name, dept_no, from_date, to_date,
	case
		when to_date > now() then 1
		else 0
	end as is_current_employee
from dept_emp
join employees 
	on dept_emp.emp_no = employees.emp_no
;

/*
2. Write a query that returns all employee names (previous and current), and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.
*/

select concat(first_name, ' ', last_name) as full_name,
CASE
	WHEN substr(last_name, 1, 1) IN('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H') THEN 'A-H'
	WHEN substr(last_name, 1, 1) IN('I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q') THEN 'I-Q'
	WHEN substr(last_name, 1, 1) IN('R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z') THEN 'R-Z'
END AS alpha_group
FROM employees;	

-- OR

-- LEFT works like a substr but it starts from the left of the string
select first_name, last_name, 
	left(last_name, 1) as first_letter_of_last_name,
	case
		when left(last_name, 1) <= 'H' then 'A-H'
		when substr(last_name, 1, 1) <= 'Q' then 'I-Q'
		when left(last_name, 1) <= 'z' then 'R-Z'
	end as alpha_group
from employees;

-- WORKS TOO! Great!

/*
3. How many employees (current or previous) were born in each decade?
*/

select birth_date from employees
order by birth_date; -- earliest birthdate is 1952-02-01
select birth_date from employees
order by birth_date desc; -- latest birthdate is 1965-02-01
select * from employees limit 100;

select
	count(case when birth_date like '195%' then '50s baby' else null end) as '50s baby',
	count(case when birth_date like '196%' then '60s baby' else null end) as '60s baby'
from employees;

/*
50s baby	60s baby
182886		117138
*/

-- OR

SELECT
	concat(substr(birth_date, 1, 3), '0') as decade,
	count(*)
from employees
group by decade;

/*
decade		count(*)
1950		182886
1960		117138
*/

-- Works too!

/*
4. What is the current average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?
*/

select * from dept_emp limit 100;
select * from salaries limit 100;
select * from departments;

-- I need emp_no to join with dept_no
-- I'll join departments with dept_emp to link the dept_no 
-- Then I'll join dept_emp with salaries to link the emp_no
-- Ultimately I need to link departments with salaries

select round(avg(salary), 2) as avg_current_salary,
	case
		when dept_name in('research', 'development') then 'R&D'
		when dept_name in('sales', 'marketing') then 'Sales & Marketing'
		when dept_name in('quality Management', 'production') then 'Prod & QM'
		when dept_name in('finance', 'Human Resources') then 'Finance & HR'
		else dept_name
	END AS Department_Groups
from departments
JOIN dept_emp
	on departments.dept_no = dept_emp.dept_no and dept_emp.to_date > now()
JOIN salaries 
	on dept_emp.emp_no = salaries.emp_no AND salaries.to_date > now()
group by department_groups
order by department_groups;

/*
avg_current_salary		Department_Groups
67285.23				Customer Service
71107.74				Finance & HR
67328.50				Prod & QM
67709.26				R&D
86368.86				Sales & Marketing
*/


 