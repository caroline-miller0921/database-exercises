-- Tables Exercises 

USE employees;

SHOW TABLES;

DESCRIBE employees;
-- Data types:  int, date, string varchar, and enum ('M','F').
-- Could have used SHOW CREATE TABLE, DESCRIBE, or EXPLAIN

DESCRIBE departments;
DESCRIBE dept_emp;
DESCRIBE dept_manager;
DESCRIBE employees;
DESCRIBE salaries;
DESCRIBE titles;

/* Which table(s) do you think contain a numeric type column? 
dept_emp (int)
dept_manager (int)
employees (int)
salaries (int)
titles (int)
 */

/* Which table(s) do you think contain a string type column?
departments (char and varchar)
dept_emp (char)
dept_manager (char)
employees (varchar)
titles (varchar)
*/

/* Which table(s) do you think contain a date type column? 
dept_emp
dept_manager
employees
salaries
titles
*/


SELECT * FROM dept_emp;
/* What is the relationship between the employees and the departments tables? 
The dept_emp table tables contains both the employee numbers (emp_no) and the departments which each work in (dept_no). We can cross reference this table with the employees table which contains the names and the corresponding employee numbers and the departments table which contain the departments and their corresponding department numbers to then see in which department each employee works.  
*/

SHOW CREATE TABLE dept_manager;

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

-- FIN