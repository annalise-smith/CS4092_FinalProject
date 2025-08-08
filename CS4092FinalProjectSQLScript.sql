CREATE DATABASE IF NOT EXISTS ecommerce;
USE ecommerce;

-- DROP TABLES IF THEY EXIST
DROP TABLE IF EXISTS Purchase, Product, Customer, Staff;

-- CUSTOMER TABLE
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100),
    Email VARCHAR(100) UNIQUE
);

-- PRODUCT TABLE
CREATE TABLE Product (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100),
    Description TEXT,
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    Stock INT
);

-- PURCHASE TABLE
CREATE TABLE Purchase (
    PurchaseID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    ProductID INT,
    PurchaseDate DATE,
    Quantity INT,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- STAFF TABLE
CREATE TABLE Staff (
    StaffID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100),
    Username VARCHAR(50) UNIQUE,
    Password VARCHAR(100)
);

-- SAMPLE DATA

-- Customers
INSERT INTO Customer (Name, Email)
VALUES 
('Alice Smith', 'alice@example.com'),
('Bob Johnson', 'bob@example.com');

-- Products
INSERT INTO Product (Name, Description, Category, Price, Stock)
VALUES
('Wireless Mouse', 'Ergonomic wireless mouse', 'Electronics', 25.99, 50),
('Keyboard', 'Mechanical keyboard with RGB', 'Electronics', 79.99, 30),
('Notebook', 'College-ruled paper notebook', 'Stationery', 3.99, 200);

-- Purchases
INSERT INTO Purchase (CustomerID, ProductID, PurchaseDate, Quantity)
VALUES
(1, 1, '2025-08-01', 1),
(2, 3, '2025-08-02', 5);

-- Staff
INSERT INTO Staff (Name, Username, Password)
VALUES
('Admin One', 'admin1', 'pass123'),
('Admin Two', 'admin2', 'secure456');