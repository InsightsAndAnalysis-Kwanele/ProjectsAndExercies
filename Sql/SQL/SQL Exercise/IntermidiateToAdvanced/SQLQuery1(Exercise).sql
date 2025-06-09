--Parks_and_Recreation database
SELECT * FROM employee_demographics 
SELECT * FROM employee_salary
SELECT * FROM parks_departments

SELECT s.employee_id,s.first_name,s.last_name,age,gender,occupation,salary,department_name FROM employee_demographics dm 
FULL OUTER JOIN employee_salary s
on dm.employee_id=s.employee_id
INNER JOIN parks_departments pd
on s.dept_id=pd.department_id

SELECT * FROM parks_departments
SELECT * FROM employee_salary es
INNER JOIN employee_salary s
ON es.employee_id=s.employee_id
INNER JOIN parks_departments pd
ON es.dept_id=pd.department_id

SELECT * FROM employee_salary es
INNER JOIN employee_salary s
ON es.dept_id=s.dept_id





