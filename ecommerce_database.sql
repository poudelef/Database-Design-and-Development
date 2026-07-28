CREATE TABLE IF NOT EXISTS Customer(
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(20),
    RegistrationDate DATE
);

CREATE TABLE IF NOT EXISTS Payment(
    PaymentID INT PRIMARY KEY,
    OrderID INTEGER UNIQUE,
    PaymentMethod VARCHAR(50),
    PaymentDate DATETIME,
    Amount FLOAT,
    PaymentStatus VARCHAR(50)
);

