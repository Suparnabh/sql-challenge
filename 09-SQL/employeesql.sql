CREATE TABLE departments
(
dept_no VARCHAR NOT NULL PRIMARY KEY,
dept_name VARCHAR
);


CREATE TABLE dept_emp
(
emp_no INT,
dept_no VARCHAR,
from_date DATE,
to_date DATE,
FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);

CREATE TABLE dept_manager
(
dept_no VARCHAR,
emp_no INT,
from_date DATE,
to_date DATE,
FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);

CREATE TABLE employees
(
emp_no INT NOT NULL PRIMARY KEY,
birth_date DATE,
first_name VARCHAR,
last_name VARCHAR,
gender VARCHAR,
hire_date DATE
);


CREATE TABLE salaries
(
emp_no INT,
salary INT,
from_date DATE,
to_date DATE,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no)	
);

CREATE TABLE titles
(
emp_no INT,
title VARCHAR,
from_date DATE,
to_date DATE,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);

SELECT * FROM titles;

--List for each employee: employee number, last name, first name, gender, and salary.

SELECT e.emp_no, e.first_name, e.last_name, e.gender, s.salary
FROM employees e
JOIN salaries s
ON e.emp_no = s.emp_no;

--List employees who were hired in 1986.

SELECT * FROM employees 
WHERE hire_date BETWEEN '1/1/1986' AND '12/31/1986'
ORDER BY hire_date;

--List the manager of each department with the following information: 
--department number, department name, the manager's employee number, last name, first name, and start and end employment dates.

SELECT dm.dept_no, d.dept_name, dm.emp_no, e.first_name, e.last_name, dm.from_date, dm.to_date
FROM dept_manager dm
JOIN departments d
ON dm.dept_no = d.dept_no
JOIN employees e
ON dm.emp_no = e.emp_no
ORDER BY dept_name, from_date;

--Department of each employee with the following information: employee number, last name, first name, and department name.

SELECT e.emp_no, e.first_name, e.last_name, d.dept_name
FROM employees e
JOIN dept_emp de
ON e.emp_no = de.emp_no
JOIN departments d
ON de.dept_no = d.dept_no
ORDER BY dept_name;

--All Employees whose first name is "Hercules" and last names begin with "B."
 
SELECT *
FROM employees e
WHERE first_name ='Hercules' AND last_name LIKE 'B%';
 
--All Employees in the Sales department, including their employee number, last name, first name, and department name.

SELECT e.emp_no, e.first_name, e.last_name, d.dept_name
FROM employees e
JOIN dept_emp de
ON e.emp_no = de.emp_no
JOIN departments d
ON de.dept_no = d.dept_no
WHERE dept_name = 'Sales';

--All Employees in the Sales and Development departments, including their employee number, last name, first name, and department name.

SELECT e.emp_no, e.first_name, e.last_name, d.dept_name
FROM employees e
JOIN dept_emp de
ON e.emp_no = de.emp_no
JOIN departments d
ON de.dept_no = d.dept_no
WHERE dept_name = 'Sales' OR dept_name = 'Development';

--List the frequency count of employee last names, i.e., how many employees share each last name.

SELECT last_name,COUNT(emp_no) AS Frequency_count 
FROM employees
GROUP BY last_name
ORDER BY frequency_count DESC;
