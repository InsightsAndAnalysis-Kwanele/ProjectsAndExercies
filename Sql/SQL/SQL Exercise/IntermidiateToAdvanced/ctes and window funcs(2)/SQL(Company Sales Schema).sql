CREATE DATABASE CompanySalesDB;
GO
USE CompanySalesDB;
GO

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Email NVARCHAR(100),
    Phone NVARCHAR(20),
    JoinDate DATE
);
GO

CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    ProductName NVARCHAR(100),
    Category NVARCHAR(50),
    Price DECIMAL(10,2),
    StockQuantity INT
);
GO

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT FOREIGN KEY REFERENCES Customers(CustomerID),
    OrderDate DATE
);
GO

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
    ProductID INT FOREIGN KEY REFERENCES Products(ProductID),
    Quantity INT,
    UnitPrice DECIMAL(10,2)
);
GO

INSERT INTO Customers (FirstName, LastName, Email, Phone, JoinDate)
VALUES 
('John', 'Doe', 'john.doe@email.com', '123-456-7890', '2023-01-15'),
('Jane', 'Smith', 'jane.smith@email.com', '234-567-8901', '2022-11-20'),
('Alice', 'Johnson', 'alice.j@email.com', '345-678-9012', '2023-05-10');

INSERT INTO Products (ProductName, Category, Price, StockQuantity)
VALUES 
('Laptop', 'Electronics', 999.99, 50),
('Smartphone', 'Electronics', 599.99, 100),
('Tablet', 'Electronics', 299.99, 80),
('Headphones', 'Accessories', 49.99, 200);

INSERT INTO Orders (CustomerID, OrderDate)
VALUES 
(1, '2024-01-05'),
(2, '2024-02-10'),
(3, '2024-03-12');

INSERT INTO OrderDetails (OrderID, ProductID, Quantity, UnitPrice)
VALUES 
(1, 1, 1, 999.99),
(1, 4, 2, 49.99),
(2, 2, 1, 599.99),
(3, 3, 2, 299.99),
(3, 4, 1, 49.99);
GO
