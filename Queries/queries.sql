-- testing to see if tables work

SELECT *
FROM departments;

SELECT *
FROM dept_emp;

SELECT *
FROM dept_manager;

SELECT *
FROM employees;

SELECT *
FROM salaries;

SELECT *
FROM titles;

-- Retirement eligibility

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

-- Number of employees retiring

SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31') ;


-- create a new table with all employees eligible for retirement 

SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31'); 

-- Create new table for retiring employees

SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- Check the table

SELECT * FROM retirement_info;


-- Joining departments and dept_manager tables

SELECT departments.dept_name,
     dept_manager.emp_no,
     dept_manager.from_date,
     dept_manager.to_date
FROM departments
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;


-- Joining retirement_info and dept_emp tables

SELECT retirement_info.emp_no,
	retirement_info.first_name,
retirement_info.last_name,
	dept_emp.to_date
FROM retirement_info
LEFT JOIN dept_emp
ON retirement_info.emp_no = dept_emp.emp_no;

-- Joining departments and dept_manager tables

SELECT dept_name,
       emp_no,
       from_date,
       to_date
FROM departments 
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;

-- create current employees table

SELECT ri.emp_no,
	   ri.first_name,
	   ri.last_name,
	   de.to_date
INTO current_emp
FROM retirement_info AS ri
LEFT JOIN
dept_emp AS de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');

-- check the table

SELECT * 
FROM current_emp;

--create new table to count current employees per department

SELECT COUNT(ce.emp_no), de.dept_no
INTO emp_dept_count
FROM current_emp AS ce
LEFT JOIN dept_emp AS de
ON ce.emp_no = de.emp_no
GROUP BY dept_no;

-- check the table

SELECT *
FROM emp_dept_count;


-- create new table with all current employees eligible for retirement with their genders and salaries

SELECT e.emp_no,
	e.first_name,
	e.last_name,
	e.gender,
	s.salary,
	de.to_date
INTO emp_info
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
AND (de.to_date = '9999-01-01');

--  check the table 

SELECT *
FROM emp_info;


--  create a table of managers eligible for retirement

SELECT dm.emp_no, 
	  d.dept_name,
	  ce.last_name,
	  ce.first_name,
	  dm.from_date,
	  dm.to_date
INTO manager_info
FROM dept_manager as dm
INNER JOIN departments as d
ON dm.dept_no = d.dept_no
INNER JOIN current_emp as ce
ON dm.emp_no = ce.emp_no;

--  check the table 

SELECT *
FROM manager_info;


--  create a table with all current employees and their department info

SELECT ce.emp_no,
	   ce.first_name,
	   ce.last_name,
	   d.dept_name
INTO dept_info
FROM current_emp as ce
INNER JOIN dept_emp as de
ON de.emp_no = ce.emp_no
INNER JOIN departments as d
ON de.dept_no = d.dept_no;


--  check the table 

SELECT *
FROM dept_info;



--  create a table for sales and development team

SELECT ce.emp_no,	
	   ce.first_name,
	   ce.last_name,
	   d.dept_name
INTO sales_dev
FROM current_emp as ce
INNER JOIN dept_emp as de
ON ce.emp_no = de.emp_no
INNER JOIN departments as d
ON de.dept_no = d.dept_no
WHERE d.dept_name IN ('Sales','Development');

--  check the table 

SELECT * 
FROM sales_dev;


--  create a table with the number of current employees eligible for retirement, grouped by job title

SELECT COUNT(e.emp_no), tl.title
INTO retirement_titles
FROM employees as e
INNER JOIN titles as tl
ON e.emp_no = tl.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
AND (tl.to_date = '9999-01-01')
GROUP BY tl.title;

-- check the table 

SELECT * 
FROM retirement_titles;


--  create a table with the number of current employees eligible for retirement, grouped by job title

SELECT e.emp_no, 
	   e.first_name, 
	   e.last_name,
	   tl.title,
	   tl.from_date,
	   s.salary
INTO retirement_titles
FROM employees as e
INNER JOIN titles as tl
ON e.emp_no = tl.emp_no
INNER JOIN salaries as s
ON e.emp_no = s.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
AND (tl.to_date = '9999-01-01');

-- check the table 

SELECT * 
FROM retirement_titles;


-- Partition the data to show only most recent title per employee

SELECT emp_no, 
	   first_name, 
	   last_name,
	   title,
	   from_date,
	   to_date,
	   salary
INTO retirement_titles_partitioned
FROM
 (SELECT emp_no, 
	     first_name, 
	     last_name,
	     title,
	     from_date,
         to_date,
	     salary, ROW_NUMBER() OVER
 (PARTITION BY (emp_no)
 ORDER BY to_date DESC) rn
 FROM retirement_titles
 ) tmp WHERE rn = 1
ORDER BY emp_no;

--  check the table 

SELECT * 
FROM retirement_titles_partitioned;


-- create a table from retirement_titles who are eligible for mentorship

SELECT e.emp_no, 
	   e.first_name, 
	   e.last_name,
	   tl.title,
	   tl.from_date,
	   tl.to_date
INTO mentorship_eligible
FROM employees as e
INNER JOIN titles as tl
ON e.emp_no = tl.emp_no
INNER JOIN salaries as s
ON e.emp_no = s.emp_no
WHERE e.birth_date BETWEEN '1965-01-01' AND '1965-12-31';

--  check the table

SELECT * 
FROM mentorship_eligible;


--  lose duplicates

SELECT emp_no, 
	   first_name, 
	   last_name,
	   title,
	   from_date,
	   to_date
INTO mentorship_eligible_clean
FROM
 (SELECT emp_no, 
	     first_name, 
	     last_name,
	     title,
	     from_date,
         to_date, ROW_NUMBER() OVER
 (PARTITION BY (emp_no)
 ORDER BY to_date DESC) rn
 FROM mentorship_eligible
 ) tmp WHERE rn = 1
ORDER BY emp_no;

--  check the table 

SELECT * 
FROM mentorship_eligible_clean