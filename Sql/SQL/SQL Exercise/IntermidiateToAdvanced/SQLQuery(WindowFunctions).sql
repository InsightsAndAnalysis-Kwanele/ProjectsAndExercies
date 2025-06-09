--CompanyDB
SELECT * FROM Employees
SELECT * FROM Departments

--Q1--
SELECT EmployeeID,Name,DepartmentName,Salary,Salary) OVER(PARTITION BY DepartmentName ORDER BY Salary DESC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)),2)  AS average
FROM Employees e JOIN Departments d
ON e.DepartmentID=d.DepartmentID

--Q1--
SELECT EmployeeID,Name,DepartmentName,Salary,SUM(Salary) OVER(PARTITION BY DepartmentName ORDER BY Salary DESC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
FROM Employees e JOIN Departments d
ON e.DepartmentID=d.DepartmentID

--Q2
SELECT EmployeeID,Name,DepartmentName,Salary,HireDate,COUNT(DepartmentName) OVER(PARTITION BY DepartmentName)
FROM Employees e JOIN Departments d
ON e.DepartmentID=d.DepartmentID

--q3
SELECT EmployeeID,Name,DepartmentName,Salary,AVG(Salary) OVER(PARTITION BY DepartmentName )  AS [Average Salary Per Department],(Salary-AVG(Salary) OVER(PARTITION BY DepartmentName )) AS SalaryDiff ,
CASE
  WHEN (Salary-AVG(Salary) OVER(PARTITION BY DepartmentName ))<0 THEN 'Underpaid'
  ELSE 'Proper wage'
END AS [Salary group]

FROM Employees e JOIN Departments d
ON e.DepartmentID=d.DepartmentID
ORDER BY (Salary-AVG(Salary) OVER(PARTITION BY DepartmentName ))


--Q4
SELECT DepartmentName,AVG(Salary) AS [AvgSalary]
FROM Employees e JOIN Departments d
ON e.DepartmentID=d.DepartmentID
GROUP BY DepartmentName
ORDER BY AVG(Salary)

SELECT AVG(Salary)  FROM Employees e JOIN Departments d
                                          ON e.DepartmentID=d.DepartmentID
                                           WHERE DepartmentName='HR'


----
SELECT EmployeeID,Name,DepartmentName,Salary,AVG(Salary) OVER(PARTITION BY DepartmentName )  AS [Average Salary Per Department],
CASE 
 WHEN DepartmentName='HR' AND SALARY > (SELECT AVG(Salary)  FROM Employees e JOIN Departments d ON e.DepartmentID=d.DepartmentID WHERE DepartmentName='HR') THEN 'Above'
 WHEN DepartmentName='IT' AND SALARY > (SELECT AVG(Salary)  FROM Employees e JOIN Departments d ON e.DepartmentID=d.DepartmentID WHERE DepartmentName='IT') THEN 'Above'
 WHEN DepartmentName='Finance' AND SALARY > (SELECT AVG(Salary)  FROM Employees e JOIN Departments d ON e.DepartmentID=d.DepartmentID WHERE DepartmentName='Finance') THEN 'Above'
 WHEN DepartmentName='Marketing' AND SALARY > (SELECT AVG(Salary)  FROM Employees e JOIN Departments d ON e.DepartmentID=d.DepartmentID WHERE DepartmentName='Marketing') THEN 'Above'
 
 
 ELSE 'x'
END AS [Salary Category(bove and below Median Salary)]
FROM Employees e JOIN Departments d
ON e.DepartmentID=d.DepartmentID