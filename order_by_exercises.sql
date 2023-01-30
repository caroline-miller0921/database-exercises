-- ORDER BY EXERCISES 

-- Under the Clauses Tab - SQL

SHOW DATABASES;

USE employees;

SELECT * FROM employees LIMIT 5;

-- Question 2 Answer:
SELECT * FROM employees WHERE first_name IN('Irena', 'Vidya', 'Maya')
ORDER BY first_name;
-- The name first in the results is Irena Reutenauer
SELECT * FROM employees WHERE first_name IN('Irena', 'Vidya', 'Maya')
ORDER BY first_name DESC;
-- The last name in the results is Vidya Awdeh

-- Question 3 Answer:
SELECT * FROM employees WHERE first_name IN('Irena', 'Vidya', 'Maya')
ORDER BY first_name, last_name;
-- The first name in the results is Irena Action
SELECT * FROM employees WHERE first_name IN('Irena', 'Vidya', 'Maya')
ORDER BY first_name DESC, last_name DESC;
-- The last name in the results is Vidya Zweizig

-- Question 4 Answer:
SELECT * FROM employees WHERE first_name IN('Irena', 'Vidya', 'Maya')
ORDER BY last_name, first_name;
-- The first name in the results is Irena Action
SELECT * FROM employees WHERE first_name IN('Irena', 'Vidya', 'Maya')
ORDER BY last_name DESC, first_name DESC;
-- The last name in the results is Maya Zyda

-- Question 5 Answer:
SELECT * FROM employees WHERE last_name LIKE 'E%e' ORDER BY emp_no;
-- 899 employees returned 
-- First employee number: 10021, first name: Ramzi, last name: Erde
SELECT * FROM employees WHERE last_name LIKE 'E%e' ORDER BY emp_no DESC;
-- Last employee number: 499648, first name: Tadahiro, last name: Erde

-- Question 6 Answer:
SELECT * FROM employees WHERE last_name LIKE 'E%e' ORDER BY hire_date DESC;
-- 899 employees returned
-- Newest employee: Teiji Eldridge
SELECT * FROM employees WHERE last_name LIKE 'E%e' ORDER BY birth_date;
-- Oldest employee: Piyush Erbe

-- Question 7 Answer:
SELECT * FROM employees WHERE birth_date LIKE '%-12-25'
AND hire_date LIKE '199%' ORDER BY birth_date, hire_date DESC;
-- 362 results
-- Oldest employee who was hired last is Khun Bernini
SELECT * FROM employees WHERE birth_date LIKE '%-12-25'
AND hire_date LIKE '199%' ORDER BY birth_date DESC, hire_date;
-- Youngest employee who was hired first:  Douadi Pettis

-- FIN





