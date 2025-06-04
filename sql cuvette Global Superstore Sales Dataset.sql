Global Superstore Sales Dataset

CREATE TABLE Orders (
    Row_ID INT,
    Order_ID VARCHAR(20),
    Order_Date VARCHAR(20),
    Ship_Date VARCHAR(20),
    Ship_Mode VARCHAR(50),
    Customer_ID VARCHAR(20),
    Customer_Name VARCHAR(100),
    Segment VARCHAR(50),
    Country VARCHAR(50),
    City VARCHAR(50),
    Postal_Code VARCHAR(10),
    Region VARCHAR(50),
    Product_ID VARCHAR(30),
    Category VARCHAR(50),
    Sub_Category VARCHAR(50),
    Product_Name TEXT,
    Sales DECIMAL(10,2),
    Quantity INT,
    Discount DECIMAL(5,2),
    Profit DECIMAL(10,2)
);
DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders (
    Row_ID INT,
    Order_ID VARCHAR(20),
    Order_Date VARCHAR(20),
    Ship_Date VARCHAR(20),
    Ship_Mode VARCHAR(50),
    Customer_ID VARCHAR(20),
    Customer_Name VARCHAR(100),
    Segment VARCHAR(50),
    Country VARCHAR(50),
    City VARCHAR(50),
    State VARCHAR(50),
    Postal_Code VARCHAR(10),
    Region VARCHAR(50),
    Product_ID VARCHAR(30),
    Category VARCHAR(50),
    Sub_Category VARCHAR(50),
    Product_Name TEXT,
    Sales DECIMAL(10,2),
    Quantity INT,
    Discount DECIMAL(5,2),
    Profit DECIMAL(10,2)
);

Q1 
ALTER TABLE Orders
ADD COLUMN Order_Date_SQL DATE;

SET SQL_SAFE_UPDATES = 0;

UPDATE Orders
SET Order_Date_SQL = STR_TO_DATE(Order_Date, '%m/%d/%Y');

SET SQL_SAFE_UPDATES = 1;  -- (optional) turn it back on


SELECT 
    Order_ID, 
    Order_Date, 
    Order_Date_SQL 
FROM Orders
LIMIT 10;

Q2  
SELECT *
FROM Orders
WHERE 
    Profit IS NOT NULL
    AND Sales IS NOT NULL
    AND Profit >= 0
    AND Sales >= 0;
    
Q3 
   
SET SQL_SAFE_UPDATES = 0;
UPDATE Orders SET Region = LOWER(TRIM(Region));
SET SQL_SAFE_UPDATES = 1;  -- re-enable safe updates if you want

UPDATE Orders
SET Region = LOWER(TRIM(Region))
WHERE Order_ID IS NOT NULL;  -- assuming Order_ID is a primary key

SELECT Customer_ID, 
       SUM(Profit) AS TotalProfit
FROM Orders
GROUP BY Customer_ID
ORDER BY TotalProfit DESC
LIMIT 5;

SELECT Region, 
       AVG(Profit) AS AverageProfit
FROM Orders
GROUP BY Region;

SELECT Category, 
       Sub_Category, 
       SUM(Sales) AS TotalSales
FROM Orders
GROUP BY Category, Sub_Category
ORDER BY Category, Sub_Category;

SELECT Region,
       SUM(Sales) AS TotalSales,
       SUM(Quantity) AS TotalQuantitySold
FROM Orders
GROUP BY Region
ORDER BY Region;

SELECT 
    Customer_ID,
    SUM(Sales) AS TotalSales,
    RANK() OVER (ORDER BY SUM(Sales) DESC) AS SalesRank
FROM Orders
GROUP BY Customer_ID
ORDER BY SalesRank;

SELECT Order_Date, 
       SUM(Sales) AS TotalSales
FROM Orders
GROUP BY Order_Date
ORDER BY TotalSales DESC
LIMIT 1;

SELECT Region,
       AVG(Sales) AS AvgSalesPerOrder
FROM Orders
GROUP BY Region
HAVING AVG(Sales) > 500;

SELECT *,
       CASE 
         WHEN Profit > 1000 THEN 'Yes'
         ELSE 'No'
       END AS High_Profit
FROM Orders;

-- Add the column first
ALTER TABLE Orders ADD COLUMN High_Profit VARCHAR(3);

-- Update the column based on Profit
UPDATE Orders
SET High_Profit = CASE 
                    WHEN Profit > 1000 THEN 'Yes'
                    ELSE 'No'
                  END;

SELECT Category, 
       SUM(Profit) AS TotalProfit
FROM Orders
WHERE Category IN ('Technology', 'Furniture')
GROUP BY Category;

SELECT 
    YEAR(Order_Date) AS OrderYear,
    MONTH(Order_Date) AS OrderMonth,
    SUM(Sales) AS TotalSales
FROM Orders
WHERE Order_Date BETWEEN '2023-01-01' AND '2023-12-31'
GROUP BY YEAR(Order_Date), MONTH(Order_Date)
ORDER BY OrderYear, OrderMonth;

SELECT 
    DATE_FORMAT(Order_Date, '%Y-%m') AS YearMonth,
    SUM(Sales) AS TotalSales
FROM Orders
WHERE Order_Date BETWEEN '2023-01-01' AND '2023-12-31'
GROUP BY YearMonth
ORDER BY YearMonth;

















