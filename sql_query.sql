-- Test
SELECT * from Customer;

SELECT * from Product;

-- Query 1: Find products that have fewer than 50 items in stock
SELECT ProductID, ProductName, Price, StockQuantity
FROM Product
WHERE StockQuantity < 50;


-- Query 2: Calculate the number of orders and total sales
SELECT 
    COUNT(*) AS NumberOfOrders,
    SUM(TotalAmount) AS TotalSales
FROM Orders;

-- Query 3: Show customers and the products they purchased
SELECT 
    Customer.FirstName || ' ' || Customer.LastName AS CustomerName,
    Product.ProductName,
    OrderItem.Quantity,
    OrderItem.UnitPrice
FROM Customer
JOIN Orders 
    ON Customer.CustomerID = Orders.CustomerID
JOIN OrderItem 
    ON Orders.OrderID = OrderItem.OrderID
JOIN Product 
    ON OrderItem.ProductID = Product.ProductID
WHERE Product.Price > 100;