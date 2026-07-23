# Relational Schema

## Customer
Customer(
    CustomerID PK,
    FirstName,
    LastName,
    Email UNIQUE,
    Phone,
    RegistrationDate
)

---

## Category
Category(
    CategoryID PK,
    CategoryName,
    Description
)

---

## Product
Product(
    ProductID PK,
    CategoryID FK,
    ProductName,
    Description,
    Price,
    StockQuantity
)

FK: CategoryID → Category(CategoryID)

---

## Orders
Orders(
    OrderID PK,
    CustomerID FK,
    OrderDate,
    TotalAmount,
    OrderStatus
)

FK: CustomerID → Customer(CustomerID)

---

## OrderItem
OrderItem(
    OrderItemID PK,
    OrderID FK,
    ProductID FK,
    Quantity,
    UnitPrice
)

FK: OrderID → Orders(OrderID)

FK: ProductID → Product(ProductID)

---

## Payment
Payment(
    PaymentID PK,
    OrderID FK,
    PaymentMethod,
    PaymentDate,
    Amount,
    PaymentStatus
)

FK: OrderID → Orders(OrderID)

---

## Shipping
Shipping(
    ShippingID PK,
    OrderID FK,
    ShippingAddress,
    TrackingNumber,
    ShippingStatus,
    DeliveryDate
)

FK: OrderID → Orders(OrderID)

---

## Review
Review(
    ReviewID PK,
    CustomerID FK,
    ProductID FK,
    Rating,
    ReviewText,
    ReviewDate
)

FK: CustomerID → Customer(CustomerID)

FK: ProductID → Product(ProductID)
