# Online E-Commerce Management System

---

## 1. Project Overview

This individual project focuses on the design and development of a relational database system for an online e-commerce platform. The system will manage information related to customers, products, product categories, orders, payments, shipping, inventory, and product reviews.

---

## 2. Project Goals and Scope

### 2.1 Project Goals

The primary goals of this project are to:

* Identify and document the data requirements of an e-commerce system.
* Design an Entity-Relationship Diagram.
* Convert the ER model into a relational database schema.
* Implement the database using SQL.
* Populate the database with sample data.
* Write SQL queries to retrieve and analyze data.
* Develop a Python application that interacts with the database.

### 2.2 System Scope

The system will support the following major functionality:

* Customer information management
* Product and category management
* Product inventory tracking
* Customer order management
* Order item tracking
* Payment record management
* Shipping information management
* Product reviews and ratings
* Customer order history
* SQL-based data retrieval

---

## 3. Stakeholders and Users

### Customer

Customers will be able to:

* View available products.
* Browse products by category.
* Place orders.
* View their previous orders.
* View order status.

### Store Administrator

The administrator will be able to:

* Add, update, and remove products.
* Manage product categories.
* Update inventory quantities.
* View customer orders.
* Update order statuses.

### System Developer

The system developer is responsible for designing, implementing, testing, and demonstrating the database system. 
---

## 4. Functional Requirements

### FR-01: Customer Management

The system shall store customer information including customer ID, name, email address, phone number, and registration date. Each customer must have a unique customer ID and email address.

### FR-02: Product and Category Management

The system shall store product information including product ID, product name, description, price, stock quantity, and category. Products shall be organized into categories. Each product shall belong to one category, while a category may contain multiple products.

### FR-03: Product Browsing

The system shall allow customers to view available products and their relevant information, including product name, description, price, category, and available inventory.

### FR-04: Order Management

The system shall allow customers to place orders containing one or more products. Each order shall be associated with one customer and shall include an order date, total amount, and order status.

### FR-05: Order Item Management

The system shall store the individual products included in each order. Each order item shall contain the associated order, product, quantity, and price at the time of purchase.

Because one order may contain multiple products and one product may appear in multiple orders, the relationship between orders and products will be represented using an `OrderItem` relationship table.

### FR-06: Inventory Management

The system shall track the quantity of each product available for purchase. When an order is placed, the system shall reduce the product inventory based on the quantity purchased. The system shall not allow customers to purchase more products than are available.

### FR-07: Payment and Shipping Records

The system shall store payment records associated with orders. Payment information will include payment method, amount, date, and status. The system shall also store shipping information such as shipping address, tracking number, shipping status, and delivery information.

The project will record payment and shipping information but will not process real financial transactions or integrate with external shipping services.

---

## 5. Use Cases

### UC-01: View Available Products

**Actor:** Customer

The customer requests the product catalog. The system retrieves available products and displays product names, prices, categories, and inventory information.

**Expected Result:** The customer can view products available for purchase.

### UC-02: Place an Order

**Actor:** Customer

The customer selects one or more products. The system verifies inventory availability, creates an order, records the selected products in the `OrderItem` table, calculates the order total, and updates inventory.

**Expected Result:** A new order is successfully stored in the database.

### UC-03: View Order History

**Actor:** Customer

The customer requests their previous orders. The system retrieves orders associated with the customer and displays order details, including date, products, total amount, and order status.

**Expected Result:** The customer can view their previous purchases.

### UC-04: Manage Products

**Actor:** Administrator

The administrator can add, update, or remove products and modify product information such as price, description, and inventory quantity.

**Expected Result:** The product catalog is updated.

### UC-05: Update Order Status

**Actor:** Administrator

The administrator selects an order and updates its status, such as Pending, Processing, Shipped, Delivered, or Cancelled.

**Expected Result:** The current order status is updated in the database.

---

## 6. Data Requirements

The database is expected to contain the following major entities:

| Entity    | Purpose                                  |
| --------- | ---------------------------------------- |
| Customer  | Stores customer information              |
| Category  | Stores product category information      |
| Product   | Stores product and inventory information |
| Order     | Stores customer order information        |
| OrderItem | Stores products included in each order   |
| Payment   | Stores payment records                   |
| Shipping  | Stores shipping information              |

Each entity will have a primary key that uniquely identifies its records. Foreign keys will be used to establish relationships between related entities.

The expected relationships include:

* One customer can place many orders.
* Each order belongs to one customer.
* One category can contain many products.
* Each product belongs to one category.
* One order can contain many products.
* One product can appear in many orders.
* The `OrderItem` entity resolves the many-to-many relationship between orders and products.
* An order can have associated payment and shipping information.

---

## 7. Business Rules

The following rules will be enforced by the database system:

1. Each customer must have a unique customer ID.
2. Customer email addresses must be unique.
3. Each product must belong to a valid category.
4. A customer may place multiple orders.
5. Each order must belong to one customer.
6. An order must contain at least one order item.
7. An order item must reference a valid order and product.
8. Product prices cannot be negative.
9. Product inventory cannot be negative.
10. Order item quantities must be greater than zero.
12. Inventory should decrease when products are purchased.
13. The total order amount should be calculated from the products and quantities included in the order.
14. A customer should only review a product that they have purchased.

