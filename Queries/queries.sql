-- Determine retirement eligibility
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

-- Determine employees born in 1952
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';

-- Determine employees born in 1953
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31';

-- Determine employees born in 1954
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31';

-- Determine employees born in 1955
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1955-01-01' AND '1955-12-31';

-- Narrow the Search for Retirement Eligibility
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31') 
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Determine the number of employees retiring
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Save data into a new table "retirement info"
-- select first_name, last_name
-- into retirement_info
-- from employees
-- where (birth_date between '1952-01-01' and '1955-12-31')
-- and (hire_date between '1985-01-01' and '1988-12-31');
-- Check the table
-- select * from retirement_info;

-- Create a new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Check the table
SELECT * FROM retirement_info;

--JOIN IN ACTION
-- Joining departments and dept_manager tables
SELECT departments.dept_name,
     dept_manager.emp_no,
     dept_manager.from_date,
     dept_manager.to_date
FROM departments
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;

-- USE LEFT JOIN TO CAPTURE RETIREMENT-INFO TABLE
-- "retirement_info" and "dept_emp" tables
SELECT retirement_info.emp_no,
	retirement_info.first_name,
retirement_info.last_name,
	dept_emp.to_date
FROM retirement_info
LEFT JOIN dept_emp
ON retirement_info.emp_no = dept_emp.emp_no;

--USE ALIASES FOR CODE READABILITY
-- Each table name can be shortened to a nickname (e.g., retirement_info becomes "ri").
-- Let's start with updating the SELECT statement.
SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
	de.to_date
FROM retirement_info AS ri 
LEFT JOIN dept_emp AS de
ON ri.emp_no = de.emp_no;

-- NOTE: these aliases only exist within this query; they aren't committed to that database

-- Using the same alias method and syntax as before, rename departments to "d" and dept_manager to "dm."
--Starting with the SELECT statement, update the table names.
-- Joining departments and dept_manager tables
SELECT departments.dept_name,
     dept_manager.emp_no,
     dept_manager.from_date,
     dept_manager.to_date
FROM departments
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;

SELECT d.dept_name,
	dm.emp_no,
	dm.from_date,
	dm.to_date
FROM departments AS d
INNER JOIN dept_manager AS dm
ON d.dept_no = dm.dept_no;

-- USE LEFT JOIN FOR RETIREMENT_INFO AND DEPT_EMO TABLES
-- Join the "retirement_info" and "dept_emp" tables to make sure they're still employed
-- Create a new TABLE to old Information and name it "current_emp."
SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
de.to_date	
INTO current_emp
FROM retirement_info AS ri
LEFT JOIN dept_emp AS de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');
-- Check the table
SELECT * FROM current_emp;

-- Join the "departments" and "managers" tables
SELECT dpt.dept_name,
	mgr.emp_no,
	mgr.from_date,
	mgr.to_date
FROM departments AS dpt
INNER JOIN dept_manager AS mgr
ON dpt.dept_no = mgr.dept_no;

--USE COUNT, GROUP BY, AND ORDER BY
-- Determine the employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp AS ce
LEFT JOIN dept_emp AS de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

-- CREATE ADDITIONAL LISTS
--Because of the number of people leaving each department, the boss has requested three lists that are more
-----specific:
--Employee Information: A list of employees containing their unique employee number, their last na,
-----first name, gender, and salary
--Management: A list of managers for each department, including the department number, name, 
-----and the manager's employee number, last name, first name, and the starting and ending employment dates
--Department Retirees: An updated current_emp list that includes everything it currently has,
------but also the employee's departments
----Get started with the first list.

--LIST 1: EMPLOYEE INFORMATION
SELECT * FROM salaries
ORDER BY to_date DESC;

--Code to Filter the Employees Table to show only Retirment dates with GENDER
SELECT emp_no, first_name, last_name, gender
-- INTO emp_info
From employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1998-12-31');

-- Here, we are using a modified version of the "retirement_info" table to include salaries 
---- and renaming the table to emp_info
SELECT e.emp_no,  
	e.first_name, 
	e.last_name,
	e.gender,
	s.salary,
	de.to_date
-- INTO emp_info
FROM employees AS e
	INNER JOIN salaries AS s
		ON (e.emp_no = s.emp_no)
	INNER JOIN dept_emp AS de
		ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
	AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
	AND (de.to_date = '9999-01-01');

-- LIST 2: MANAGEMENT
-- List of managers per department
SELECT  dm.dept_no,
        d.dept_name,
        dm.emp_no,
        ce.last_name,
        ce.first_name,
        dm.from_date,
        dm.to_date
-- INTO manager_info
FROM dept_manager AS dm
    INNER JOIN departments AS d
        ON (dm.dept_no = d.dept_no)
    INNER JOIN current_emp AS ce
        ON (dm.emp_no = ce.emp_no);
		
-- LIST 3: DEPARTMENT RETIREES
SELECT ce.emp_no,
	ce.first_name,
	ce.last_name,
	d.dept_name
-- INTO dept_info
FROM current_emp as ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no);
        
--CREATE A TAILORED LIST
--1. What's going on with Salaries?
--2. Why are there only 5 Active Managers for 9 Departments?
--3. Why are some Employees appearing Twice?
--Skill Drill 7.3.6: Create a query that returns the info relevant to the Sales Team
-- Requested list includes: employee numbers, first name, last name, department name
SELECT ce.emp_no,
	ce.first_name,
	ce.last_name,
	de.dept_no,
	dpt.dept_name
FROM current_emp AS ce
	INNER JOIN dept_emp AS de
		ON (ce.emp_no = de.emp_no)
	INNER JOIN departments AS dpt
		ON (de.dept_no = dpt.dept_no)
WHERE dept_name = 'Sales';

-- Skill Drill 7.3.6: Create a query that returns the following info for the Sales & Development Teams
-- Requested list includes: employee numbers, first name, last, department name
SELECT ce.emp_no,
	ce.first_name,
	ce.last_name,
	de.dept_no,
	dpt.dept_name
FROM current_emp AS ce
	INNER JOIN dept_emp AS de
		ON (ce.emp_no = de.emp_no)
	INNER JOIN departments AS dpt
		ON (de.dept_no = dpt.dept_no)
WHERE dept_name in ('Sales', 'Development');
