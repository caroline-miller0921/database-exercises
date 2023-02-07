
-- Temporary Tables Exercises MySQL

/*
1. Using the example from the lesson, create a temporary table called employees_with_departments that contains first_name, last_name, and dept_name for employees currently with that department. Be absolutely sure to create this table on your own database. If you see "Access denied for user ...", it means that the query was attempting to write a new table to a database that you can only read.
*/

show databases;

use employees;

select * from dept_emp limit 100;
select * from departments;
select * from employees limit 100;

-- I need names from employees

select first_name, last_name, dept_name from departments
	JOIN dept_emp
		on dept_emp.dept_no = departments.dept_no and dept_emp.to_date > now()
	JOIN employees
		on dept_emp.emp_no = employees.emp_no
;

create temporary table oneil_2099.cur_emp_dept as
(
	select first_name, last_name, dept_name from departments
		JOIN dept_emp
			on dept_emp.dept_no = departments.dept_no and dept_emp.to_date > now()
		JOIN employees
			on dept_emp.emp_no = employees.emp_no
);

select * from oneil_2099.cur_emp_dept limit 500;

/*
a. Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns.
*/

use `oneil_2099`;

use employees;

select length(first_name) from employees
order by length(first_name) desc;

select length(last_name) from employees
order by length(last_name) desc;

use oneil_2099;

select * from cur_emp_dept;
ALTER TABLE cur_emp_dept add full_name varchar(30) not null;

describe cur_emp_dept;

/*
b. Update the table so that the full_name column contains the correct data.
*/

update cur_emp_dept
SET full_name = concat(first_name, " ", last_name);

select * from cur_emp_dept limit 100;

-- ALTER changes the table structure
-- UPDATE changes the data

/*
c. Remove the first_name and last_name columns from the table.
*/

alter table cur_emp_dept
drop column first_name,
drop column last_name;

alter table cur_emp_dept
drop column last_name;

select * from cur_emp_dept limit 100;

/*
d. What is another way you could have ended up with this same table?
*/

show databases;

use employees;

select dept_name, concat(first_name, ' ', last_name) from departments
		JOIN dept_emp
			on dept_emp.dept_no = departments.dept_no and dept_emp.to_date > now()
		JOIN employees
			on dept_emp.emp_no = employees.emp_no
;

create temporary table oneil_2099.emp_full_name_dept as
(
	select dept_name, concat(first_name, ' ', last_name) from departments
		JOIN dept_emp
			on dept_emp.dept_no = departments.dept_no and dept_emp.to_date > now()
		JOIN employees
			on dept_emp.emp_no = employees.emp_no
);

use oneil_2099;

select * from emp_full_name_dept limit 1000;

/*
2. Create a temporary table based on the payment table from the sakila database.
*/

use sakila;

show tables;
select min(payment_date) from payment; -- 2005-05-24 22:53:30
select max(payment_date) from payment; -- 2006-02-14 15:16:03
select * from payment;
describe payment;

select *,
	case 
		when payment_date like '2005-05-%' then 'MAY-2005'
		when payment_date like '2005-06-%' then 'JUN-2005'
		when payment_date like '2005-07-%' then 'JUL-2005'
		when payment_date like '2005-08-%' then 'AUG-2005'
		when payment_date like '2005-09-%' then 'SEP-2005'
		when payment_date like '2005-10-%' then 'OCT-2005'
		when payment_date like '2005-11-%' then 'NOV-2005'
		when payment_date like '2005-12-%' then 'DEC-2005'
		when payment_date like '2006-01-%' then 'JAN-2006'
		when payment_date like '2006-02-%' then 'FEB-2006'
	end as month_year_purchased
from payment
order by month_year_purchased;

create temporary table oneil_2099.payment_mo_yr
	(
	select *,
	case 
		when payment_date like '2005-05-%' then 'MAY-2005'
		when payment_date like '2005-06-%' then 'JUN-2005'
		when payment_date like '2005-07-%' then 'JUL-2005'
		when payment_date like '2005-08-%' then 'AUG-2005'
		when payment_date like '2005-09-%' then 'SEP-2005'
		when payment_date like '2005-10-%' then 'OCT-2005'
		when payment_date like '2005-11-%' then 'NOV-2005'
		when payment_date like '2005-12-%' then 'DEC-2005'
		when payment_date like '2006-01-%' then 'JAN-2006'
		when payment_date like '2006-02-%' then 'FEB-2006'
	end as month_year_purchased
from payment
order by month_year_purchased
	);
	
select * from oneil_2099.payment_mo_yr;

describe oneil_2099.payment_mo_yr;

/*
Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. For example, 1.99 should become 199.
*/

create temporary table oneil_2099.payments as
select * from payment;

use oneil_2099;

select * from payments;

alter table payments 
modify amount decimal(10, 2);

select * from payments;

describe payments;

update payments 
set amount = amount * 100;

select * from payments;

alter table payments 
modify amount int;

select * from payments;

/*
3. Find out how the current average pay in each department compares to the overall current pay for everyone at the company. For this comparison, you will calculate the z-score for each salary. 
*/

use employees;
show tables;
select * from dept_emp limit 100;

-- subquery
select avg(salary) from salaries
where to_date > now(); -- avg salary = 72012.2359

select * from salaries limit 100;

-- subquery
select dept_name, round(avg(salary), 2) as cur_avg_pay
from departments 
	join dept_emp 
		using (dept_no)
	join salaries 
		using (emp_no)
where salaries.to_date > now()
and dept_emp.to_date > now()
group by dept_name;

-- subquery
select stddev(salary) from salaries
where to_date > now(); -- 17309.95933634675
	
create temporary table oneil_2099.avg_dept_salaries as -- insert subquery for avg sal by department 
	(
select dept_name, round(avg(salary), 2) as cur_avg_pay
from departments 
	join dept_emp 
		using (dept_no)
	join salaries 
		using (emp_no)
where salaries.to_date > now()
and dept_emp.to_date > now()
group by dept_name
	)
;

select * from oneil_2099.avg_dept_salaries;

-- switch to Oneil DB
use oneil_2099;

alter table avg_dept_salaries
add overall_std_salary float; -- added new column for stddev

alter table avg_dept_salaries
add overall_avg_salary float; -- added column for avg company salary

select * from avg_dept_salaries;

-- Adding subqueries to new columns
update avg_dept_salaries
set overall_avg_salary = 
	(
	select round(avg(salary), 2) from employees.salaries
	where salaries.to_date > now()
	);

update avg_dept_salaries
set overall_std_salary =
	(
	select round(stddev(salary), 2) from employees.salaries
	where salaries.to_date > now()
	);
	
select * from avg_dept_salaries;
-- verified

-- now to add the column to calcuate the z scores
alter table avg_dept_salaries
add zscore float;

update avg_dept_salaries
set zscore = (cur_avg_pay - overall_avg_salary) / overall_std_salary;

select * from avg_dept_salaries;

/*
In terms of salary, what is the best department right now to work for? 
*/

select * from avg_dept_salaries
order by zscore desc;
-- the best department right now to work is sales with a zscore of .972892

/*
The worst?
*/
-- the worst department right now to work is human resources with a zscore of -.467381








