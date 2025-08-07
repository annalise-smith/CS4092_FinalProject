
-- DROP TABLES IF THEY EXIST
DROP TABLE IF EXISTS Purchase, CreditCard, Product, Customer, Staff;

-- CUSTOMER TABLE
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100),
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(20)
);

-- CREDIT CARD TABLE
CREATE TABLE CreditCard (
    CardID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    CardNumber VARCHAR(16),
    ExpirationDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
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
INSERT INTO Customer (Name, Email, Phone)
VALUES 
('Alice Smith', 'alice@example.com', '123-456-7890'),
('Bob Johnson', 'bob@example.com', '234-567-8901');

-- Credit Cards
INSERT INTO CreditCard (CustomerID, CardNumber, ExpirationDate)
VALUES 
(1, '1111222233334444', '2026-12-31'),
(1, '5555666677778888', '2027-06-30'),
(2, '9999000011112222', '2025-11-15');

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
