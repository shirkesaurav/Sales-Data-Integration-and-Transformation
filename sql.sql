
create database project3;

use project3

create table CustomerTable (
customerid int,
firstname varchar(500),
lastname varchar(500),
email varchar(500), 
country varchar(500));

select * from customertable;

INSERT INTO customertable
VALUES
(1, 'John', 'Doe', 'john.doe@email.com', 'USA'),
(2, 'Alice', 'Smith', 'alice.smith@email.com', 'Canada'),
(3, 'Bob', 'Johnson', 'bob.johnson@email.com', 'UK'),
(4, 'Emily', 'Brown', 'emily.brown@email.com', 'Australia'),
(5, 'Michael', 'Davis', 'michael.davis@email.com', 'USA'),
(6, 'Sarah', 'Wilson', 'sarah.wilson@email.com', 'Germany'),
(7, 'Jason', 'Lee', 'jason.lee@email.com', 'Canada'),
(8, 'Olivia', 'Martinez', 'olivia.martinez@email.com', 'Mexico'),
(9, 'Ethan', 'Anderson', 'ethan.anderson@email.com', 'USA'),
(10, 'Emma', 'Kim', 'emma.kim@email.com', 'South Korea');

CREATE TABLE ProductSales (
    SaleID INT PRIMARY KEY,
    CustomerID INT,
    ProductName NVARCHAR(100),
    SaleAmount DECIMAL(18, 2),
    SaleDate DATE
);

CREATE TABLE ExchangeRates (
    RateID INT PRIMARY KEY,
    CurrencyFrom NVARCHAR(3),
    CurrencyTo NVARCHAR(3),
    ExchangeRate DECIMAL(18, 4),
    RateDate DATE
);

-- Dummy data for ProductSales
INSERT INTO ProductSales VALUES
    (101, 1, 'Laptop', 1200.00, '2023-01-05'),
    (102, 2, 'Smartphone', 800.50, '2023-01-10'),
    (103, 3, 'Tablet', 400.25, '2023-01-15'),
    (104, 4, 'Camera', 600.75, '2023-01-20'),
    (105, 5, 'TV', 1500.00, '2023-01-25'),
    (106, 6, 'Headphones', 100.50, '2023-02-01'),
    (107, 7, 'Printer', 300.25, '2023-02-05'),
    (108, 8, 'Monitor', 450.75, '2023-02-10'),
    (109, 9, 'Keyboard', 50.00, '2023-02-15'),
    (110, 10, 'Mouse', 25.50, '2023-02-20');
    
-- Dummy data for ExchangeRates
INSERT INTO ExchangeRates VALUES
    (201, 'USD', 'EUR', 0.85, '2023-01-05'),
    (202, 'CAD', 'USD', 0.75, '2023-01-10'),
    (203, 'GBP', 'USD', 1.30, '2023-01-15'),
    (204, 'AUD', 'USD', 0.70, '2023-01-20'),
    (205, 'EUR', 'GBP', 0.75, '2023-01-25'),
    (206, 'USD', 'AUD', 1.43, '2023-02-01'),
    (207, 'EUR', 'CAD', 1.33, '2023-02-05'),
    (208, 'MXN', 'USD', 0.050, '2023-02-10'),
    (209, 'KRW', 'USD', 0.00090, '2023-02-15'),
    (210, 'USD', 'MXN', 20.00, '2023-02-20');
    
CREATE TABLE ProcessedData (
    ProcessedID INT PRIMARY KEY,
    CustomerID INT,
    CustomerName NVARCHAR(100),
    Email NVARCHAR(100),
    PhoneNumber NVARCHAR(20),
    ProductName NVARCHAR(100),
    SaleAmount DECIMAL(18, 2),
    SaleDate DATE,
    Country NVARCHAR(50),
    ExchangeRate DECIMAL(18, 4),
    ProcessedDate DATETIME,
    FullName NVARCHAR(200),
    SalesAmountUSD DECIMAL(18, 2),
    EmailDomain NVARCHAR(50)
);

select * from processeddatausa;

select * from processeddata;

Truncate Table project3.processeddata;

RENAME TABLE processeddata TO processeddatausa;

drop table processeddatausa;

CREATE TABLE ProcessedData (
    ProcessedID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT,
    CustomerName NVARCHAR(100),
    Email NVARCHAR(100),
    PhoneNumber NVARCHAR(20),
    ProductName NVARCHAR(100),
    SaleAmount DECIMAL(18, 2),
    SaleDate DATE,
    Country NVARCHAR(50),
    ExchangeRate DECIMAL(18, 4),
    ProcessedDate DATETIME,
    FullName NVARCHAR(200),
    SalesAmountUSD DECIMAL(18, 2),
    EmailDomain NVARCHAR(50)
);

-- Update the FullName column
UPDATE ProcessedData
SET FullName = CustomerName + ' - ' + ProductName;

-- Update the Sales Amount in USD column
UPDATE ProcessedData
SET SalesAmountUSD = SaleAmount * ExchangeRate;

CREATE TABLE ProcessedDatausa (
    ProcessedID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT,
    CustomerName NVARCHAR(100),
    Email NVARCHAR(100),
    PhoneNumber NVARCHAR(20),
    ProductName NVARCHAR(100),
    SaleAmount DECIMAL(18, 2),
    SaleDate DATE,
    Country NVARCHAR(50),
    ExchangeRate DECIMAL(18, 4),
    ProcessedDate DATETIME,
    FullName NVARCHAR(200),
    SalesAmountUSD DECIMAL(18, 2),
    EmailDomain NVARCHAR(50)
);

-- Update the FullName column
UPDATE ProcessedDatausa
SET FullName = CustomerName + ' - ' + ProductName;

-- Update the Sales Amount in USD column
UPDATE ProcessedDatausa
SET SalesAmountUSD = SaleAmount * ExchangeRate;

select * from processeddata;

select * from processeddatausa;

ALTER TABLE ProcessedData
DROP COLUMN phonenumber;

ALTER TABLE ProcessedDatausa
DROP COLUMN phonenumber;

UPDATE ProcessedData
SET customername = fullname;

UPDATE ProcessedDatausa
SET customername = fullname;

select * from processeddata;

select * from processeddatausa;

select * from productsales;

delete from processeddata
where customername is null;

select f.customerid, p.productname, p.saleamount, p.SaleDate
from processeddata f
left join productsales p on f.customerid = p.customerid;

UPDATE ProcessedData AS f
SET 
    f.ProductName = (
        SELECT p.ProductName
        FROM ProductSales p
        WHERE p.CustomerID = f.CustomerID
        LIMIT 1
    ),
    f.SaleAmount = (
        SELECT p.SaleAmount
        FROM ProductSales p
        WHERE p.CustomerID = f.CustomerID
        LIMIT 1
    ),
    f.SaleDate = (
        SELECT p.SaleDate
        FROM ProductSales p
        WHERE p.CustomerID = f.CustomerID
        LIMIT 1
    );

UPDATE ProcessedDatausa AS f
SET 
    f.ProductName = (
        SELECT p.ProductName
        FROM ProductSales p
        WHERE p.CustomerID = f.CustomerID
        LIMIT 1
    ),
    f.SaleAmount = (
        SELECT p.SaleAmount
        FROM ProductSales p
        WHERE p.CustomerID = f.CustomerID
        LIMIT 1
    ),
    f.SaleDate = (
        SELECT p.SaleDate
        FROM ProductSales p
        WHERE p.CustomerID = f.CustomerID
        LIMIT 1
    );

select * from processeddata;

select * from processeddatausa;

select * from exchangerates;

alter table processeddata
add column currency varchar(50);

update processeddatausa
set currency = 'USD';

UPDATE processeddata
SET currency = 
    CASE
        WHEN Country = 'Canada' THEN 'CAD'
        WHEN Country = 'UK' THEN 'GBP'
        WHEN Country = 'Australia' THEN 'AUD'
        WHEN Country = 'Germany' THEN 'EUR'
        WHEN Country = 'Mexico' THEN 'MXN'
        WHEN Country = 'South Korea' THEN 'KRW'
        ELSE 'Unknown'
    END;

select * from processeddata;

select * from processeddatausa;

select * from exchangerates;

update processeddatausa
set exchangerate = 1 ;

UPDATE processeddata AS t2
JOIN exchangerates AS t1 ON t2.currency = t1.CurrencyFrom AND t2.SaleDate = t1.RateDate
SET t2.ExchangeRate = t1.ExchangeRate;

update processeddatausa
set salesamountusd = saleamount * exchangerate ;

update processeddata
set salesamountusd = saleamount * exchangerate ;


select * from processeddata;

select * from processeddatausa;

DELIMITER //

CREATE PROCEDURE UpdateProcessedData()
BEGIN
    -- Step 1: Update ProductSales Information in ProcessedDatausa
    UPDATE ProcessedDatausa AS f
    SET 
        f.ProductName = (
            SELECT p.ProductName
            FROM ProductSales p
            WHERE p.CustomerID = f.CustomerID
            LIMIT 1
        ),
        f.SaleAmount = (
            SELECT p.SaleAmount
            FROM ProductSales p
            WHERE p.CustomerID = f.CustomerID
            LIMIT 1
        ),
        f.SaleDate = (
            SELECT p.SaleDate
            FROM ProductSales p
            WHERE p.CustomerID = f.CustomerID
            LIMIT 1
        );

    -- Step 2: Update Currency and Exchange Rate Information in ProcessedDatausa
    UPDATE ProcessedDatausa
    SET 
        currency = 'USD',
        exchangerate = 1;

    -- Step 3: Calculate SalesAmountUSD in ProcessedDatausa
    UPDATE ProcessedDatausa
    SET salesamountusd = saleamount * exchangerate;

    -- Step 4: Update ProductSales Information in ProcessedData
    UPDATE ProcessedData AS f
    SET 
        f.ProductName = (
            SELECT p.ProductName
            FROM ProductSales p
            WHERE p.CustomerID = f.CustomerID
            LIMIT 1
        ),
        f.SaleAmount = (
            SELECT p.SaleAmount
            FROM ProductSales p
            WHERE p.CustomerID = f.CustomerID
            LIMIT 1
        ),
        f.SaleDate = (
            SELECT p.SaleDate
            FROM ProductSales p
            WHERE p.CustomerID = f.CustomerID
            LIMIT 1
        );

    -- Step 5: Update Currency Information in ProcessedData based on Country
    UPDATE ProcessedData
    SET currency = 
        CASE
            WHEN Country = 'Canada' THEN 'CAD'
            WHEN Country = 'UK' THEN 'GBP'
            WHEN Country = 'Australia' THEN 'AUD'
            WHEN Country = 'Germany' THEN 'EUR'
            WHEN Country = 'Mexico' THEN 'MXN'
            WHEN Country = 'South Korea' THEN 'KRW'
            ELSE 'Unknown'
        END;

    -- Step 6: Update Exchange Rate Information in ProcessedData based on Currency and SaleDate
    UPDATE ProcessedData AS t2
    JOIN Exchangerates AS t1 ON t2.currency = t1.CurrencyFrom AND t2.SaleDate = t1.RateDate
    SET t2.ExchangeRate = t1.ExchangeRate;

    -- Step 7: Calculate SalesAmountUSD in ProcessedData
    UPDATE ProcessedData
    SET salesamountusd = saleamount * exchangerate;
END //

DELIMITER ;

call  UpdateProcessedData();














