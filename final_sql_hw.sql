--Create table for data_departments
CREATE TABLE departments (
	dept_no VARCHAR NOT NULL PRIMARY KEY,
	dept_name VARCHAR NOT NULL
);

--SELECT all to make sure it's formatted correctly
SELECT * FROM departments; 

--Create table for data_dept_emp
CREATE TABLE dept_emp (
	emp_no INTEGER NOT NULL,
	dept_no VARCHAR NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);


--SELECT all to make sure it's formatted correctly
SELECT * FROM dept_manager; 

--Create table for data_dept_manager
CREATE TABLE dept_manager (
	dept_no VARCHAR NOT NULL,
	emp_no INT NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

--SELECT all to make sure it's formatted correctly
SELECT * FROM dept_manager; 


--Create table for data_employees
CREATE TABLE employees (
	emp_no INT NOT NULL PRIMARY KEY,
	emp_title_id VARCHAR NOT NULL,
	birth_date DATE NOT NULL,
	first_name VARCHAR NOT NULL,
	last_name VARCHAR NOT NULL,
	sex VARCHAR NOT NULL,
	hire_date DATE NOT NULL
);

--Create table for data_salaries
CREATE TABLE salaries (
	emp_no INT NOT NULL, 
	salary INT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);
SELECT * FROM salaries; 
--Create table for data_titles

CREATE TABLE titles (
	title_id VARCHAR NOT NULL,
	title VARCHAR NOT NULL
);

SELECT * FROM titles; 
--1. List the following details of each employee: employee no, last name, first name, sex, and salary
--need to join employees and salary

SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees AS e
INNER JOIN salaries AS s 
ON e.emp_no =s.emp_no;

--2. List first name, last name, and hire date for employees who were hired in 1986.

SELECT first_name, last_name, hire_date 
FROM employees
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31'
ORDER BY hire_date;

--3. List the manager of each department with the following information: 
--department number, department name, the manager's employee number, last name, first name.

SELECT manager.dept_no, d.dept_name, manager.emp_no, e.last_name, e.first_name
FROM dept_manager AS manager
INNER JOIN departments AS d
ON d.dept_no = manager.dept_no
INNER JOIN employees as e
ON e.emp_no = manager.emp_no;

--4. List the department of each employee with the following information:
--employee number, last name, first name, and department name.

SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees AS e
INNER JOIN dept_emp
ON e.emp_no = dept_emp.emp_no
INNER JOIN departments as d
ON d.dept_no = dept_emp.dept_no;


--5. List first name, last name, and sex for employees whose first name 
--is "Hercules" and last names begin with "B." --there's 20 ppl named Hercules....?

SELECT first_name, last_name, sex 
FROM employees
WHERE first_name LIKE 'Hercules' AND last_name LIKE 'B%';


--6. List all employees in the Sales department, including their 
--employee number, last name, first name, and department name.

SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees AS e
INNER JOIN dept_emp
ON e.emp_no = dept_emp.emp_no
INNER JOIN departments as d
ON d.dept_no = dept_emp.dept_no
WHERE dept_name LIKE 'Sales';


--7.List all employees in the Sales and Development departments, 
--including their employee number, last name, first name, and department name.

SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees AS e
INNER JOIN dept_emp
ON e.emp_no = dept_emp.emp_no
INNER JOIN departments as d
ON d.dept_no = dept_emp.dept_no
WHERE dept_name LIKE 'Sales' OR dept_name LIKE 'Development' ;

--8. In descending order, list the frequency count
--of employee last names, i.e., how many employees share each last name.

SELECT last_name AS "Last_Name",
COUNT(last_name) AS "Freq_of_Employee_Last_Name"
FROM employees
GROUP BY last_name
ORDER BY
COUNT(last_name) DESC;