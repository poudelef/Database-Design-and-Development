import sqlite3
from datetime import datetime


DATABASE = "ecommerce.db"


def connect_db():
    return sqlite3.connect(DATABASE)


def show_products():
    conn = connect_db()
    cursor = conn.cursor()

    cursor.execute("""
        SELECT ProductID, ProductName, Price, StockQuantity
        FROM Product
        ORDER BY ProductID
    """)

    products = cursor.fetchall()

    print("\nAvailable Products ---")

    for product in products:
        print(
            f"ID: {product[0]} | "
            f"{product[1]} | "
            f"${product[2]:.2f} | "
            f"Stock: {product[3]}"
        )

    conn.close()


def place_order(customer_id, product_id, quantity):
    conn = connect_db()
    cursor = conn.cursor()

    try:
        # Find the product
        cursor.execute("""
            SELECT ProductName, Price, StockQuantity
            FROM Product
            WHERE ProductID = ?
        """, (product_id,))

        product = cursor.fetchone()

        if product is None:
            print("Product not found.")
            return

        product_name, price, stock = product

        # Check quantity
        if quantity <= 0:
            print("Quantity must be greater than 0.")
            return

        # Check stock
        if stock < quantity:
            print(f"Not enough stock. Only {stock} available.")
            return

        # Calculate total
        total = price * quantity

        # Create order date
        order_date = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

        # Generate OrderID
        cursor.execute("""
            SELECT COALESCE(MAX(OrderID), 1000) + 1
            FROM Orders
        """)

        order_id = cursor.fetchone()[0]

        # Create Order
        cursor.execute("""
            INSERT INTO Orders
            (OrderID, CustomerID, OrderDate, TotalAmount, OrderStatus)
            VALUES (?, ?, ?, ?, ?)
        """, (
            order_id,
            customer_id,
            order_date,
            total,
            "Processing"
        ))

        # Generate OrderItemID
        cursor.execute("""
            SELECT COALESCE(MAX(OrderItemID), 0) + 1
            FROM OrderItem
        """)

        order_item_id = cursor.fetchone()[0]

        # Create OrderItem
        cursor.execute("""
            INSERT INTO OrderItem
            (OrderItemID, OrderID, ProductID, Quantity, UnitPrice)
            VALUES (?, ?, ?, ?, ?)
        """, (
            order_item_id,
            order_id,
            product_id,
            quantity,
            price
        ))

        # Ask for payment
        payment_success = payment(
            conn,
            order_id,
            order_date,
            price,
            total,
            product_id,
            quantity,
            product_name
        )

        if payment_success:
            conn.commit()
            print("\nTransaction completed successfully!")
        else:
            conn.rollback()
            print("\nOrder Cancelled!!!")

    except sqlite3.Error as error:
        conn.rollback()
        print("Database error:", error)

    finally:
        conn.close()

def payment(conn, order_id, order_date, price, total,
            product_id, quantity, product_name):

    print(
        f"\nOrder_ID: {order_id} | "
        f"Name: {product_name} | "
        f"Quantity: {quantity} | "
        f"Total: ${total:.2f}"
    )

    question = input("\nWould you like to continue to payment? Y/N ")

    if question.upper() != "Y":
        return False

    PaymentMethod = input("What is your PaymentMethod: ")

    cursor = conn.cursor()

    #PaymentID
    cursor.execute("""
        SELECT COALESCE(MAX(PaymentID), 0) + 1
        FROM Payment
    """)

    payment_id = cursor.fetchone()[0]

    # Create payment
    cursor.execute("""
        INSERT INTO Payment
        (PaymentID, OrderID, PaymentMethod, PaymentDate, Amount, PaymentStatus)
        VALUES (?, ?, ?, ?, ?, ?)
    """, (
        payment_id,
        order_id,
        PaymentMethod,
        order_date,
        total,
        "Paid"
    ))

    # Update stock
    cursor.execute("""
        UPDATE Product
        SET StockQuantity = StockQuantity - ?
        WHERE ProductID = ?
    """, (quantity, product_id))

    print("\n--- Order Created Successfully ---")
    print(f"Order ID: {order_id}")
    print(f"Product: {product_name}")
    print(f"Quantity: {quantity}")
    print(f"Price: ${price:.2f}")
    print(f"Total: ${total:.2f}")
    print("Payment Status: Paid")

    return True          


def show_customer_orders(customer_id):
    conn = connect_db()
    cursor = conn.cursor()

    cursor.execute("""
        SELECT
            Orders.OrderID,
            Orders.OrderDate,
            Product.ProductName,
            OrderItem.Quantity,
            Orders.TotalAmount,
            Orders.OrderStatus
        FROM Orders
        JOIN OrderItem
            ON Orders.OrderID = OrderItem.OrderID
        JOIN Product
            ON OrderItem.ProductID = Product.ProductID
        WHERE Orders.CustomerID = ?
        ORDER BY Orders.OrderDate DESC
    """, (customer_id,))

    orders = cursor.fetchall()

    print("\n--- Customer Orders ---")

    if not orders:
        print("No orders found.")
    else:
        for order in orders:
            print(
                f"Order #{order[0]} | "
                f"{order[1]} | "
                f"{order[2]} | "
                f"Quantity: {order[3]} | "
                f"Total: ${order[4]:.2f} | "
                f"Status: {order[5]}"
            )

    conn.close()

def new_customer(FirstName, LastName, Email, Phone):
    conn = connect_db()
    cursor = conn.cursor()

    RegistrationDate = datetime.now().strftime("%Y-%m-%d")

    cursor.execute("""
    SELECT COALESCE(MAX(CustomerID), 1) + 1 
    from Customer
    """)

    CustomerID = cursor.fetchone()[0]

    cursor.execute("""
    INSERT INTO Customer (CustomerID, FirstName, LastName, Email, Phone, RegistrationDate)
    VALUES
    (?,?,?,?,?,?)
    """,(CustomerID, FirstName, LastName, Email, Phone, RegistrationDate))    

    conn.commit()

    print(f"\nWelcome ${FirstName} ID: {CustomerID}! What would you like to purchase today")

    conn.close()

def validate_customer_ID(customer_ID):
    conn = connect_db()
    cursor = conn.cursor()    

    cursor.execute("""
    SELECT CustomerID, FirstName, LastName from Customer
    WHERE CustomerID = ?
    """,(customer_ID,))

    info = cursor.fetchone()
    conn.close()

    if info is None:
            print("\n No ID found!!!")
            return False

    ID, FirstName, LastName = info

    # print("\n ID found")
    # print(f"\n Hi {FirstName} {LastName}!" )
    return info


def order():
    question = input("Would you like to place an order: Y/N: ")

    if question.upper() == 'Y':
        customer_id = int(input("Enter your ID: "))

        customer_info = validate_customer_ID(customer_id)

        if customer_info is None:
            return

        customer_id, first_name, last_name = customer_info

        product_id = int(
            input("Enter the ID of product that you would like to purchase: ")
        )

        quantity = int(input("Enter Quantity: "))

        place_order(customer_id, product_id, quantity)

    else:
        print("\nSee yaa later!!")
       


def main():
    print("------------E-Commerce Database System------------")

    question = input("\nHello, Do you have your customerID ? Y/N ")
    if question == "N":
        print("\nPlease provide following information to Purchase")
        First_Name = input("FirstName: ")
        Last_Name = input("LastName: ")
        Email = input("Email: ")
        Phone = int(input("Phone: "))

        new_customer(First_Name, Last_Name, Email, Phone)
        show_products()
        print("\n")
        order()
        

    if question == "Y":
        customer_id  = int(input("\n Please Enter your Customer ID: "))

        if validate_customer_ID(customer_id):
            ID, FirstName, LastName = validate_customer_ID(customer_id)
            print("\n ID found")
            print(f"\n Hi {FirstName} {LastName}!" )
            print("\n We have following product available: ")
            show_products()
            print("\n")
            order()


    # show_products()

    # print("\nExample purchase:")
    # print("Customer: John Doe (ID 1)")
    # print("Product: Wireless Mouse (ID 102)")

    # place_order(
    #     customer_id=1,
    #     product_id=102,
    #     quantity=2
    # )

    # show_customer_orders(customer_id=1)


if __name__ == "__main__":
    main()
    # show_products()