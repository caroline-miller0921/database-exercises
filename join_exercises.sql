-- JOINS in MySQL

-- Types of JOINS:
-- LEFT JOIN
-- INNER JOIN (default join)
-- RIGHT JOIN

-- Each of these tells MySQL essentially what to do with NULL values


-- Differnece bewteen LEFT and RIGHT join: the order 

-- Answer to Question 2:

SHOW DATABASES;

USE employees;

select * from employees;
select * from dept_manager;
select * from departments;

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
select title, COUNT(*)
from titles
	JOIN dept_emp ON titles.emp_no = dept_emp.emp_no
	JOIN departments ON departments.dept_no = dept_emp.dept_no
		WHERE dept_emp.to_date > NOW()
		AND titles.to_date > NOW()
		AND dept_name = 'Customer Service'
	GROUP BY title;
/*
title	COUNT(*)
Senior Staff	11268
Staff	3574
Senior Engineer	1790
Engineer	627
Technique Leader	241
Assistant Engineer	68
Manager	1
*/

-- Answer to Question 5:
select first_name, last_name, salary
FROM dept_manager as dm 
	JOIN salaries as s
		USING (emp_no)
	JOIN employees 
		USING (emp_no)
WHERE dm.to_date > NOW()
AND s.to_date > NOW();
/*
first_name 	last_name	salary
Vishwani	Minakawa	106491
Isamu	Legleitner	83457
Karsten	Sigstam	65400
Oscar	Ghazalie	56654
Leon	DasSarma	74510
Dung	Pesch	72876
Hauke	Zhang	101987
Hilary	Kambil	79393
Yuchang	Weedman	58745
*/

-- Answer to Question 6:
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
LIMIT 4;
/*
Akemi	Warwick	145128	Marketing
Ingmar	Isard	143644	Marketing
Ortrud	Diderrich	142506	Marketing
Chikako	Jiang	142485	Marketing
*/

-- Answer to Question 9:
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
select dept_name, 
ROUND(AVG(salary), 0) as avg_sal
from salaries 
	JOIN dept_emp
		USING (emp_no)
	JOIN departments 
		USING (dept_no)
GROUP BY dept_name;
/*
Marketing	71913
Finance	70489
Human Resources	55575
Production	59605
Development	59479
Quality Management	57251
Sales	80668
Research	59665
Customer Service	58770
*/

/* 
11. Bonus Find the names of all current employees, their department name, and their current manager's name.
*/

/*
12. Bonus Who is the highest paid employee within each department.
*/


