# Entity-Relationship (ER) Diagram

## Strong and Weak Entities

### Strong Entities
Strong entities have their own primary key and can exist independently.

- **Customer**
- **Category**
- **Product**
- **Orders**
- **Payment**
- **Shipping**
- **Review**

### Weak (Associative) Entity
Weak entities depend on other entities for their existence.

- **OrderItem** *(Associative Entity)*  
  - Resolves the many-to-many relationship between **Orders** and **Product**.
  - Depends on both **Orders** and **Product**.

---

# Entities and Attributes

## Customer (Strong Entity)

**Primary Key**
- CustomerID

**Attributes**
- FirstName
- LastName
- Email *(Unique)*
- Phone
- RegistrationDate

---

## Category (Strong Entity)

**Primary Key**
- CategoryID

**Attributes**
- CategoryName
- Description

---

## Product (Strong Entity)

**Primary Key**
- ProductID

**Foreign Key**
- CategoryID → Category.CategoryID

**Attributes**
- ProductName
- Description
- Price
- StockQuantity

---

## Orders (Strong Entity)

**Primary Key**
- OrderID

**Foreign Key**
- CustomerID → Customer.CustomerID

**Attributes**
- OrderDate
- TotalAmount
- OrderStatus

---

## OrderItem (Weak / Associative Entity)

This entity resolves the many-to-many relationship between **Orders** and **Product**.

**Primary Key**
- OrderItemID

**Foreign Keys**
- OrderID → Orders.OrderID
- ProductID → Product.ProductID

**Attributes**
- Quantity
- UnitPrice

---

## Payment (Strong Entity)

**Primary Key**
- PaymentID

**Foreign Key**
- OrderID → Orders.OrderID

**Attributes**
- PaymentMethod
- PaymentDate
- Amount
- PaymentStatus

---

## Shipping (Strong Entity)

**Primary Key**
- ShippingID

**Foreign Key**
- OrderID → Orders.OrderID

**Attributes**
- ShippingAddress
- TrackingNumber
- ShippingStatus
- DeliveryDate

---

## Review (Strong Entity)

**Primary Key**
- ReviewID

**Foreign Keys**
- CustomerID → Customer.CustomerID
- ProductID → Product.ProductID

**Attributes**
- Rating
- ReviewText
- ReviewDate

---

# Entity Relationships

| Relationship | Cardinality |
|--------------|-------------|
| Customer → Orders | One-to-Many (1:M) |
| Category → Product | One-to-Many (1:M) |
| Orders → OrderItem | One-to-Many (1:M) |
| Product → OrderItem | One-to-Many (1:M) |
| Orders → Payment | One-to-One (1:1) |
| Orders → Shipping | One-to-One (1:1) |
| Customer → Review | One-to-Many (1:M) |
| Product → Review | One-to-Many (1:M) |

---

# Relationship Summary

- One customer can place many orders.
- Each order belongs to exactly one customer.
- One category can contain many products.
- Each product belongs to one category.
- One order can contain multiple products.
- One product can appear in multiple orders.
- The **OrderItem** entity resolves the many-to-many relationship between **Orders** and **Product**.
- Each order has one payment record.
- Each order has one shipping record.
- One customer can submit multiple product reviews.
- One product can receive reviews from multiple customers.



# dbdiagram.io code: https://dbdiagram.io/d/6a623523c3a90dd98da22d1e
```
Table Customer {
  CustomerID int [pk, increment]
  FirstName varchar
  LastName varchar
  Email varchar [unique]
  Phone varchar
  RegistrationDate date
}

Table Category {
  CategoryID int [pk, increment]
  CategoryName varchar
  Description text
}

Table Product {
  ProductID int [pk, increment]
  CategoryID int
  ProductName varchar
  Description text
  Price decimal
  StockQuantity int
}

Table Orders {
  OrderID int [pk, increment]
  CustomerID int
  OrderDate date
  TotalAmount decimal
  OrderStatus varchar
}

Table OrderItem {
  OrderItemID int [pk, increment]
  OrderID int
  ProductID int
  Quantity int
  UnitPrice decimal
}

Table Payment {
  PaymentID int [pk, increment]
  OrderID int
  PaymentMethod varchar
  PaymentDate date
  Amount decimal
  PaymentStatus varchar
}

Table Shipping {
  ShippingID int [pk, increment]
  OrderID int
  ShippingAddress varchar
  TrackingNumber varchar
  ShippingStatus varchar
  DeliveryDate date
}

Table Review {
  ReviewID int [pk, increment]
  CustomerID int
  ProductID int
  Rating int
  ReviewText text
  ReviewDate date
}

Ref: Orders.CustomerID > Customer.CustomerID

Ref: Product.CategoryID > Category.CategoryID

Ref: OrderItem.OrderID > Orders.OrderID

Ref: OrderItem.ProductID > Product.ProductID

Ref: Payment.OrderID - Orders.OrderID

Ref: Shipping.OrderID - Orders.OrderID

Ref: Review.CustomerID > Customer.CustomerID

Ref: Review.ProductID > Product.ProductID
```
