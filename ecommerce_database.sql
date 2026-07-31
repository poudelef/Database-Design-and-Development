CREATE TABLE IF NOT EXISTS Customer(
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(20),
    RegistrationDate DATE
);


CREATE TABLE IF NOT EXISTS Category(
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(50),
    Category_Description VARCHAR(150)
);

CREATE TABLE IF NOT EXISTS Product(
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Product_Description VARCHAR(150),
    Price REAL,
    StockQuantity INT,
    CategoryID INT,

    CONSTRAINT fk_category
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID)
);

CREATE TABLE IF NOT EXISTS Orders(
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATETIME,
    TotalAmount REAL,
    OrderStatus VARCHAR(50),

    CONSTRAINT fk_CustomerID
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);


CREATE TABLE IF NOT EXISTS OrderItem(
    OrderItemID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    UnitPrice REAL,

    CONSTRAINT fk_OrderID
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    CONSTRAINT fk_ProductID
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

CREATE TABLE IF NOT EXISTS Payment(
    PaymentID INT PRIMARY KEY,
    OrderID INT UNIQUE,
    PaymentMethod VARCHAR(50),
    PaymentDate DATETIME,
    Amount REAL,
    PaymentStatus VARCHAR(50),

    CONSTRAINT fk_OrderID
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

CREATE TABLE IF NOT EXISTS Shipping(
    ShippingID INT PRIMARY KEY,
    OrderID INT UNIQUE,
    ShippingAddress VARCHAR(255),
    TrackingNumber VARCHAR(100),
    ShippingStatus VARCHAR(50),
    DeliveryDate DATE,

    CONSTRAINT fk_OrderID
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

CREATE TABLE IF NOT EXISTS Review(
    ReviewID INT PRIMARY KEY,
    CustomerID INT,
    ProductID INT,
    Rating INT,
    ReviewText VARCHAR(500),
    ReviewDate DATE,

    CONSTRAINT fk_CustomerID
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    CONSTRAINT fk_ProductID
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);



-- ==========================
-- Customer
-- ==========================
INSERT INTO Customer (CustomerID, FirstName, LastName, Email, Phone, RegistrationDate)
VALUES
(1, 'John', 'Doe', 'john.doe@email.com', '513-111-1111', '2026-01-15'),
(2, 'Jane', 'Smith', 'jane.smith@email.com', '513-222-2222', '2026-02-20'),
(3, 'Michael', 'Johnson', 'michael.j@email.com', '513-333-3333', '2026-03-10'),
(4, 'Emily', 'Brown', 'emily.b@email.com', '513-444-4444', '2026-04-05'),
(5, 'David', 'Wilson', 'david.w@email.com', '513-555-5555', '2026-05-12');

-- ==========================
-- Category
-- ==========================
INSERT INTO Category (CategoryID, CategoryName, Category_Description)
VALUES
(1, 'Electronics', 'Electronic devices and accessories'),
(2, 'Books', 'Books and educational materials'),
(3, 'Clothing', 'Men and women clothing'),
(4, 'Home', 'Home and kitchen products');

-- ==========================
-- Product
-- (Assumes Product has CategoryID)
-- ==========================
INSERT INTO Product (ProductID, CategoryID, ProductName, Product_Description, Price, StockQuantity)
VALUES
(101, 1, 'Laptop', '15-inch gaming laptop', 999.99, 20),
(102, 1, 'Wireless Mouse', 'Bluetooth mouse', 29.99, 100),
(103, 2, 'Database Systems', 'Database design textbook', 89.99, 40),
(104, 3, 'T-Shirt', 'Cotton T-Shirt', 19.99, 150),
(105, 4, 'Coffee Maker', '12-cup coffee maker', 79.99, 30);

-- ==========================
-- Orders
-- ==========================
-- INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount, OrderStatus)
-- VALUES
-- (1001, 1, '2026-06-01 10:30:00', 1029.98, 'Completed'),
-- (1002, 2, '2026-06-03 14:15:00', 109.98, 'Shipped'),
-- (1003, 3, '2026-06-05 09:45:00', 19.99, 'Pending'),
-- (1004, 4, '2026-06-08 16:20:00', 79.99, 'Completed'),
-- (1005, 5, '2026-06-10 11:00:00', 89.99, 'Processing');

-- ==========================
-- OrderItem
-- ==========================
-- INSERT INTO OrderItem (OrderItemID, OrderID, ProductID, Quantity, UnitPrice)
-- VALUES
-- (1, 1001, 101, 1, 999.99),
-- (2, 1001, 102, 1, 29.99),
-- (3, 1002, 103, 1, 89.99),
-- (4, 1002, 102, 1, 19.99),
-- (5, 1003, 104, 1, 19.99),
-- (6, 1004, 105, 1, 79.99),
-- (7, 1005, 103, 1, 89.99);

-- ==========================
-- Payment
-- ==========================
-- INSERT INTO Payment (PaymentID, OrderID, PaymentMethod, PaymentDate, Amount, PaymentStatus)
-- VALUES
-- (1, 1001, 'Credit Card', '2026-06-01 10:35:00', 1029.98, 'Paid'),
-- (2, 1002, 'PayPal', '2026-06-03 14:20:00', 109.98, 'Paid'),
-- (3, 1003, 'Debit Card', '2026-06-05 09:50:00', 19.99, 'Pending'),
-- (4, 1004, 'Credit Card', '2026-06-08 16:25:00', 79.99, 'Paid'),
-- (5, 1005, 'Apple Pay', '2026-06-10 11:05:00', 89.99, 'Processing');

-- ==========================
-- Shipping
-- ==========================
-- INSERT INTO Shipping (ShippingID, OrderID, ShippingAddress, TrackingNumber, ShippingStatus, DeliveryDate)
-- VALUES
-- (1, 1001, '123 Main St, Cincinnati, OH', 'TRK100001', 'Delivered', '2026-06-04'),
-- (2, 1002, '456 Oak Ave, Columbus, OH', 'TRK100002', 'In Transit', NULL),
-- (3, 1003, '789 Pine Rd, Dayton, OH', 'TRK100003', 'Preparing', NULL),
-- (4, 1004, '321 Elm St, Toledo, OH', 'TRK100004', 'Delivered', '2026-06-11'),
-- (5, 1005, '654 Maple Dr, Cleveland, OH', 'TRK100005', 'Processing', NULL);

-- -- ==========================
-- -- Review
-- -- ==========================
-- INSERT INTO Review (ReviewID, CustomerID, ProductID, Rating, ReviewText, ReviewDate)
-- VALUES
-- (1, 1, 101, 5, 'Excellent laptop. Very fast and reliable.', '2026-06-10'),
-- (2, 2, 103, 4, 'Very informative textbook.', '2026-06-12'),
-- (3, 3, 104, 5, 'Comfortable and fits perfectly.', '2026-06-15'),
-- (4, 4, 105, 4, 'Makes great coffee every morning.', '2026-06-18'),
-- (5, 5, 102, 5, 'Mouse is responsive and easy to use.', '2026-06-20');