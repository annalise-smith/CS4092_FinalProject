import mysql.connector
from datetime import date

print("Script started")
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
        print("1. View Products")
        print("2. Add Product (Staff)")
        print("3. Make Purchase (Customer)")
        print("4. View Purchases")
        print("5. Exit")

        choice = input("Select option: ")

        if choice == '1':
            view_products()
        elif choice == '2':
            add_product()
        elif choice == '3':
            make_purchase()
        elif choice == '4':
            view_purchases()
        elif choice == '5':
            print("Goodbye!")
            break
        else:
            print("Invalid option.")

def view_products():
    cursor.execute("SELECT ProductID, Name, Price, Stock FROM Product")
    products = cursor.fetchall()
    print("\n--- Product Catalog ---")
    for p in products:
        print(f"ID: {p[0]}, {p[1]} - ${p[2]} ({p[3]} in stock)")

def add_product():
    print("Come back")

def make_purchase():
    print("Come back")

def view_purchases():
    print("Come back")

main_menu()

cursor.close()
db.close()