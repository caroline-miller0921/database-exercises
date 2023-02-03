-- SUBQUERIES EXERCISES

SHOW DATABASES;

USE employees;
/*
1. Find all the current employees with the same hire date as employee 101010 using a subquery.
*/

select * from employees LIMIT 100;
select * from dept_emp LIMIT 100;
-- subquery:  finding the hire date of employee 101010
select * from employees
where emp_no = '101010';

-- Outer query
select first_name, last_name, emp_no, to_date, hire_date
from employees
	JOIN dept_emp
		USING (emp_no)
WHERE hire_date = (select hire_date from employees
where emp_no = '101010') -- Cannot use table in a where clause
and to_date > NOW();
						
/*
2. Find all the titles ever held by all current employees with the first name Aamod.
*/

-- subquery
select * from employees 
where first_name = 'Aamod';

select * from employees limit 100;
select* from titles limit 100;

-- Outer Query

select distinct title
from (
	select * from employees 
	where first_name = 'Aamod'
	) as aamod_emps
JOIN titles
		USING (emp_no)
WHERE to_date > now()
group by title; -- in this the subquery is in the derived table

-- OR

select distinct title
from titles
	JOIN employees
		USING (emp_no)
WHERE emp_no in
(	select emp_no from employees 
	where first_name = 'Aamod'
)
AND to_date > now(); -- in this the subquery is in the where clause

/*
3. How many people in the employees table are no longer working for the company? Give the answer in a comment in your code.
*/
select * from employees limit 100;
select * from dept_emp limit 100;

-- Subquery
select * from employees 
	JOIN dept_emp
		USING (emp_no)
where to_date < now();

-- Outer Query
select distinct(count(*))
from 
	(
	select * from employees 
	JOIN dept_emp
		USING (emp_no)
	where to_date < now()
	) as emp_terminated;
-- 91479 WRONG

-- OR

select count(emp_no) from employees
where emp_no not in
	(
	select emp_no
	from dept_emp
	where to_date > now()
	)
; -- Answern 59900 RIGHT

/*
4. Find all the current department managers that are female. List their names in a comment in your code.
*/

-- Subquery
select * from dept_manager limit 100;
select * from dept_emp limit 100;
select * from departments;
select * from employees limit 100;

select * from dept_manager
where to_date > now();


-- Outer Query
select concat(first_name, ' ', last_name)
from 
	(
		select * from dept_manager
		where to_date > now()
	) as current_managers
	JOIN employees
		USING (emp_no)
WHERE gender = 'F';

/*
Isamu Legleitner
Karsten Sigstam
Leon DasSarma
Hilary Kambil
*/

/*
5. Find all the employees who currently have a higher salary than the companies overall, historical average salary.
*/

-- Subquery: Finding the historical avg salary
select avg(salary) from salaries;

-- Outer Query

select * from salaries limit 100;

select first_name, last_name, salary, to_date
from employees 
	JOIN salaries 
		USING (emp_no)
where salary > (select avg(salary) from salaries)
and to_date > now();

/*
6. How many current salaries are within 1 standard deviation of the current highest salary? (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?
*/

select * from salaries order by salary desc;
select * from salaries limit 200;
-- Subquery:  the standard deviation of salaries
select STDDEV(salary) from salaries
where to_date > now();

-- Subquery: The current max salary
select max(salary) from salaries
where to_date > now();

-- Outer Query
select *
from salaries
where to_date > now()
and salary between 
(
	(
	select max(salary) from salaries
	where to_date > now() -- the current max salary = 158220
	) - -- minus 1 standard deviation
	(
	select STDDEV(salary) from salaries
where to_date > now()) -- 1 standard deviation = 17309.95933634675
	)
AND
(
	select max(salary) from salaries
	where to_date > now() -- the current max salary = 158220
) 
order by salary desc
	;

-- 83

select (158220 - 17309.95933634675);
-- this equals 141315.17171199986

-- PERCENTAGE 

select  
((
select count(*)
from salaries
where salary between 
(
	(
	select max(salary) from salaries
	where to_date > now() -- the current max salary = 158220
	) - -- minus 1 standard deviation
	(
	select STDDEV(salary) from salaries) -- 1 standard deviation = 16904.82828800014
	)
AND
(
	select max(salary) from salaries
	where to_date > now() -- the current max salary = 158220
) 
) 
/
(select count(*) from salaries))
* 100
; 

-- .0074%

-- BONUS --
/*
1. Find all the department names that currently have female managers.
*/

select * from dept_manager;

-- Subquery: Which managers are female?
select dept_manager.*, employees.* from dept_manager
	JOIN employees
		USING (emp_no)
where gender = 'F';

-- Outer Query
select * from departments;
select dept_name from departments 
	JOIN
		(
		select dept_manager.*, employees.* from dept_manager
	JOIN employees
		USING (emp_no)
where gender = 'F'
		) departments_w_fem_managers
	



