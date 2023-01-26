-- WHERE EXERCISES 
-- Under the Clauses Tab of SQL Instrction

SHOW DATABASES;

USE employees;

SELECT * FROM employees;

SELECT COUNT(*) FROM employees WHERE first_name IN('Irena', 'Vidya', 'Maya');
-- 709

SELECT COUNT(*) FROM employees WHERE first_name = 'Irena'
OR first_name = 'Vidya'
OR first_name = 'Maya';
-- Also 709. Yay!

SELECT COUNT(*) FROM employees 
WHERE first_name = 'Irena'
OR first_name = 'Vidya'
OR first_name = 'Maya'
	AND gender = 'M';
-- 619

SELECT COUNT(*) FROM employees 
where last_name LIKE 'E%';
-- There are 7330 current or previous employees whose last names start with "E".

SELECT COUNT(*) as total_employees from employees;

SELECT COUNT(*) FROM employees
WHERE last_name LIKE '%E';
-- There are 24,292 previous or current employees whose last names end with "E".

SELECT COUNT(*) FROM employees
WHERE last_name LIKE 'E%'
	AND last_name LIKE '%E';
-- There are 899 previous or current employees whose last names start and end with "E".

SELECT * FROM employees;

SELECT COUNT(*) FROM employees WHERE hire_date between 19900101 and 19991231;
-- 135214 employees were hired in the 1990s.

SELECT COUNT(*) FROM employees WHERE birth_date LIKE '%-12-25';
-- There are 842 previous or current employees with a birthday of Christmas Day.

SELECT COUNT(*) FROM employees WHERE hire_date between 19900101 and 19991231
	AND birth_date LIKE '%-12-25';
-- There are 362 previous or current employees who were hired in the 1990s and who have a birthday on Christmas Day.

SELECT COUNT(*) from employees WHERE last_name LIKE('%q%');
-- There are 1873 current or previous employees who have the letter "q" in their last name.

SELECT COUNT(*) from employees WHERE last_name LIKE('%q%')
	AND NOT last_name LIKE('%qu%');
-- There are 547 current or previous employees who have the letter "q" but do not have "qu" in their last name.

-- FIN


