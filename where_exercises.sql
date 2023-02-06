-- WHERE EXERCISES 
-- Under the Clauses Tab of SQL Instrction

SHOW DATABASES;

-- Exercise 1
USE employees;

SELECT * FROM employees;

/*
Exercise 2
Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya' using IN. Enter a comment with the number of records returned.
*/
SELECT COUNT(*) FROM employees WHERE first_name IN('Irena', 'Vidya', 'Maya');
-- 709

/*
Exercise 3
Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', as in Q2, but use OR instead of IN. Enter a comment with the number of records returned. Does it match number of rows from Q2?
*/
SELECT COUNT(*) FROM employees WHERE first_name = 'Irena'
OR first_name = 'Vidya'
OR first_name = 'Maya';
-- Also 709. Yay!

/* Exercise 4
Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', using OR, and who is male. Enter a comment with the number of records returned.
*/
SELECT COUNT(*) FROM employees WHERE first_name IN('Irena', 'Vidya', 'Maya')
	AND gender = 'M';
-- 441


SELECT COUNT(*) FROM employees 
WHERE first_name = 'Irena'
OR first_name = 'Vidya'
OR first_name = 'Maya'
	AND gender = 'M';
-- 619

-- THE ABOVE TWO COMMANDS ARE DIFFERENT BECAUSE THE AND CONDITION IS ONLY APPLYING TO MAYA

SELECT COUNT(*) FROM employees 
WHERE (first_name = 'Irena'
OR first_name = 'Vidya'
OR first_name = 'Maya')
	AND gender = 'M';
-- 441, NICE!

/*
Exercise 5
Find all current or previous employees whose last name starts with 'E'. Enter a comment with the number of employees whose last name starts with E.
*/
SELECT COUNT(*) FROM employees 
where last_name LIKE 'E%';
-- There are 7330 current or previous employees whose last names start with "E".

SELECT COUNT(*) as total_employees from employees;

SELECT COUNT(*) FROM employees
WHERE last_name LIKE '%E';
-- There are 24,292 previous or current employees whose last names end with "E".

/*
Exercise 6
Find all current or previous employees whose last name starts or ends with 'E'. Enter a comment with the number of employees whose last name starts or ends with E. 
*/

SELECT * FROM employees;

SELECT COUNT(*) FROM employees WHERE
last_name LIKE 'E%'
OR
last_name LIKE '%E';
-- 30,723 is the answer to QUESTION 6!

-- How many employees have a last name that ends with E, but does not start with E?
SELECT COUNT(*) FROM employees WHERE
last_name LIKE '%E'
AND NOT last_name LIKE 'E%';
-- 23393!

SELECT COUNT(*) FROM employees
WHERE last_name LIKE '%e';
-- 24292!

/*
Exerise 7

Find all current or previous employees employees whose last name starts and ends with 'E'. 
*/
SELECT COUNT(*) FROM employees
WHERE last_name LIKE 'E%'
	AND last_name LIKE '%E';
-- There are 899 previous or current employees whose last names start and end with "E".
-- OR
SELECT COUNT(*) FROM employees
Where last_name LIKE 'E%e';
-- 899!

/*
How many employees' last names end with E, regardless of whether they start with E?
*/
SELECT COUNT(*) FROM employees
WHERE last_name LIKE '%e';
-- 24292!

/*
Exercise 8

Find all current or previous employees hired in the 90s. Enter a comment with the number of employees returned.
*/
SELECT COUNT(*) FROM employees WHERE hire_date between 19900101 and 19991231;
-- 135214 employees were hired in the 1990s.
SELECT COUNT(*) FROM employees 
WHERE hire_date LIKE '199%';
-- 135214 as well!
-- OR
SELECT COUNT(*) FROM employees WHERE hire_date between '1990-01-01' and '1999-12-31';
-- 135214 as well!

/*
Exercise 9

Find all current or previous employees born on Christmas. Enter a comment with the number of employees returned.
*/
SELECT COUNT(*) FROM employees WHERE birth_date LIKE '%-12-25';
-- There are 842 previous or current employees with a birthday of Christmas Day.

/*
Exercise 10

Find all current or previous employees hired in the 90s and born on Christmas. Enter a comment with the number of employees returned.
*/
SELECT COUNT(*) FROM employees WHERE (hire_date between 19900101 and 19991231)
	AND (birth_date LIKE '%-12-25');
-- There are 362 previous or current employees who were hired in the 1990s and who have a birthday on Christmas Day.

/*
Exercise 11

Find all current or previous employees with a 'q' in their last name. Enter a comment with the number of records returned.
*/
SELECT COUNT(*) from employees WHERE last_name LIKE('%q%');
-- There are 1873 current or previous employees who have the letter "q" in their last name.
SELECT first_name, last_name
FROM `employees`Where last_name LIKE '%q%';
-- 1873!

/*
Exercise 12

Find all current or previous employees with a 'q' in their last name but not 'qu'. How many employees are found?
*/
SELECT COUNT(*) from employees WHERE last_name LIKE('%q%')
	AND NOT last_name LIKE('%qu%');
-- There are 547 current or previous employees who have the letter "q" but do not have "qu" in their last name.

-- FIN


