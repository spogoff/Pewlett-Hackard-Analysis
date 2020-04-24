# Pewlett-Hackard-Analysis

## The Problem

As the "silver tsunami" approaches Pwelett Hackard, a large number of loyal employees are going to retire from the company, This will create a large number of roles, including some management roles, vacant. The company needs to get reports on how many retirements will occur in the coming year and what roles in order to be prepared for new hires and pontential trainings. 

## Solutions and Challenges

In order to tackle this challenge, multiple tables of current employees names and roles were created. This allows Pwelett Hackard to not only identify the vacant roles, but also capitalize on alarge number of seasoned employees for training those who are filling the positions. 

The database initially included the following tables:

- employees
- departments
- dept_managers
- dept_emp
- salaries
- titles

Using the dataframe above, the following steps were taken to create a summary and a series of suggestions for Pwelett Hackard. Please note that all SQL queries used as well as the final CSV files are attached, while not included here:


1) Retirement eligibility was defined as employees who were born between January 1952 and December 1955 AND had started working at PH between January 1985 and December 1988.

2) The "retirement_info" table was created to provide a list of employees eligible for retirement with employee numbers and first and last names (attached).

3) The "current_emp" table was created to provide a list of current employees eligible for retirement with employee numbers, first and last names and to_date column (attached).

4) A new table was created by joining current_emp and dept_emp tables to get the count of current employees in each department (results below).

5) The "emp_info" table was created to get a list of all current employees eligible for retirement with their genders (results below).

6) The "manager_info" table was created to get a list of all managers eligible for retirement across departments. 

7) The "retirement_titles_partitioned" table was created to get a list of all employees eligible for retirement in different departments (results below,CSV attached). 

8) The "mentorship_eligibile_clean" table was created to get a list of all employees eligible for retirement who are also eligible for mentorship (results below,CSV attached). 

9) Please note that both tables above were checked and cleaned from duplicates.


## The Results

### Total number of current employees: 

Customer Service: 2597
Research: 2413
Sales: 5860
Quality Management: 2234
Development: 9281
Production: 8174
Human Resources: 1953
Finance: 1908
Marketing: 2199
Total : 41380

### Total number of employees eligible for retirement by department:

Engineer: 4692
Senior Engineer: 15600
Manager: 2
Assistant Engineer: 501
Staff: 3837
Senior Staff: 14735
Technique Leader: 2013
Total: 41380

### Total number of employees eligible for retirement by gender:

Male: 24738
Female: 16642

### Total number of employees eligible for mentorship:

Engineer: 286
Senior Engineer: 610
Manager: 0
Assistant Engineer: 41
Staff: 271
Senior Staff: 633
Technique Leader: 99
Total: 1940

## Suggestions

Pwelett Hackard is going to be affected pretty significantly with its upcoming wave of retirement. The two areas that are going to take the largest hit are Senior Staff and Senior Engineer deparments(14735 and 15600 respectively). Although the company has quite a few employees who are eligible for mentorship in those departments(633 and 610 respectively), there is still a lot of room for fresh hires. It is also recommended that the company invests in mentorship programs to have more mentors ready to train the next generation of senior staff and engineers. 

Although there are only 2 managers retiring this year, since there are no employees eligible for training for those strategic positions, it is recommended that the company either invests in outsourcing training its current employees eligible for those roles.



