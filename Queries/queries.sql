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

-- Join the "retirement_info" and "dept_emp" tables
select retirement_info.emp_no,
	retirement_info.first_name,
	retirement_info.last_name,
	dept_emp.to_date
from retirement_info
left join dept_emp
on retirement_info.emp_no = dept_emp.emp_no;

-- Use aliases in the code above^ to make code cleaner
select ri.emp_no,
	ri.first_name,
	ri.last_name,
	de.to_date
from retirement_info as ri --this is where the alias 'ri' gets defined
left join dept_emp as de --this is where the alias 'de' gets defined
on ri.emp_no = de.emp_no;
-- NOTE: these aliases only exist within this query; they aren't committed to that database

-- Join the "departments" and "managers" tables
select dpt.dept_name,
	mgr.emp_no,
	mgr.from_date,
	mgr.to_date
from departments as dpt
inner join managers as mgr
on dpt.dept_no = mgr.dept_no;

-- Join the "retirement_info" and "dept_emp" tables to make sure they're still employed
select ri.emp_no,
	ri.first_name,
	ri.last_name,
	de.to_date
into current_emp
from retirement_info as ri
left join dept_emp as de
on ri.emp_no = de.emp_no
where de.to_date = ('9999-01-01');
-- Check the table
select * from current_emp;

-- Determine the employee count by department number
select count(ce.emp_no), de.dept_no
into emp_count_by_dept_no
from current_emp as ce
left join dept_emp as de
on ce.emp_no = de.emp_no
group by de.dept_no
order by de.dept_no;

-- Create the 1st List: Employee Information
-- Here, we are using a modified version of the "retirement_info" table to include salaries 
-- and renaming the table to "emp_info"
select e.emp_no, 
	e.first_name, 
	e.last_name,
	e.gender,
	s.salary,
	de.to_date
into emp_info
from employees as e
	inner join salaries as s
		on (e.emp_no = s.emp_no)
	inner join dept_emp as de
		on (e.emp_no = de.emp_no)
where (e.birth_date between '1952-01-01' and '1955-12-31')
	and (e.hire_date between '1985-01-01' and '1988-12-31')
	and (de.to_date = '9999-01-01');

-- Create the 2nd List: Management
select mgr.dept_no,
	dpt.dept_name,
	mgr.emp_no,
	ce.last_name,
	ce.first_name,
	mgr.from_date,
	mgr.to_date
into manager_info
from managers as mgr
	inner join departments as dpt
		on (mgr.dept_no = dpt.dept_no)
	inner join current_emp as ce
		on (mgr.emp_no = ce.emp_no);
		
-- Create the 3rd List: Department Retirees
select ce.emp_no,
	ce.first_name,
	ce.last_name,
	dpt.dept_name
into dept_info
from current_emp as ce
	inner join dept_emp as de
		on (ce.emp_no = de.emp_no)
	inner join departments as dpt
		on (de.dept_no = dpt.dept_no);
        
-- Skill Drill 7.3.6: Create a query that returns the info relevant to the Sales Team
-- Requested list includes: employee numbers, first name, last name, department name
select ce.emp_no,
	ce.first_name,
	ce.last_name,
	de.dept_no,
	dpt.dept_name
from current_emp as ce
	inner join dept_emp as de
		on (ce.emp_no = de.emp_no)
	inner join departments as dpt
		on (de.dept_no = dpt.dept_no)
where dept_name = 'Sales';

-- Skill Drill 7.3.6: Create a query that returns the following info for the Sales & Development Teams
-- Requested list includes: employee numbers, first name, last, department name
select ce.emp_no,
	ce.first_name,
	ce.last_name,
	de.dept_no,
	dpt.dept_name
from current_emp as ce
	inner join dept_emp as de
		on (ce.emp_no = de.emp_no)
	inner join departments as dpt
		on (de.dept_no = dpt.dept_no)
where dept_name in ('Sales', 'Development');      