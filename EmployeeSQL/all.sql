-- Create table schema

DROP TABLE departments;
select * from departments;

CREATE TABLE departments(
	dept_no varchar NOT null,
	dept_name varchar Not null,
	PRIMARY KEY (dept_no)
);

DROP TABLE dept_employee;
select * from dept_employee;

CREATE TABLE dept_employee(
	emp_no int not null,
	dept_no varchar not null,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

DROP TABLE employees;
select * from employees;

CREATE TABLE employees(
	emp_no int not null,
	emp_title_id varchar not null,
	birth_date date not null,
	first_name varchar not null,
	last_name varchar not null,
	sex varchar not null,
	hire_date date not null,
	PRIMARY KEY (emp_no)
);

DROP TABLE titles;
select * from titles;

CREATE TABLE titles(
	title_id varchar not null,
	title varchar not null
);

CREATE TABLE dept_manager(
	dept_no varchar not null,
	emp_no int not null,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);

CREATE TABLE salaries(
	emp_no int not null,
	salary int not null,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);

--List the following details of each employee: employee number, last name, first name, sex, and salary.
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees as e
INNER JOIN salaries as s
ON e.emp_no = s.emp_no;

--List first name, last name, and hire date for employees who were hired in 1986.
SELECT first_name, last_name, hire_date
FROM employees
WHERE date_part('year', hire_date)= 1986;

----NOT FINISHED-----
--List the manager of each department with the following information: 
--department number, department name, the manager's employee number, last name, first name.
SELECT departments.dept_no, departments.dept_name, employees.emp_no,employees.first_name, employees.last_name
FROM dept_manager
JOIN employees 
	on (dept_manager.emp_no = employees.emp_no )
		JOIN departments 
			on (dept_manager.dept_no = departments.dept_no);

--List the department of each employee with the following information: 
--employee number, last name, first name, and department name.
SELECT employees.emp_no,employees.first_name, employees.last_name, departments.dept_name
FROM dept_employee
JOIN employees 
	on (dept_employee.emp_no = employees.emp_no )
		JOIN departments 
			on (dept_employee.dept_no = departments.dept_no);
			
--List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%'

--List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT employees.emp_no,employees.first_name, employees.last_name, departments.dept_name
FROM dept_employee
JOIN employees 
	on (dept_employee.emp_no = employees.emp_no )
		JOIN departments 
			on (dept_employee.dept_no = departments.dept_no)
WHERE departments.dept_name IN ('Sales') ;

--List all employees in the Sales and Development departments, 
--including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.first_name, e.last_name, d.dept_name
FROM employees AS e
JOIN dept_employee AS de
ON (e.emp_no = de.emp_no)
JOIN departments AS d
ON (de.dept_no= d.dept_no)
WHERE d.dept_name IN ('Sales','Development');

--In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name, COUNT(*) AS Count
FROM employees
GROUP BY last_name
ORDER BY Count DESC;
