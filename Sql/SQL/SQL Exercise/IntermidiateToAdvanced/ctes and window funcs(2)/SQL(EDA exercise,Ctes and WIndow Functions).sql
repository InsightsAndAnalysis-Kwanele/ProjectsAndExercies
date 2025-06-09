SELECT * FROM Customers
SELECT * FROM OrderDetails
SELECT * FROM Orders
SELECT * FROM Products
-------------------------------------------------


---------------------------------------
--1.Assessing stock quantity from products table
SELECT *,
CASE
	WHEN StockQuantity<50 THEN 'Low Stock'
	WHEN StockQuantity BETWEEN 50 AND 100 THEN 'Medium Stock'
	ELSE 'High Stock'

END AS [LevelOfStock]
FROM Products

--2.Getting Customers who placed an order
SELECT * FROM Orders
SELECT * FROM Orderdetails
SELECT *FROM Customers

SELECT CustomerID,FirstName,LastName FROM Customers WHERE CustomerID in (SELECT CustomerID FROM Orders);



----------getting how much each person spent
WITH total_spent as(

SELECT OrderID,SUM(UnitPrice*Quantity) as [TotalSapent]
FROM OrderDetails 
GROUP BY OrderID


),saleOrders as (
SELECT o.OrderID as [OrderID],CustomerID,[TotalSapent]
from Orders o JOIN total_spent ts
ON o.OrderID=ts.OrderID
)

SELECT OrderID,c.CustomerID,FirstName,LastName ,[TotalSapent]
FROM Customers c JOIN saleOrders  so
ON c.CustomerID=so.CustomerID




---------------
--3.sUmmed price
SELECT OrderDetailID,OrderID,ProductID,Quantity,UnitPrice,SUM(UnitPrice*Quantity) OVER(ORDER BY OrderDetailID) as RunningTotal FROM OrderDetails
------------------------------------

--4.Ranking orders
SELECT OrderID,CustomerID,OrderDate,ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY OrderDate) AS OrderRank FROM Orders

--5.Ranking products by price
SELECT ProductID,ProductName,Category,Price,RANK() OVER(ORDER BY Price DESC) AS PriceRank FROM Products
--6.using dense rank
SELECT ProductID,ProductName,Category,Price,Dense_RANK() OVER(ORDER BY Price DESC) AS PriceDenseRank FROM Products
--7.Seeing the next product
SELECT ProductID,ProductName,Category,Price,Lead(Price) OVER (Order by Price ASC) AS NextProductPrice  FROM Products;
--8.uSING A cte to calculate total sales for eAch product
WITH  TotalPoductPrice as (

SELECT ProductID,SUM(Quantity) as TotalQuantity,SUM(UnitPrice*Quantity) AS TotalSales FROM OrderDetails GROUP BY ProductID

)
SELECT p.ProductID,ProductName,TotalQuantity,TotalSales
FROM Products p JOIN TotalPoductPrice tp
ON p.ProductID=tp.ProductID;


---9.Temp table to get 
WITH TotalOrderSale as (
	SELECT OrderID,SUM(UnitPrice*Quantity) AS TotalSales 
	FROM OrderDetails
	GROUP BY OrderID
)


SELECT *
INTO #OrderSales
FROM TotalOrderSale


SELECT * FROM #OrderSales
GO

--10.Creating a stored procedure for a customer and their orders
CREATE PROCEDURE GetCustomerOrders @OptCustomerID int
AS
BEGIN
----getting how much each person spent
WITH total_spent as(

SELECT OrderID,SUM(UnitPrice*Quantity) as [TotalSapent]
FROM OrderDetails 
GROUP BY OrderID


),saleOrders as (
SELECT o.OrderID as [OrderID],CustomerID,[TotalSapent]
from Orders o JOIN total_spent ts
ON o.OrderID=ts.OrderID
)

SELECT OrderID,c.CustomerID,FirstName,LastName ,[TotalSapent]
FROM Customers c JOIN saleOrders  so
ON c.CustomerID=so.CustomerID
where c.customerID=@OptCustomerID




END
GO



exec GetCustomerOrders @OptCustomerID=2

