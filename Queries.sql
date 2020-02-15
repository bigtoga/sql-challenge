-- List the following details of each employee: employee number, last name, first name, gender, and salary.
SELECT e.emp_no, e.first_name, e.last_name, e.gender, s.salary, s.from_date, s.to_date
FROM employees e
JOIN salaries s
	ON e.emp_no = s.emp_no
ORDER BY e.first_name, e.last_name, s.from_date;

-- List employees who were hired in 1986.
SELECT * 
FROM employees 
WHERE hire_date > '1985-12-31 23:59:59'
	AND hire_date < '1987-01-01 00:00:00'
ORDER BY hire_date, first_name, last_name;

-- List the manager of each department with the following information: 
-- department number, department name, the manager's employee number, 
-- last name, first name, and start and end employment dates.
/****************************************************************
	Confused on this one - an active manager has no "end employment dates"
	
	@Thinh Nguyen - TA - in homework, it says "List the manager of each department with the following information: 
		department number, department name, the manager's employee number, last name, first name, and start and end 
		employment dates.". Confused... The "manager of each dept" implies we only return the current manager. 
		The "current manager" as no "end employment date" as of yet. Are we just supposed to return "every row 
		in the dept_manager table, and the matching employee info instead?"
	
	"Its just the latter.""
****************************************************************/	
SELECT d.dept_no, d.dept_name
	, e.*
FROM departments d
JOIN dept_emp de
	ON d.dept_no = de.dept_no
JOIN dept_manager m
	ON d.dept_no = m.dept_no
JOIN employees e
	ON e.emp_no = m.emp_no
	AND d.dept_no = m.dept_no
ORDER BY e.emp_no, d.dept_name;

-- List the department of each employee with the following information: 
--	employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e
JOIN dept_emp de 
	ON e.emp_no = de.emp_no
JOIN departments d
	ON d.dept_no = de.dept_no
ORDER BY e.emp_no, d.dept_name;

-- List all employees whose first name is "Hercules" and last names begin with "B."
SELECT * 
FROM employees
WHERE first_name = 'Hercules'
	AND last_name LIKE 'B%'
ORDER BY emp_no;

-- List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.first_name, e.last_name, d.dept_name
FROM departments d
JOIN dept_emp de
	ON de.dept_no = d.dept_no
JOIN employees e
	ON e.emp_no = de.emp_no
WHERE d.dept_name = 'Sales'
ORDER BY e.emp_no;

-- List all employees in the Sales and Development departments, including their employee number, last name, 
-- 	first name, and department name
SELECT e.emp_no, e.first_name, e.last_name, d.dept_name
FROM departments d
JOIN dept_emp de
	ON de.dept_no = d.dept_no
JOIN employees e
	ON e.emp_no = de.emp_no
WHERE d.dept_name IN('Development', 'Sales')
ORDER BY e.emp_no;

-- In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name, COUNT(*) AS "Employees w this last name"
FROM employees
GROUP BY last_name
ORDER BY COUNT(*) DESC, last_name;