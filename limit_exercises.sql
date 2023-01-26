-- LIMIT EXERCISES

-- Under the Clauses Tab of SQL 

SHOW DATABASES;

USE employees;

SELECT DISTINCT title FROM titles;

-- Question 2 Answer:
SELECT DISTINCT last_name FROM employees ORDER BY last_name DESC LIMIT 10;
/* First 10 distinct last name sorted in descending order: 
Zykh
Zyda
Zwicker
Zweizig
Zumaque
Zultner
Zucker
Zuberek
Zschoche
Zongker
*/

-- Question 3 Answer:
SELECT first_name, last_name FROM employees WHERE birth_date LIKE '%-12-25'
AND hire_date LIKE '199%' ORDER BY hire_date LIMIT 5;
/* 
Alselm	Cappello
Utz	Mandell
Bouchung	Schreiter
Baocai	Kushner
Petter	Stroustrup
*/

-- Question 4 Answer:
SELECT first_name, last_name FROM employees WHERE birth_date LIKE '%-12-25'
AND hire_date LIKE '199%' ORDER BY hire_date LIMIT 5 OFFSET 45;
/*
Tenth page of results:
Pranay	Narwekar
Marjo	Farrow
Ennio	Karcich
Dines	Lubachevsky
Ipke	Fontan
*/

-- The page I want: n
-- page Length * n-i == offset

/*
LIMIT and OFFSET can be used to create multiple pages of data. What is the relationship between OFFSET (number of results to skip), LIMIT (number of results per page), and the page number?

The page number = OFFSET + the LIMIT / LIMIT 

-- FIN

