-- JOINS in MySQL

-- Types of JOINS:
-- LEFT JOIN
-- INNER JOIN (default join)
-- RIGHT JOIN

-- Each of these tells MySQL essentially what to do with NULL values


-- Differnece bewteen LEFT and RIGHT join: the order 

/*
Join Example Database 

1. Use the join_example_db. Select all the records from both the users and roles tables.
*/

show databases;

use `join_example_db`;

show tables;

select * from roles;

select * from users;

/*
2. Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. Before you run each query, guess the expected number of results.
*/

select * from roles as r 
join users as u 
	on u.role_id = r.id;
	
select * from roles as r 
left join users as u 
	on u.role_id = r.id;
	
select * from roles as r 
right join users as u 
	on u.role_id = r.id;

select * from users as u
left join roles as r 
	on u.role_id = r.id;
	
select * from users as u
right join roles as r 
	on u.role_id = r.id;

select * from users as u
join roles as r 
	on u.role_id = r.id;
	
/*
3. Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries. Use count and the appropriate join type to get a list of roles along with the number of users that has the role. Hint: You will also need to use group by in the query.
*/

select * from roles;

select * from users;

select r.id, r.name, count(r.name) as total_users
from roles as r
	left join users as u
		on r.id = u.role_id
group by id, r.name 
;

-- Employees Database Exercises

SHOW DATABASES;

-- Answer to Question 1:
USE employees;

select * from employees;
select * from dept_manager;
select * from departments;

-- Answer to Question 2:
/*
Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department.
*/

select dept.dept_name, -- you dont necessarily need "dept" because 'dept_name only exists in one table in this schema, doing this solely for readability
CONCAT(emp.first_name, ' ', emp.last_name) as emp_name
FROM departments as dept
	JOIN dept_manager as dm
		USING (dept_no) -- could have used ON as well, but USING is more of a shortcut
	JOIN employees as emp
		USING (emp_no)
	
WHERE to_date > NOW();
/*
dept_name	emp_name
Marketing	Vishwani Minakawa
Finance	Isamu Legleitner
Human Resources	Karsten Sigstam
Production	Oscar Ghazalie
Development	Leon DasSarma
Quality Management	Dung Pesch
Sales	Hauke Zhang
Research	Hilary Kambil
Customer Service	Yuchang Weedman
*/

-- Answer to Question 3:
/*
Find the name of all departments currently managed by women.
*/

select departments.dept_name,
CONCAT(employees.first_name, ' ', employees.last_name) as full_name
from departments 
	JOIN dept_manager
		USING (dept_no)
	JOIN employees employees
		USING (emp_no)
WHERE to_date > NOW()
AND gender = 'F';
/*
dept_name	full_name
Finance	Isamu Legleitner
Human Resources	Karsten Sigstam
Development	Leon DasSarma
Research	Hilary Kambil		
*/

-- Answer to Question 4:
/*
Find the current titles of employees currently working in the Customer Service department.
*/

select title, COUNT(*)
from titles
	JOIN dept_emp ON titles.emp_no = dept_emp.emp_no
	JOIN departments ON departments.dept_no = dept_emp.dept_no
		WHERE dept_emp.to_date > NOW()
		AND titles.to_date > NOW()
		AND dept_name = 'Customer Service'
	GROUP BY title;
/*
title				COUNT(*)
Senior Staff		11268
Staff				3574
Senior Engineer		1790
Engineer			627
Technique Leader	241
Assistant Engineer	68
Manager				1
*/

-- Answer to Question 5:
-- Find the current salary of all current managers.

select concat(first_name, ' ', last_name) as full_name, salary, dept_name
FROM departments 
	join dept_manager as dm
		using (dept_no)
	join salaries as s
		using (emp_no)
	join employees 
		using (emp_no)
where dm.to_date > now()
and s.to_date > now()
	;

/*
full_name			salary			dept_name
Vishwani Minakawa	106491			Marketing
Isamu Legleitner	83457			Finance
Karsten Sigstam		65400			Human Resources
Oscar Ghazalie		56654			Production
Leon DasSarma		74510			Development
Dung Pesch			72876			Quality Management
Hauke Zhang			101987			Sales
Hilary Kambil		79393			Research
Yuchang Weedman		58745			Customer Service
*/

-- Answer to Question 6:
-- Find the number of current employees in each department.
select dept_no, dept_name, COUNT(*) num_employees
from employees
	JOIN dept_emp de 
		USING (emp_no)
	JOIN departments 
		USING (dept_no)
WHERE de.to_date > NOW()
group by dept_name;
/*
dept_no	dept_name	num_employees
d009	Customer Service	17569
d005	Development	61386
d002	Finance	12437
d003	Human Resources	12898
d001	Marketing	14842
d004	Production	53304
d006	Quality Management	14546
d008	Research	15441
d007	Sales	37701
*/

-- Answer to Question 7:
/*
Which department has the highest average salary? Hint: Use current not historic information.
*/

select dept_name, AVG(salary) as avg_sal
from salaries s
	JOIN dept_emp de
		USING (emp_no)
	JOIN departments
		USING (dept_no)
where de.to_date > NOW()
and s.to_date > NOW()
group by dept_name
order by avg_sal desc
LIMIT 1;	
/*
dept_name	avg_sal
Sales	88852.9695
*/

-- Answer to Question 8:
-- Who is the highest paid employee in the Marketing department?

select first_name, last_name, salary, dept_name
from employees
	JOIN dept_emp as de
		USING (emp_no)
	JOIN departments as d
		USING (dept_no)
	JOIN salaries as s
		USING (emp_no)
where dept_name = 'Marketing'
and de.to_date > NOW()
and s.to_date > NOW()
order by salary desc
LIMIT 1;
/*
Akemi	Warwick	145128	Marketing
*/

-- Answer to Question 9:
-- Which current department manager has the highest salary?

select first_name, last_name, salary, dept_name
from dept_manager as dm
	JOIN employees
		USING (emp_no)
	JOIN salaries s
		USING (emp_no)
	JOIN departments 
		USING (dept_no)
where dm.to_date > NOW()
and s.to_date > NOW()
order by salary DESC
LIMIT 1;
/*
Vishwani	Minakawa	106491	Marketing
*/

-- Answer to Question 10:
/*
Determine the average salary for each department. Use all salary information and round your results.
*/

select dept_name, 
ROUND(AVG(salary), 0) as avg_sal
from salaries 
	JOIN dept_emp
		USING (emp_no)
	JOIN departments 
		USING (dept_no)
GROUP BY dept_name;
/*
Marketing			71913
Finance				70489
Human Resources		55575
Production			59605
Development			59479
Quality Management	57251
Sales				80668
Research			59665
Customer Service	58770
*/

/* 
11. Bonus Find the names of all current employees, their department name, and their current manager's name.
*/

show tables;
select * from dept_manager;

select concat(employees.first_name, ' ', employees.last_name) as full_name, dept_name, concat(managers.first_name, ' ', managers.last_name) as manager_name
from employees as managers
	join dept_manager using (emp_no) -- getting the dept managers using their emp no
	join departments using (dept_no) -- getting dept managers' depts usnig dept no
	join dept_emp using (dept_no) -- linking with all the emps using dept no
	join employees on dept_emp.emp_no = employees.emp_no
where dept_manager.to_date > now()
and dept_emp.to_date > now()
;


/*
12. Bonus Who is the highest paid employee within each department.
*/

select * from salaries limit 100;
select * from dept_emp limit 100;
select * from employees limit 100;

-- My attempt
select max_sal_by_dept.highest_salary, max_sal_by_dept.dept_name, dept_name_emp_name.full_name from
-- returns max salary and dept name
(
select max(s.salary) as highest_salary, d.dept_name
from salaries as s 
join dept_emp as de using (emp_no)
join departments as d using (dept_no)
join employees as e using (emp_no)
where s.to_date > now()
and de.to_date > now()
group by d.dept_name) as max_sal_by_dept
LEFT JOIN 
(select concat(first_name, ' ', last_name) as full_name, dept_name
from employees e
join dept_emp as de using (emp_no)
join departments as d using (dept_no)) as dept_name_emp_name
;


-- Madeleine's Answer
SELECT dmock.dept_name, dmock.sal, salmock.namebo FROM

(
-- First query: dmock.
SELECT d.dept_name, d.dept_no, max(s.salary) AS sal
FROM salaries s
JOIN dept_emp de USING(emp_no)
JOIN departments d USING(dept_no)
WHERE de.to_date > NOW() AND s.to_date > NOW()
GROUP BY dept_name) dmock
-- join dmock to our second query.
LEFT JOIN 
(SELECT CONCAT(e.first_name, ' ', e.last_name) namebo, s.salary, d.dept_name
FROM employees e
JOIN salaries s USING (emp_no)
JOIN dept_emp de USING (emp_no)
JOIN departments d USING (dept_no)
WHERE de.to_date > NOW()
AND s.to_date > NOW()) salmock
-- how do we want to join dmock with salmock?
-- well, I want to get the names of the current employees that belong to those
-- specific salary and department names that I pulled from dmock
ON dmock.dept_name = salmock.dept_name AND dmock.sal = salmock.salary;	
/*
SELECT CONCAT(e.first_name, ' ', e.last_name) namebo, s.salary, d.dept_name
FROM employees e
JOIN salaries s USING (emp_no)
JOIN dept_emp de USING (emp_no)
JOIN departments d USING (dept_no)
WHERE de.to_date > NOW()
AND s.to_date > NOW(); 

SELECT d.dept_name, d.dept_no, max(s.salary) AS sal
FROM salaries s
JOIN dept_emp de USING(emp_no)
JOIN departments d USING(dept_no)
WHERE de.to_date > NOW() AND s.to_date > NOW()
GROUP BY dept_name;
*/
