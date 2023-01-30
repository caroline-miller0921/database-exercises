-- GROUP BY EXERCISES

SHOW DATABASES;

USE employees;

select * from titles;

-- Answer to Question 2:
select distinct(title) from titles;

select count(distinct(title)) from titles;
-- There are 7 distinct titles.

-- Answer to question 3:
select last_name from employees where last_name like 'E%e' group by last_name;
/*
Erde
Eldridge
Etalle
Erie
Erbe
*/

-- Answer to Question 4:
select first_name, last_name from employees where last_name like 'E%E' group by last_name, first_name;

-- Answer to Question 5:
select last_name from employees where last_name like ('%q%') AND NOT last_name LIKE ('%qu%') group by last_name;
/* Unique last names with 'Q' not 'QU':
Chleq
Lindqvist
Qiwen
*/

-- Answer to Question 6:
select last_name, count(last_name) from employees where last_name like ('%q%') and last_name NOT like '%qu%' group by last_name;
/*
Chleq	189
Lindqvist	190
Qiwen	168
*/

-- Answer to Question 7:
select gender, count(first_name) from employees where first_name IN('Irena', 'Maya', 'Vidya') group by gender;
/*
M	441
F	268
*/
select first_name, gender, count(first_name) from employees where first_name IN('Irena', 'Maya', 'Vidya') group by first_name, gender;
/*
Vidya	M	151
Irena	M	144
Irena	F	97
Maya	F	90
Vidya	F	81
Maya	M	146
*/

-- Answer to Question 8:
select count(*),
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
as username from employees
group by username
;
-- 285872 unuique usernames

-- Answer to Question 9:
select count(*) as count_un,
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
as username from employees
group by username
having count_un > 1
;
-- There are 13251 usernames with duplicates (bonus!)

select count(*) as count_un,
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
as username from employees
group by username
having count_un > 1
order by count_un DESC;
-- The highest number of times that a username is used is 6

-- BONUS PRACTICE --
select * from salaries LIMIT 100;

-- Determine the historic average salary for each employee. When you hear, read, or think "for each" with regard to SQL, you'll probably be grouping by that exact column
select emp_no, avg(salary) from salaries
group by emp_no;

select *  from dept_emp;

-- Using the dept_emp table, count how many current employees work in each department. The query result should show 9 rows, one for each department and the employee count.
select dept_no, count(emp_no)as emp_count  from dept_emp group by dept_no;
/*
d001	20211
d002	17346
d003	17786
d004	73485
d005	85707
d006	20117
d007	52245
d008	21126
d009	23580
*/

-- Determine how many different salaries each employee has had. This includes both historic and current.
select * from salaries LIMIT 20;
select emp_no, count(distinct(salary)) as sal_count from salaries 
group by emp_no;

-- Find the maximum salary for each employee.
select emp_no, max(salary) as max_salary from salaries
group by emp_no;

-- Find the minimum salary for each employee.
select emp_no, min(salary) as min_salary from salaries
group by emp_no;

-- Find the standard deviation of salaries for each employee.
select emp_no, std(salary) as std_per_emp from salaries
group by emp_no;

-- Now find the max salary for each employee where that max salary is greater than $150,000.
select emp_no, max(salary) as max_salary from salaries
group by emp_no
having max_salary > '150000';

-- Find the average salary for each employee where that average salary is between $80k and $90k.
select emp_no, avg(salary) as avg_salary from salaries 
group by emp_no
having avg_salary between '80000' and '90000';


