SELECT * FROM Departments;
SELECT * FROM Employees;
SELECT * FROM Projects;
SELECT * FROM Salaries;


-------Question 1
WITH TotSal AS (
SELECT e.DepartmentID as DepartmentID, SUM(Salary) AS [Total Salary Per Department] 
FROM Employees e JOIN Departments d
ON e.DepartmentID=d.DepartmentID
GROUP BY e.DepartmentID
)

SELECT t.DepartmentID,DepartmentName, [Total Salary Per Department] 
FROM TotSal t JOIN Departments d 
ON t.DepartmentID=d.DepartmentID


SELECT DepartmentName, SUM(Salary) AS [Total Salary Per Department] 
FROM Employees e JOIN Departments d
ON e.DepartmentID=d.DepartmentID
GROUP BY DepartmentName
ORDER BY SUM(Salary);


---------QUESTION2 
WITH HighPay as (
SELECT EmployeeID,Name,DepartmentName,e.DepartmentID,Salary,Rank() OVER(Partition BY e.DepartmentID ORDER BY Salary DESC) RankSalary
FROM Employees e JOIN Departments d
ON e.DepartmentID=d.DepartmentID)

SELECT EmployeeID,Name,DepartmentName,Salary as [Maximum Salary Per Department] FROM HighPay where RankSalary=1

--------QUESTION 3
WITH AvgSalaries as (
SELECT DepartmentID,AVG(Salary) [Avarage Salary Per Department] 
FROM Employees 
GROUP BY DepartmentID)

SELECT a.DepartmentID,DepartmentName,[Avarage Salary Per Department]  
FROM AvgSalaries a JOIN Departments d
ON a.DepartmentID=d.DepartmentID

----------Question 4

SELECT e.EmployeeID,Name,DepartmentID,ProjectID,Salary,HireDate,StartDate As [Project Start Date],EndDate AS [Project End Date]
FROM  Employees e JOIN Projects p
ON e.EmployeeID=p.EmployeeID WHERE HireDate<StartDate

---Questin 5
SELECT p.EmployeeID,Name,ProjectID,Salary ,COUNT(ProjectID) OVER( PARTITION BY p.EmployeeID)  AS [Total Number Of Projects]
FROM  Employees e JOIN Projects p
ON e.EmployeeID=p.EmployeeID ;

---QUESTION 6
WITH 
 High2ndSalary AS(
SELECT EmployeeID,Name,DepartmentID,Salary,DENSE_RANK() OVER(PARTITION BY DepartmentID ORDER BY Salary DESC ) AS [Rank Of Salary In Each Department]
FROM Employees)
 
 

SELECT EmployeeID,Name,DepartmentName,Salary,[Rank Of Salary In Each Department]
FROM High2ndSalary h JOIN Departments d
ON h.DepartmentID=d.DepartmentID
WHERE [Rank Of Salary In Each Department]=2;


---------QUESTION2 
WITH HighPay as (
SELECT EmployeeID,Name,DepartmentName,e.DepartmentID,Salary,Rank() OVER(Partition BY e.DepartmentID ORDER BY Salary DESC) RankSalary
FROM Employees e JOIN Departments d
ON e.DepartmentID=d.DepartmentID)

SELECT EmployeeID,Name,DepartmentName,Salary as [Maximum Salary Per Department] FROM HighPay where RankSalary=1


--------------------Q7
WITH RankedSalaries AS (
    SELECT EmployeeID, DepartmentID, Salary,
           DENSE_RANK() OVER (PARTITION BY DepartmentID ORDER BY Salary DESC) AS SalaryRank
    FROM Employees
)

SELECT e1.DepartmentID, 
       e1.Salary - e2.Salary AS SalaryDifference
FROM RankedSalaries e1
JOIN RankedSalaries e2
    ON e1.DepartmentID = e2.DepartmentID
WHERE e1.SalaryRank = 1 AND e2.SalaryRank = 2;


------------------------Q8
WITH 
 MostProjects AS(
    SELECT p.EmployeeID,Name,Salary,COUNT(ProjectName) AS NumOfProjects 
	FROM Employees e JOIN Projects p
	ON e.EmployeeID=p.EmployeeID
	GROUP BY p.EmployeeID,Name,Salary),
 PrjRank as (
	SELECT *,Rank() OVER(ORDER BY NumOfProjects DESC) AS Rank_Num_Of_Projects FROM MostProjects)

SELECT * FROM PrjRank WHERE Rank_Num_Of_Projects=1


--------QUESTIO 9
SELECT * FROM Employees;
SELECT * FROM Projects;

WITH 
 ProjectDuration as(
	SELECT ProjectID,p.EmployeeID,Name,Salary,StartDate,EndDate,DATEDIFF(day,StartDate,EndDate) AS [Days on Project]
	FROM Projects p JOIN Employees e
	ON p.EmployeeID=e.EmployeeID),
 LongRunProject as(
	SELECT * ,DENSE_RANK() OVER (ORDER BY [Days on Project] DESC) AS [Rank of Running Projects]
	FROM ProjectDuration)

SELECT * FROM LongRunProject


---------QUESTION 10
SELECT * FROM Departments;
SELECT * FROM Employees;

WITH 
AvgSalry As (
	SELECT EmployeeID,Name,DepartmentName,Salary,AVG(Salary) OVER (PARTITION BY e.DepartmentID) AS [Average Salary Per Department]
	FROM Employees e JOIN Departments d
	ON e.DepartmentID=d.DepartmentID
	),
 EmplSateSalry AS(
	SELECT *,
	CASE
		WHEN Salary > [Average Salary Per Department] THEN 'above'
		WHEN Salary < [Average Salary Per Department] THEN 'below'
		ELSE 'equal'
	
	END AS [Salary Compared To Avg Salary]
	FROM AvgSalry
	
	)

SELECT * FROM EmplSateSalry


