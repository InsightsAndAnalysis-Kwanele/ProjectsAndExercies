--Adventure works database
SELECT * FROM Sales.SalesOrderHeader
SELECT * FROM Sales.Customer
SELECT * FROM Person.Person
SELECT * FROM Sales.SalesTerritory
SELECT * FROM Sales.SalesPerson
SELECT * FROM Person.BusinessEntity
SELECT * FROM Sales.SalesTerritory
SELECT * FROM Sales.Customer
SELECT * FROM Sales.Store;


WITH SalesData AS (
    SELECT 
        sp.BusinessEntityID,
        p.FirstName + ' ' + p.LastName AS Salesperson,
        YEAR(soh.OrderDate) AS SalesYear,
        MONTH(soh.OrderDate) AS SalesMonth,
        soh.TotalDue
    FROM Sales.SalesOrderHeader soh
    JOIN Sales.SalesPerson sp ON soh.SalesPersonID = sp.BusinessEntityID
    JOIN Person.Person p ON sp.BusinessEntityID = p.BusinessEntityID
),
MonthlyKPI AS (
    SELECT 
        SalesYear,
        SalesMonth,
        Salesperson,
        SUM(TotalDue) AS TotalSales,
        COUNT(*) AS TotalOrders,
        ROUND(AVG(TotalDue), 2) AS AvgOrderValue
    FROM SalesData
    GROUP BY SalesYear, SalesMonth, Salesperson
)
SELECT * 
FROM MonthlyKPI
ORDER BY SalesYear, SalesMonth, Salesperson;




with monSales as (
SELECT  
	SalesPersonID,
	pp.FirstName,
	pp.LastName,
	Round(SUM(sh.TotalDue),2) AS [TotalSalesMade(2013)],
	COUNT(sh.SalesPersonID) as [NumOfSalesMade],
	AVG(sh.TotalDue) as [AvgOrderVal]

FROM Sales.SalesOrderHeader sh
INNER JOIN  Sales.SalesPerson sp
ON sh.SalesPersonID=sp.BusinessEntityID
INNER JOIN Person.Person pp
ON sh.SalesPersonID=pp.BusinessEntityID
WHERE YEAR(OrderDate)=2013--Getting the total sales made over the year 2013
GROUP BY SalesPersonID,pp.FirstName,pp.LastName
)
SELECT * FROM monSales ORDER BY [TotalSalesMade(2013)] DESC


--my code
SELECT TOP 10 c.CustomerID,p.FirstName,p.LastName,Round(SUM(s.TotalDue),2) AS [TotalSalesAmount],Round(COUNT(s.CustomerID),2) AS [TotalNumberOfSales]  --Getting the sum amount of sales each customer made from the sales table
FROM Sales.Customer c 
INNER JOIN Person.Person p
ON c.PersonID=p.BusinessEntityID
INNER JOIN Sales.SalesOrderHeader s
ON c.CustomerID=s.CustomerID
GROUP BY c.CustomerID,p.FirstName,p.LastName
ORDER BY SUM(s.TotalDue) DESC

--my code
SELECT st.Name,st.CountryRegionCode,st.[Group],Round(SUM(TotalDue),3) as [TotSalesPerRegion]
FROM Sales.SalesOrderHeader sh
INNER JOIN Sales.SalesTerritory st
on sh.TerritoryID=st.TerritoryID
GROUP BY st.Name,st.CountryRegionCode,st.[Group]
ORDER BY Round(SUM(TotalDue),3) DESC;

SELECT MONTH(OrderDate) as [Months(2013)],DATENAME(month,OrderDate) AS [MonthOfSale],ROUND(SUM(TotalDue),2) as [TotalSalespPerMonth($)] 
FROM Sales.SalesOrderHeader
WHERE YEAR(OrderDate)=2013 
GROUP BY MONTH(OrderDate),DATENAME(month,OrderDate)
ORDER BY MONTH(OrderDate) ASC;

with highCustomers as (
SELECT soh.CustomerID,CONCAT(pp.FirstName,' ',pp.LastName) as [FullName],Round(Sum(TotalDue),2) as [TotalSpenditure($)]
FROM Sales.SalesOrderHeader soh
INNER JOIN Sales.Customer sc
ON soh.CustomerID=sc.CustomerID
INNER JOIN Person.Person pp
ON sc.CustomerID=pp.BusinessEntityID
Group By soh.CustomerID,CONCAT(pp.FirstName,' ',pp.LastName)
--ORDER BY Sum(TotalDue) desc
),territory as(
SELECT hc.CustomerID,FullName,[TotalSpenditure($)],sc.TerritoryID,st.Name,CountryRegionCode,SalesLastYear as [BusinessSalesLastYear]
FROM highCustomers hc
INNER JOIN Sales.Customer sc
ON hc.CustomerID=sc.CustomerID
INNER JOIN Sales.SalesTerritory st
ON sc.TerritoryID=st.TerritoryID

)
SELECT * FROM territory order by [TotalSpenditure($)] DESC;

with Trends as(   ---using ctes
SELECT YEAR(OrderDate) AS[YearOfSale],MONTH(OrderDate) as [MonthOfSale],TotalDue FROM Sales.SalesOrderHeader --Getting the indicidual months and years
),MonthTrends as(
SELECT YearOfSale,MonthOfSale,ROUND(SUM(TotalDue),2) as  [TotalSales] FROM Trends GROUP BY YearOfSale,MonthOfSale-- getting the total sales for each month
),OverallTrends as(
SELECT YearOfSale,MonthOfSale,LAG(TotalSales) OVER(ORDER BY YearOfSale,MonthOfSale ) AS [PrevMonthSales],TotalSales FROM MonthTrends-- using the LAG() window function to get the sales for the previous month for comparison purposes 
)
SELECT *,
Round((((TotalSales-PrevMonthSales)/(PrevMonthSales))*100),2) as [PercantageChange(%)], --calculating percantage increase
CASE
 WHEN TotalSales>PrevMonthSales THEN 'Increase'  --creating a cloumn for more clearity on the change of sales over the months
 WHEN TotalSales=PrevMonthSales THEN 'Same' 
 ELSE 'Decrease'
END AS [SalesTrend]
FROM OverallTrends --could this code be used in the job place?


