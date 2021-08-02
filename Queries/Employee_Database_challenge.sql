-- DELIVERABLE 1
-- Create a list of employees born between 1952-01-01 and 1955-12-31
SELECT emp_no, first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

-- Create a list of titles
SELECT title, from_date, to_date
FROM titles;

-- Check the table
SELECT * FROM employees;

-- delete table
DROP TABLE employees CASCADE

-- recreated employees because deleted when not thinking
CREATE TABLE  employees (
	emp_no INT NOT NULL,
	birth_date DATE NOT NULL,
	first_name VARCHAR NOT NULL,
	last_name VARCHAR NOT NULL,
	gender VARCHAR NOT NULL,
	hire_date DATE NOT NULL,
	PRIMARY KEY (emp_no)
);

-- Join employees and titles tables
SELECT 
	e.emp_no,
	e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as t 
ON e.emp_no = t.emp_no
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31';

SELECT * FROM retirement_titles;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, title DESC;

SELECT * FROM unique_titles;

-- Count number of employee by job titles who are retiring
SELECT COUNT (ut.emp_no), ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY title
ORDER BY COUNT(title) DESC;

-- DELIVERABLE 2
-- List employees eligible to participate in mentorship program born between 1965-01-01 and 1965-12-31.
SELECT 
	e.emp_no, 
	e.first_name, 
	e.last_name, 
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO eligible_employees
FROM employees as e
INNER JOIN dept_emp as de ON (e.emp_no = de.emp_no)
INNER JOIN titles as t ON (e.emp_no = t.emp_no) 
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
	AND (de.to_date = '9999-01-01');

SELECT * FROM eligible_employees;

-- create table of CURRENT eligible employees , sorted by employee number and filtered by birthdate. 
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
from_date,
to_date,
title
INTO mentorship_eligibilty
FROM eligible_employees
ORDER BY emp_no ASC;

SELECT * FROM mentorship_eligibilty;

-- Next generation employees counted by titles
SELECT COUNT (mene.emp_no), mene.title
INTO available_titles
FROM mentorship_eligibilty as mene
GROUP BY title
ORDER BY COUNT(title) DESC;

SELECT * FROM available_titles;