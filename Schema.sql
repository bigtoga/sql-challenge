-- D:\Google Drive\Scott\SMU Data Science\02-Homework\09-SQL\EmployeeSQL\data
DROP TABLE IF EXISTS 
	salaries
	, titles
	, dept_manager
	, employees
	, dept_emp
	, departments;
	
CREATE TABLE departments (
	dept_no VARCHAR(10) NOT NULL PRIMARY KEY
	, dept_name VARCHAR(128) NOT NULL
);
	
-- emp_no	birth_date	first_name	last_name	gender	hire_date
CREATE TABLE employees (
	emp_no INT NOT NULL PRIMARY KEY
	, birth_date TIMESTAMP NOT NULL
	, first_name VARCHAR(128) NOT NULL
	, last_name VARCHAR(128) NOT NULL
	, gender CHAR(1) NOT NULL CONSTRAINT m_or_f_only CHECK(gender in ('M', 'F'))
	, hire_date TIMESTAMP NOT NULL
);
	
-- emp_no	dept_no	from_date	to_date
CREATE TABLE dept_emp (
	id SERIAL PRIMARY KEY
	, emp_no INT NOT NULL REFERENCES employees(emp_no)
	, dept_no VARCHAR(10) NOT NULL REFERENCES departments(dept_no) 
	, from_date TIMESTAMP NOT NULL
	, to_date TIMESTAMP NULL
	, dept_name VARCHAR(128)
);
	
-- emp_no	title	from_date	to_date
CREATE TABLE titles (
	id SERIAL PRIMARY KEY
	, emp_no INT NOT NULL REFERENCES employees(emp_no)
	, title VARCHAR(128)
	, from_date TIMESTAMP NOT NULL
	, to_date TIMESTAMP NULL
);
	
-- emp_no	salary	from_date	to_date	
CREATE TABLE salaries (
	id SERIAL PRIMARY KEY
	, emp_no INT NOT NULL REFERENCES employees(emp_no)
	, salary INT NOT NULL 
	, from_date TIMESTAMP NOT NULL 
	, to_date TIMESTAMP NULL 
);
	
CREATE TABLE dept_manager (
	id SERIAL PRIMARY KEY
	, emp_no INT NOT NULL REFERENCES employees(emp_no)
	, dept_no VARCHAR(10)NOT NULL REFERENCES departments(dept_no) 
	, from_date TIMESTAMP NOT NULL
	, to_date TIMESTAMP NULL
);

/*******************
Load the data
*******************/
COPY departments(dept_no, dept_name)
FROM 'D:\Google Drive\Scott\SMU Data Science\02-Homework\09-SQL\EmployeeSQL\data\departments.csv' DELIMITER ',' CSV HEADER;

COPY employees(emp_no, birth_date, first_name, last_name, gender, hire_date)
FROM 'D:\Google Drive\Scott\SMU Data Science\02-Homework\09-SQL\EmployeeSQL\data\employees.csv' DELIMITER ',' CSV HEADER;

COPY dept_emp(emp_no, dept_no, from_date, to_date)
FROM 'D:\Google Drive\Scott\SMU Data Science\02-Homework\09-SQL\EmployeeSQL\data\dept_emp.csv' DELIMITER ',' CSV HEADER;

COPY salaries(emp_no, salary, from_date, to_date)
FROM 'D:\Google Drive\Scott\SMU Data Science\02-Homework\09-SQL\EmployeeSQL\data\salaries.csv' DELIMITER ',' CSV HEADER;

COPY titles(emp_no, title, from_date, to_date)
FROM 'D:\Google Drive\Scott\SMU Data Science\02-Homework\09-SQL\EmployeeSQL\data\titles.csv' DELIMITER ',' CSV HEADER;

COPY dept_manager(dept_no, emp_no, from_date, to_date)
FROM 'D:\Google Drive\Scott\SMU Data Science\02-Homework\09-SQL\EmployeeSQL\data\dept_manager.csv' DELIMITER ',' CSV HEADER;
