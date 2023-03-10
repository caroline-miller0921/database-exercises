-- FUNCTIONS EXERCISES

SHOW DATABASES;

USE employees;

select * from employees;

select * from employees LIMIT 5;

-- Answer to Question 2:
select first_name, last_name, 
concat(first_name, " ", last_name) as full_name
from employees WHERE last_name LIKE('E%E');

-- Answer to Question 3:
select first_name, last_name, 
UPPER(concat(first_name, " ", last_name)) as full_name
from employees where last_name LIKE('E%e');

-- Answer to Question 4:
select 
hire_date, 
curdate(), 
datediff(curdate(), hire_date) as days_at_company
from employees WHERE hire_date LIKE '199%'
and birth_date LIKE '%-12-25';

-- Answer to Question 5:
select * from salaries;

select min(salary) as smallest_salary, max(salary) as largest_salary  from salaries where to_date = '9999-01-01';
	-- we put the where clause to find the most current salary for each employee number


-- Answer to Question 6:
	-- To return the first letter of the first name
select first_name, LOWER(substr(first_name, 1, 1)) from employees LIMIT 5;
	-- to return the first four letters of the last name
select last_name, LOWER(substr(last_name, 1, 4)) from employees LIMIT 5;
	-- to return the two digit month of the birth date
select birth_date, substr(birth_date, 6, 2) from employees LIMIT 5;
-- OR you can use LPAD
select lpad(month(birth_date), 2, 0) from employees;
	-- to return the last to digits of the birth year
select birth_date, substr(birth_date, 3, 2) from employees LIMIT 5;

	-- full command to return the username
select first_name, last_name, birth_date, 
LOWER(
concat
(
(substr(first_name, 1, 1)), 
(substr(last_name, 1, 4)), 
'_', 
substr(birth_date, 6, 2), 
substr(birth_date, 3, 2)
) 
)
as username from employees;


