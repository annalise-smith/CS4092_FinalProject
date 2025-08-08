import mysql.connector
from datetime import date

print("Script started")

logged_in_staff = None
logged_in_customer = None

try:
    print("Trying to connect to database...")
    db = mysql.connector.connect(
        host="localhost",
        user="annalise.smith05@gmail.com",
        password="TemporaryForCla$$1",
        database="ecommerce"
    )
    print("Connected!")

    cursor = db.cursor()
    cursor.execute("SHOW TABLES;")
    print("Connected successfully. Tables in database:")
    for table in cursor:
        print(table)

except mysql.connector.Error as err:
    print("Connection error:", err)

except Exception as e:
    print("Unexpected error:", e)

def main_menu():
    while True:
        print("\n--- E-Commerce CLI ---")
        print("1. Customer Login")
        print("2. Staff Login")
        print("3. View Products")
        print("4. Make Purchase (Customer)")
        print("5. View Purchases")
        print("6. Add Product (Staff)")
        print("7. Update Product Info (Staff)")
        print("8. Logout")
        print("9. Exit")

        choice = input("Select option: ")

        if choice == '1':
            login_customer()
        elif choice == '2':
            login_staff()
        elif choice == '3':
            view_products()
        elif choice == '4':
            make_purchase()
        elif choice == '5':
            view_purchases()
        elif choice == '6':
            add_product()
        elif choice == '7':
            update_product_info()
        elif choice == '8':
            logout()
        elif choice == '9':
            print("Goodbye!")
            break
        else:
            print("Invalid option.")

def login_customer():
    global logged_in_customer
    email = input("Customer email: ")
    # You could add password later, for now just email is enough as simple login
    cursor.execute("SELECT CustomerID, Name FROM Customer WHERE Email = %s", (email,))
    result = cursor.fetchone()
    if result:
        logged_in_customer = {'id': result[0], 'name': result[1]}
        print(f"Customer login successful! Welcome, {result[1]}.")
        return True
    else:
        print("Login failed: email not found.")
        return False

def login_staff():
    global logged_in_staff
    username = input("Staff username: ")
    password = input("Staff password: ")

    cursor.execute("SELECT StaffID FROM Staff WHERE Username = %s AND Password = %s", (username, password))
    result = cursor.fetchone()
    
    if result:
        logged_in_staff = result[0]
        print("Login successful!")
        return True
    else:
        print("Login failed.")
        return False

def view_products():
    cursor.execute("SELECT ProductID, Name, Price, Stock FROM Product")
    products = cursor.fetchall()
    print("\n--- Product Catalog ---")
    for p in products:
        print(f"ID: {p[0]}, {p[1]} - ${p[2]} ({p[3]} in stock)")

def make_purchase():
    customer_id = int(input("Customer ID: "))
    view_products()
    product_id = int(input("Enter Product ID to buy: "))
    quantity = int(input("Quantity: "))
    today = date.today()
    cursor.execute("""
        INSERT INTO Purchase (CustomerID, ProductID, PurchaseDate, Quantity)
        VALUES (%s, %s, %s, %s)
    """, (customer_id, product_id, today, quantity))
    db.commit()
    print("Purchase successful!")

def view_purchases():
    cursor.execute("""
        SELECT c.Name, p.Name, pu.Quantity, pu.PurchaseDate
        FROM Purchase pu
        JOIN Customer c ON pu.CustomerID = c.CustomerID
        JOIN Product p ON pu.ProductID = p.ProductID
    """)
    results = cursor.fetchall()
    print("\n--- Purchases ---")
    for r in results:
        print(f"{r[0]} bought {r[2]} x {r[1]} on {r[3]}")

def add_product():
    if not login_staff():
        print("You must log in as staff to add products.")
        return  

    name = input("Product name: ")
    desc = input("Description: ")
    category = input("Category: ")
    price = float(input("Price: "))
    stock = int(input("Stock quantity: "))
    cursor.execute("""
        INSERT INTO Product (Name, Description, Category, Price, Stock)
        VALUES (%s, %s, %s, %s, %s)
    """, (name, desc, category, price, stock))
    db.commit()
    print("Product added successfully.")

def update_product_info():
    global logged_in_staff
    if not logged_in_staff:
        print("You must log in as staff to update products.")
        if not login_staff():
            return

    view_products()
    try:
        product_id = int(input("Enter the Product ID to update: "))
    except ValueError:
        print("Invalid Product ID.")
        return

    cursor.execute("SELECT ProductID, Name, Price, Stock FROM Product WHERE ProductID = %s", (product_id,))
    product = cursor.fetchone()
    if not product:
        print("Product not found.")
        return

    print(f"Current Name: {product[1]}")
    new_name = input("New Name (leave blank to keep current): ")
    print(f"Current Price: {product[2]}")
    new_price_input = input("New Price (leave blank to keep current): ")
    print(f"Current Stock: {product[3]}")
    new_stock_input = input("New Stock (leave blank to keep current): ")

    new_name = new_name.strip() if new_name.strip() else product[1]
    try:
        new_price = float(new_price_input) if new_price_input.strip() else product[2]
    except ValueError:
        print("Invalid price entered. Update cancelled.")
        return
    try:
        new_stock = int(new_stock_input) if new_stock_input.strip() else product[3]
    except ValueError:
        print("Invalid stock quantity entered. Update cancelled.")
        return
    
    try:
        cursor.execute("""
            UPDATE Product
            SET Name = %s, Price = %s, Stock = %s
            WHERE ProductID = %s
        """, (new_name, new_price, new_stock, product_id))
        db.commit()
        print("Product updated successfully.")
    except mysql.connector.Error as err:
        print("Error updating product:", err)

def logout():
    global logged_in_staff, logged_in_customer
    if logged_in_staff:
        print("Staff logged out.")
        logged_in_staff = None
    if logged_in_customer:
        print("Customer logged out.")
        logged_in_customer = None
    if not logged_in_staff and not logged_in_customer:
        print("No user currently logged in.")

main_menu()

cursor.close()
db.close()