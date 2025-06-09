SELECT * FROM employee_salary;
SELECT * FROM employee_demographics;
SELECT * FROM parks_departments;


---CTEs for high salaries example

WITH High_Salary AS(
 SELECT employee_id,first_name,last_name, department_name,salary as [High Earning Salaries] FROM employee_salary e JOIN parks_departments p 
 ON e.dept_id=p.department_id
 WHERE salary>=60000

)

SELECT * FROM High_Salary
--`SELECT first_name FROM High_Salary


---TEMP tables for high salaries example

SELECT employee_id,first_name,last_name,department_name,salary
INTO High_Earners
FROM employee_salary e JOIN parks_departments p
ON e.dept_id=p.department_id


SELECT * FROM High_Earners;




-----2nd cte
WITH 
CertainDepart_Females AS (

  SELECT s.employee_id,s.first_name,s.last_name,department_name,gender,salary,AVG(Salary) OVER () AS [Average Salay(Females)] FROM (employee_salary s JOIN parks_departments d
  ON s.dept_id=d.department_id) full join employee_demographics em
  ON s.employee_id=em.employee_id
  WHERE d.department_id=1 AND gender='Female'
);
WITH CertainDepart_Males AS (
  SELECT s.employee_id,s.first_name,s.last_name,department_name,gender,salary,AVG(Salary) OVER () AS [Average Salay(Males)],(SELECT AVG(Salary) OVER () AS [Average Salay(Females)] FROM CertainDepart_Females ) FROM (employee_salary s JOIN parks_departments d
  ON s.dept_id=d.department_id) join employee_demographics em
  ON s.employee_id=em.employee_id
  WHERE d.department_id=1 AND gender='male'
)  
SELECT * FROM CertainDepart_Males;



USE Parks_and_Recreation

CREATE PROCEDURE Employees
AS
BEGIN

END;
