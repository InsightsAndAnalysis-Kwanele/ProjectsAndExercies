CREATE DATABASE CompanyDataBase;
GO
USE CompanyDataBase;
GO

-- Employee Table
CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    DepartmentID INT,
    Salary DECIMAL(10,2),
    HireDate DATE
);
GO

-- Department Table
CREATE TABLE Department (
    DepartmentID INT PRIMARY KEY IDENTITY(1,1),
    DepartmentName NVARCHAR(100)
);
GO

-- Project Table
CREATE TABLE Project (
    ProjectID INT PRIMARY KEY IDENTITY(1,1),
    ProjectName NVARCHAR(100),
    Budget DECIMAL(12,2)
);
GO

-- EmployeeProject (Many-to-Many Relationship)
CREATE TABLE EmployeeProject (
    EmployeeID INT,
    ProjectID INT,
    HoursWorked INT,
    PRIMARY KEY (EmployeeID, ProjectID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY (ProjectID) REFERENCES Project(ProjectID)
);
GO

-- Insert Sample Data
INSERT INTO Department (DepartmentName) VALUES ('IT'), ('HR'), ('Finance');

INSERT INTO Employee (FirstName, LastName, DepartmentID, Salary, HireDate)
VALUES 
    ('John', 'Doe', 1, 70000, '2018-06-15'),
    ('Jane', 'Smith', 2, 65000, '2019-07-20'),
    ('Alice', 'Johnson', 1, 80000, '2017-04-25'),
    ('Bob', 'Brown', 3, 72000, '2020-01-10'),
    ('Charlie', 'Davis', 2, 68000, '2021-09-05');

INSERT INTO Project (ProjectName, Budget)
VALUES 
    ('Website Redesign', 50000),
    ('HR System Upgrade', 30000),
    ('Financial Audit', 70000);

INSERT INTO EmployeeProject (EmployeeID, ProjectID, HoursWorked)
VALUES 
    (1, 1, 100),
    (2, 2, 120),
    (3, 1, 90),
    (4, 3, 80),
    (5, 2, 110);
GO
