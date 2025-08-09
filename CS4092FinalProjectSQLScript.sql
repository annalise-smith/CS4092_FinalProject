-- Create DB if it doesn't exist
IF DB_ID('ecommerce') IS NULL
    CREATE DATABASE ecommerce;
GO

USE ecommerce;
GO


IF OBJECT_ID('dbo.Purchase', 'U') IS NOT NULL DROP TABLE dbo.Purchase;
IF OBJECT_ID('dbo.Product',  'U') IS NOT NULL DROP TABLE dbo.Product;
IF OBJECT_ID('dbo.Customer', 'U') IS NOT NULL DROP TABLE dbo.Customer;
IF OBJECT_ID('dbo.Staff',    'U') IS NOT NULL DROP TABLE dbo.Staff;
GO


CREATE TABLE dbo.Customer (
    CustomerID INT IDENTITY(1,1) PRIMARY KEY,
    [Name]     VARCHAR(100),
    Email      VARCHAR(100) UNIQUE
);

CREATE TABLE dbo.Product (
    ProductID   INT IDENTITY(1,1) PRIMARY KEY,
    [Name]      VARCHAR(100),
    [Description] VARCHAR(MAX),
    Category    VARCHAR(50),
    Price       DECIMAL(10,2),
    Stock       INT
);


CREATE TABLE dbo.Purchase (
    PurchaseID   INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID   INT,
    ProductID    INT,
    PurchaseDate DATE,
    Quantity     INT,
    CONSTRAINT FK_Purchase_Customer FOREIGN KEY (CustomerID) REFERENCES dbo.Customer(CustomerID),
    CONSTRAINT FK_Purchase_Product  FOREIGN KEY (ProductID)  REFERENCES dbo.Product(ProductID)
);


CREATE TABLE dbo.Staff (
    StaffID  INT IDENTITY(1,1) PRIMARY KEY,
    [Name]   VARCHAR(100),
    Username VARCHAR(50) UNIQUE,
    [Password] VARCHAR(100)
);
GO




INSERT INTO dbo.Customer ([Name], Email) VALUES
('Alice Smith', 'alice@example.com'),
('Bob Johnson',  'bob@example.com');


INSERT INTO dbo.Product ([Name], [Description], Category, Price, Stock) VALUES
('Wireless Mouse', 'Ergonomic wireless mouse', 'Electronics', 25.99, 50),
('Keyboard',       'Mechanical keyboard with RGB', 'Electronics', 79.99, 30),
('Notebook',       'College-ruled paper notebook', 'Stationery', 3.99, 200);


INSERT INTO dbo.Purchase (CustomerID, ProductID, PurchaseDate, Quantity) VALUES
(1, 1, '2025-08-01', 1),
(2, 3, '2025-08-02', 5);


INSERT INTO dbo.Staff ([Name], Username, [Password]) VALUES
('Admin One', 'admin1', 'pass123'),
('Admin Two', 'admin2', 'secure456');
GO


SELECT 
    c.[Name]       AS CustomerName,
    p.[Name]       AS ProductName,
    p.Price,
    pu.Quantity,
    pu.PurchaseDate
FROM dbo.Purchase AS pu
JOIN dbo.Customer AS c ON pu.CustomerID = c.CustomerID
JOIN dbo.Product  AS p ON pu.ProductID  = p.ProductID
WHERE p.Price > 100;


SELECT 
    p.[Name],
    SUM(pu.Quantity) AS TotalSold
FROM dbo.Purchase AS pu
JOIN dbo.Product  AS p ON pu.ProductID = p.ProductID
GROUP BY 
    p.ProductID, p.[Name]
ORDER BY 
    TotalSold DESC;