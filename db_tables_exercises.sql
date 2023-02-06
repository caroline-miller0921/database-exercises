
-- DB Tables Exercises MySQL


-- Exercise 3
show databases;

-- Exercise 4
use albums_db;

-- Exercise 5
select database();

-- Exercise 6
show tables;

-- Exercise 7
use employees;

-- Exercise 8
select database();

-- Exercise 9
show tables;

-- Exercise 10
describe employees;

/*
field	type	Null	Key	Default
emp_no	int	NO	PRI	NULL	
birth_date	date	NO		NULL	
first_name	varchar(14)	NO		NULL	
last_name	varchar(16)	NO		NULL	
gender	enum('M','F')	NO		NULL	
hire_date	date	NO		NULL	
*/

-- Exercise 11
/* Which table(s) do you think contain a numeric type column? (Write this question and your answer in a comment)

dept_emp (int)
dept_manager (int)
employees (int)
salaries (int)
titles (int)

-- Exercise 12
Which table(s) do you think contain a string type column? (Write this question and your answer in a comment)

departments (char and varchar)
dept_emp (char)
dept_manager (char)
employees (varchar)
titles (varchar)

-- Exercise 13
Which table(s) do you think contain a date type column? (Write this question and your answer in a comment)

dept_emp
dept_manager
employees
salaries
titles

-- Exercise 14
What is the relationship between the employees and the departments tables? (Write this question and your answer in a comment)

The dept_emp table tables contains both the employee numbers (emp_no) and the departments which each work in (dept_no). We can cross reference this table with the employees table which contains the names and the corresponding employee numbers and the departments table which contain the departments and their corresponding department numbers to then see in which department each employee works.  

-- Exercise 15
Show the SQL that created the dept_manager table. Write the SQL it takes to show this as your exercise solution.
*/

show create table dept_manager;

CREATE TABLE `dept_manager` (
  `emp_no` int NOT NULL,
  `dept_no` char(4) NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date NOT NULL,
  PRIMARY KEY (`emp_no`,`dept_no`),
  KEY `dept_no` (`dept_no`),
  CONSTRAINT `dept_manager_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employees` (`emp_no`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `dept_manager_ibfk_2` FOREIGN KEY (`dept_no`) REFERENCES `departments` (`dept_no`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=latin1



