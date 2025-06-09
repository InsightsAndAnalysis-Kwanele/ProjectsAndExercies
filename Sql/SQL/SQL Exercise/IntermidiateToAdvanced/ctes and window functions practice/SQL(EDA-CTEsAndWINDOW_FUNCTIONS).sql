SELECT * FROM DEPARTMENT
SELECT * FROM Employee
SELECT * FROM EmployeeProject
SELECT * FROM Project

------------------------
--1.CATEGORIZING SALARIES FROM LOW TO HIGH SALARIES
SELECT 
EmployeeID,FirstName,LastName,DepartmentID,Salary,
CASE 
	WHEN Salary>75000 then 'HIGH'
	WHEN Salary BETWEEN 65000 and 75000 then 'Medium'
	ELSE 'low'
END AS [SalaryCategory]
FROM Employee

---------------------
--2.getting employees who earn above average
SELECT AVG(Salary) FROM Employee

SELECT * FROM Employee WHERE Salary>(SELECT AVG(Salary) FROM Employee)

------------------------
--3.Dispalying salaries next to total average of salaries for comparison purposes
SELECT EmployeeID,FirstName,LastName,DepartmentID,Salary,AVG(Salary) OVER () AS [AvgSalary] FROM Employee

---------------------
--4.Ranking employees according to salary in each department
SELECT EmployeeID,FirstName,LastName,DepartmentID,Salary,ROW_NUMBER() OVER (PARTITION BY DepartmentID ORDER BY Salary DESC) AS [Salary_Rank_In_Department] FROM EMployee



---------------------------
--5.Ranking employees according to salary in each department using rank and dense rank
SELECT EmployeeID,FirstName,LastName,DepartmentID,Salary,RANK() OVER (Partition BY DepartmentID ORDER BY SALARY DESC) AS [Salary (Rank)],DENSE_RANK() OVER (Partition BY DepartmentID ORDER BY SALARY DESC) AS [Salary (Dense Rank)] FROM Employee



-------
--6.Displaying the next and previous salary relative to an employee
SELECT EmployeeID,FirstName,LastName,DepartmentID,Salary,LAG(Salary) OVER (ORDER BY Salary DESC) AS PreviousSalary,Lead(Salary) OVER (ORDER BY Salary DESC) AS ProceedingSalary FROM Employee;



----------------------
--7.GETTING EMPLOYEES WHO EARN ABOVE THEIR DEPARTMENTS AVERAGE SALARY USING A CTE
WITH AvgDepartment as (
SELECT DepartmentName,e.DepartmentID ,AVG(Salary) AS AvgPerDepartment 
FROM Employee e join Department d
ON e.DepartmentID=d.DepartmentID
GROUP BY DepartmentName,e.DepartmentID
),EmployeeDepartmentAvgSalary AS (
SELECT EmployeeID,FirstName,LastName,DepartmentName,Salary,AvgPerDepartment 
FROM Employee e JOIN AvgDepartment ad
ON e.DepartmentID=ad.DepartmentID )

SELECT *
INTO #TempAvgSalary----8.Creating a temp table
FROM EmployeeDepartmentAvgSalary
SELECT * FROM #TempAvgSalary Where Salary>AvgPerDepartment;

GO
----------------
--9.Creating a precedure that returns high earners within a specific departmentID

CREATE PROCEDURE HighEarnersPerDepartment @DepartmentID int
AS 
begin
WITH AvgDepartment as (
	SELECT DepartmentName,e.DepartmentID ,AVG(Salary) AS AvgPerDepartment 
	FROM Employee e join Department d
	ON e.DepartmentID=d.DepartmentID
	GROUP BY DepartmentName,e.DepartmentID)

SELECT EmployeeID,FirstName,LastName,DepartmentName,Salary,AvgPerDepartment 
FROM Employee e JOIN AvgDepartment ad
ON e.DepartmentID=ad.DepartmentID
WHERE  Salary>AvgPerDepartment AND e.DepartmentID=@DepartmentID;
END
GO

EXEC HighEarnersPerDepartment @DepartmentID=2

