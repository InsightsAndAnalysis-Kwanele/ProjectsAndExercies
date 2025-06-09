--Unions
--Parks and Rec database
SELECT * FROM employee_demographics 
SELECT * FROM employee_salary
SELECT * FROM parks_departments


SELECT first_name,last_name,'Overage' AS [Label] FROM employee_demographics 
WHERE age>40
UNION 
SELECT first_name,last_name,'OverPaid' FROM employee_salary
WHERE salary>70000

SELECT first_name,UPPER(last_name) AS [Last Name],
CASE
 WHEN age<24 THEN 'Entry Employee'
 WHEN age>35 THEN 'Senior Employee'
 WHEN 24< age THEN 'Junior Employee'
 ELSE 'Senoior Employee'
END AS [Employee Category]
FROM employee_demographics



