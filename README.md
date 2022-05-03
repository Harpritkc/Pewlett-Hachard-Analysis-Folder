# Pewlett-Hachard-Analysis-Folder

### Overview of the analysis
PH (Pewlett Hackard) is preparing itself for the future; they are looking to be proactive to fill any upcoming job vacancies. For this process they need to review their employee data and determine which employee would be retiring in the near future.
Currently all their data are in CSV files and now PH has decided to upgrade to SQL to make this process easier.
Using SQL we were able to create tables and import all the CSV files into a database by linking each table by their primary and foreign keys. The tables created were:

### Departments - details of each department number that is associated to each deparment name.
 1. Department Managers - employee number referenced for each manager with their associated department number, and their start to end date in that position.
2. Department Employees - employee number referenced for each employee with their associated department number, and their start to end date in that postion.
3. Employees - list of all employees that have or still work at PH; their employee number, full name, birth date, gender and hire date.
4. Salaries - employee number with associated salaries and their start to end date receiving that salary.
Titles - employee number with associated title and their start to end date holding the title.
5. Managers wanted to create a new mentoring program for employees getting ready to retire. This will allow any retirees to step back in a part-time role with in PH and become a mentor to guide the new hired employees by sharing their success and experiences. Before they can present their idea to the CEO, they require factual results to show the number of employees retiring from each department.

The following analysis results were created to determine the number of employees per title that will be retiring soon and if they are eligible to participate in the mentorship program.


### Results
By using the above data we extracted related information from each table. New tables with data were created by joining two or more existing tables; queried in SQL to filter the related columns.

retirement_titles.csv was created by extracting details by joining the Employees and Titles table to query employees' employee number, name, title name and start date at PH. We then filtered employees with the birth date between 1952 and 1955 to determine the retiring age. The data shows there are 133,776 employess that are retiring, which a vast number of employees retiring. However the employee data pulled show duplicates of some employees holding different positions throughout their career at PH and alot of employees who are no longer working at the company.

unique_titles.csv was created by removing any duplicate employee names and only keeping their most recent position held at PH. After removing duplicates, there are 90,398 employees which are active and non active employees.

retiring_titles.scv was created using the unique_titles data by grouping employees with the same titles and counting the total number of employees per title. This data still includes many employees no longer working at the company and therefore this table can be re filtered again to take only active employees in to account.
Based on this table it shows 2,9414 Senior Engineers are retiring which is quite high but only 2 department managers retiring. We would get a better picture once we revise this table to understand which departments each title represents.


mentorship_eligibility.csv was the final table that needs to be presented to the CEO. This table was derived from all 3 original datas; Employees, Department Employees and Titles table. Again, filtering the birth dates from 1952 to 1955 to determine the employees retiring but also by extracting the employees currently still active with PH. There are a total of 1549 employees that is eligble for the mentorship program.

All CSV files imported and exported are saved in Data
Schema to create 4 above tables can be accessed in Queries

Summary
Out of the 4 new data tables created, the mentorship_eligibility table provides more of the information required for the Managers to promote the idea. However this information can be clarified a bit further, if questions are asked by the CEO. When looking at the number of 1549 employees retiring soon, still seems like a big chunk of employees that are retiring. I've created a similar table called mentorship_eligibility1.csv but included the department for each employee. As per the image below, we can see that a Senior Engineer can be valid in different departments.


To calculate the total number of employees per department, I created another query for the table below. This gives a more microscopic view of job vacancies that will be upcoming for each department. The numbers per department looks a little less overwhelming. There are a total of 34 job titles within the 9 departments that have upcoming retirees; the Development department leading with 194 Engineer positions that will be available in the near future.
total_per_dept.


Knowing there are 1549 total employees that are retiring and same number of new employees that need to be hired, parameters can be set for the mentorship eligibility. Otherwise PH will have 3098 positions to fill; half the employees as replacements and the other half as part time mentorship. Which would mean 1:1 for every new hire and mentor, assuming all retirees do want to take part in the mentorship program. This would significantly increase payroll and other expenses within the company. One criteria can be based on the number of positions an employee held during their tenure at PH. This shows career growth, expertise and more experience within the retiree. Positions held can be 2 or more based a specific department and requirements to fullfill the mentorship program. Another criteria could be capping the number of mentorship positions per department.